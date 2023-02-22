import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeilisearchClient {
  /// List all indexes. Results can be paginated by using the offset and limit query parameters.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#list-all-indexes)
  public func listIndexes(
    on eventLoop: EventLoop? = nil,
    offset: Int = 0,
    limit: Int = 20
  ) async throws -> Page<Index> {
    try await send(
      .indexes,
      on: eventLoop
    ) {
      requestQueries(
        ["offset": offset.description, "limit": limit.description]
      )
    }
  }

  /// Get information about an index.
  ///
  /// - SeeAlso: [Official documentation]( https://docs.meilisearch.com/reference/api/indexes.html#get-one-index)
  public func getIndex(
    _ indexUid: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> Index {
    try await send(
      .indexes / indexUid,
      on: eventLoop
    )
  }

  /// Create an index.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#create-an-index)
  @discardableResult
  public func createIndex(
    _ indexUid: String,
    primaryKey: String? = nil,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    let payload = Index.CreatePayload(
      uid: indexUid,
      primaryKey: primaryKey
    )

    return try await createIndex(
      payload,
      on: eventLoop
    )
  }

  /// Create an index.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#create-an-index)
  @discardableResult
  public func createIndex(
    _ payload: Index.CreatePayload,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes,
      on: eventLoop
    ) {
      post(body: payload)
    }
  }

  /// Update an index. You can freely update the primary key of an index as long as it contains no documents.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#update-an-index)
  @discardableResult
  public func updateIndex(
    _ indexUid: String,
    primaryKey: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    let payload = Index.UpdatePayload(primaryKey: primaryKey)

    return try await send(
      .indexes / indexUid,
      on: eventLoop
    ) {
      patch(body: payload)
    }
  }

  /// Delete an index.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#delete-an-index)
  public func deleteIndex(
    _ indexUid: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    return try await send(
      .indexes / indexUid,
      on: eventLoop
    ) {
      deleteRequest
    }
  }

  /// Swap the documents, settings, and task history of two or more indexes.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/indexes.html#swap-indexes)
  public func swapIndexes(
    from fromUid: String,
    to toUid: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    let payload = SwapIndexes(indexes: [fromUid, toUid])

    return try await send(
      .swapIndexes,
      on: eventLoop
    ) {
      post(body: payload)
    }
  }
}
