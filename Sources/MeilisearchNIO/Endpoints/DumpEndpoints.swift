import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeilisearchClient {
  /// Triggers a dump creation process. Once the process is complete, a dump is created in the dumps directory. If the dumps directory does not exist yet, it will be created.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/dump.html#create-a-dump)
  public func createDump(
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .dumps,
      on: eventLoop
    ) {
      postRequest
    }
  }
}
