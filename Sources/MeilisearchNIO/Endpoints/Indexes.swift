import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeilisearchClient {
  /// Get information about an index.
  ///
  /// [Official documentation]( https://docs.meilisearch.com/reference/api/indexes.html#get-one-index)
  public func getIndex(
    _ indexUID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> Index {
    try await send(
      .indexes / indexUID,
      on: eventLoop
    )
  }

  /// List all indexes.
  ///
  /// [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#list-all-indexes)
  public func listIndexes(
    _ indexUID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [Index] {
    try await send(
      .indexes,
      on: eventLoop
    )
  }

  /// Create an index.
  ///
  /// [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#create-an-index)
  @discardableResult
  public func createIndex(
    _ indexUID: String,
    primaryKey: String? = nil,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    let payload = CreateIndexPayload(
      uid: indexUID,
      primaryKey: primaryKey
    )

    return try await createIndex(
      payload,
      on: eventLoop
    )
  }

  /// Create an index.
  ///
  /// [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#create-an-index)
  @discardableResult
  public func createIndex(
    _ payload: CreateIndexPayload,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes,
      post(body: payload),
      on: eventLoop
    )
  }

  /// Update an index.
  ///
  /// [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#update-an-index)
  @discardableResult
  public func updateIndex(
    _ indexUID: String,
    primaryKey: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> Index {
    let payload = UpdateIndexPayload(primaryKey: primaryKey)

    return try await send(
      .indexes / indexUID,
      put(body: payload),
      on: eventLoop
    )
  }

  /// Delete an index.
  ///
  /// [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#delete-an-index)
  public func deleteIndex(
    _ indexUID: String,
    on eventLoop: EventLoop? = nil
  ) async throws {
    return try await send(
      .indexes / indexUID,
      deleteRequest,
      on: eventLoop
    )
  }
}
