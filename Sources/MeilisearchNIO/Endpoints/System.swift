import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeilisearchClient {
  /// Get health of Meilisearch server.
  /// - Parameters:
  ///   - eventLoop: The event loop to run the query on.
  /// - Returns: The health status.
  /// - SeeAlso: [Online documentation](https://docs.meilisearch.com/reference/api/health.html#get-health)
  public func getHealth(
    on eventLoop: EventLoop? = nil
  ) async throws -> Health {
    try await send(
      .health,
      on: eventLoop
    )
  }

  /// Get version of Meilisearch.
  /// - Parameters:
  ///   - eventLoop: The event loop to run the query on.
  /// - Returns: The version number.
  /// - SeeAlso: [Online documentation](https://docs.meilisearch.com/reference/api/version.html#get-version-of-meilisearch)
  public func getVersion(
    on eventLoop: EventLoop? = nil
  ) async throws -> Version {
    try await send(
      .version,
      on: eventLoop
    )
  }
}
