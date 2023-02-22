import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeilisearchClient {
  /// List all tasks globally, regardless of index. 
  /// - Parameters:
  ///   - eventLoop: The event loop to run the query on.
  /// - Returns: An paged collection of tasks.
  /// - SeeAlso: [Online documentation](https://docs.meilisearch.com/reference/api/tasks.html#get-tasks)
  public func getAllTasks(
    with parameters: GetTaskQueryParameters = .init(),
    on eventLoop: EventLoop? = nil
  ) async throws -> Page<OperationTask> {
    try await send(
      .tasks,
      on: eventLoop
    ) {
      requestQueries(parameters.toQueryParameters())
    }
  }

  /// Get a single task.
  /// - Parameters:
  ///   - taskID: The ID of the task.
  ///   - eventLoop: The event loop to run the query on.
  /// - Returns: The task details.
  /// - SeeAlso: [Online documentation](https://docs.meilisearch.com/reference/api/tasks.html#get-one-task)
  public func getTask(
    id: Int,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask {
    try await send(
      .tasks / id,
      on: eventLoop
    )
  }

  /// Cancel any number of enqueued or processing tasks based on their uid, status, type, indexUid, or the date at which they were enqueued, processed, or completed. Task cancellation is an atomic transaction: either all tasks are successfully deleted, or none are.
  ///
  /// - Parameters:
  ///   - taskID: The ID of the task.
  ///   - eventLoop: The event loop to run the query on.
  /// - Returns: The cancellation task reference.
  /// - SeeAlso: [Online documentation](https://docs.meilisearch.com/reference/api/tasks.html#cancel-tasks)
  public func cancelTask(
    taskID: Int,
    parameters: CancelTaskQueryParameters = .init(),
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      URLPath.tasks / .cancel,
      on: eventLoop
    ) {
      requestQueries(parameters.toQueryParameters())
    }
  }

  /// Delete a finished (succeeded, failed, or canceled) task based on uid, status, type, indexUid, canceledBy, or date. Task deletion is an atomic transaction: either all tasks are successfully deleted, or none are.
  ///
  /// - Parameters:
  ///   - taskID: The ID of the task.
  ///   - eventLoop: The event loop to run the query on.
  /// - Returns: The cancellation task reference.
  /// - SeeAlso: [Online documentation](https://docs.meilisearch.com/reference/api/tasks.html#cancel-tasks)
  public func deleteTask(
    taskID: Int,
    parameters: DeleteTaskQueryParameters = .init(),
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      URLPath.tasks / .cancel,
      on: eventLoop
    ) {
      requestQueries(parameters.toQueryParameters())
    }
  }
}
