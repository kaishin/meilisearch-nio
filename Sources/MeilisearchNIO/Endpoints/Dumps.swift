import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeiliSearchClient {
  /// Triggers a dump creation process. Once the process is complete, a dump is created in the dumps directory. If the dumps directory does not exist yet, it will be created.
  ///
  /// **MeiliSearch only processes one dump at a time**. If you attempt to create a dump while another dump is still processing, MeiliSearch will throw an error. While a dump is processing, the update queue is paused and no write operations can occur on the database.
  ///
  /// [Official documentation](https://docs.meilisearch.com/reference/api/dump.html#create-a-dump)
  public func createDump(
    on eventLoop: EventLoop? = nil
  ) async throws -> Dump {
    try await send(
      .dumps,
      postRequest,
      on: eventLoop
    )
  }

  /// Get the status of a dump creation process using the uid returned after calling the dump creation route.
  ///
  /// The returned status could be:
  /// - `in_progress`: Dump creation is in progress
  /// - `failed`: An error occurred during dump process, and the task was aborted
  /// - `done`: Dump creation is finished and was successful
  ///
  /// [Official documentation](https://docs.meilisearch.com/reference/api/dump.html#get-dump-status)
  public func getDumpStatus(
    with dumpID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> Dump {
    try await send(
      .dumps / dumpID / .status,
      on: eventLoop
    )
  }
}
