import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeilisearchClient {
  /// Get the status of an update in a given index.
  /// - Parameters:
  ///   - taskID: The ID of the update.
  ///   - indexUID: The UID of the index.
  ///   - eventLoop: The event loop to run the query on.
  /// - Returns: The update status result.
  /// - SeeAlso: [Online documentation](https://docs.meilisearch.com/reference/api/updates.html#get-an-update-status)
  public func getTaskStatus(
    for taskID: Int,
    in indexUID: String? = nil,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      indexUID.map { .indexes / $0 / .tasks / taskID } ?? .tasks / taskID,
      on: eventLoop
    )
  }

  /// Get the status of an update in a given index.
  /// - Parameters:
  ///   - indexUID: The UID of the index.
  ///   - eventLoop: The event loop to run the query on.
  /// - Returns: An array of update status results.
  /// - SeeAlso: [Online documentation](https://docs.meilisearch.com/reference/api/updates.html#get-all-update-status)
  public func getAllTasks(
    in indexUID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [MeiliTask] {
    try await send(
      .indexes / indexUID / .tasks,
      on: eventLoop
    )
  }

  @discardableResult
  public func waitForPendingTask(
    for task: MeiliTask,
    in indexUID: String? = nil,
    options: WaitOptions? = nil,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await checkStatus(
      for: task,
      in: indexUID,
      options: options ?? .init(),
      startingDate: .init(),
      on: eventLoop
    )
  }

  private func checkStatus(
    for task: MeiliTask,
    in indexUID: String?,
    options: WaitOptions,
    startingDate: Date,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    let result = try await getTaskStatus(for: task.uid, in: indexUID, on: eventLoop)
    if result.status.isCompleted {
      return result
    } else if 0 - startingDate.timeIntervalSinceNow > options.timeOut {
      throw MeilisearchError.timeOut(timeOut: options.timeOut)
    } else {
      try await Task.sleep(nanoseconds: UInt64(options.interval) * 1_000_000_000)
      return try await checkStatus(for: task, in: indexUID, options: options, startingDate: startingDate, on: eventLoop)
    }
  }
}
