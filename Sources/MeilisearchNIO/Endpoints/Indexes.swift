import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeilisearchClient {
  /// List all indexes. Results can be paginated by using the offset and limit query parameters.
  ///
  /// [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#list-all-indexes)
  public func listIndexes(
    on eventLoop: EventLoop? = nil,
    offset: Int = 0,
    limit: Int = 20
  ) async throws -> Page<Index> {
    try await send(
      .indexes,
      requestQueries(
        ["offset": offset.description, "limit": limit.description]
      ),
      on: eventLoop
    )
  }

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

  /// Create an index.
  ///
  /// [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#create-an-index)
  @discardableResult
  public func createIndex(
    _ indexUID: String,
    primaryKey: String? = nil,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
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
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes,
      post(body: payload),
      on: eventLoop
    )
  }

  /// Update an index. You can freely update the primary key of an index as long as it contains no documents.
  ///
  /// [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#update-an-index)
  @discardableResult
  public func updateIndex(
    _ indexUID: String,
    primaryKey: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    let payload = UpdateIndexPayload(primaryKey: primaryKey)

    return try await send(
      .indexes / indexUID,
      patch(body: payload),
      on: eventLoop
    )
  }

  /// Delete an index.
  ///
  /// [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#delete-an-index)
  public func deleteIndex(
    _ indexUID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    return try await send(
      .indexes / indexUID,
      deleteRequest,
      on: eventLoop
    )
  }

  /// Swap the documents, settings, and task history of two or more indexes.
  ///
  /// [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#swap-indexes)
  public func swapIndexes(
    from fromUid: String,
    to toUid: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    let payload = SwapIndexes(indexes: [fromUid, toUid])

    return try await send(
      .swapIndexes,
      post(body: payload),
      on: eventLoop
    )
  }
}
