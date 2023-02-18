import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeilisearchClient {
  /// Get stats of an index.
  /// - Parameters:
  ///   - indexID: The index UID to search in.
  ///   - eventLoop: The event loop to run the query on.
  /// - Returns: Stats of a specific index.
  public func getIndexStats(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> IndexStats {
    try await send(
      .indexes / indexID / .stats,
      on: eventLoop
    )
  }
  /// Get stats of all indexes.
  /// - Parameters:
  ///   - eventLoop: The event loop to run the query on.
  /// - Returns: Stats of all indexes.
  public func getAll(
    on eventLoop: EventLoop? = nil
  ) async throws -> Stats {
    try await send(
      .stats,
      on: eventLoop
    )
  }
}

