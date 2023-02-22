import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

extension MeilisearchClient {
  /// Get a set of documents.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/documents.html#get-documents)
  public func getAllDocuments<T: Decodable>(
    with getParameters: GetParameters = .init(),
    in indexUid: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> Page<T> {
    try await send(
      .indexes / indexUid / .documents,
      on: eventLoop
    ) {
      requestQueries(getParameters.toQueryParameters())
    }
  }

  /// Get one document using its unique id.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/documents.html#get-one-document)
  public func getDocument<T>(
    withID documentID: T.ID,
    in indexUid: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> T
  where
    T: Codable,
    T: Equatable,
    T: Identifiable,
    T.ID: CustomStringConvertible
  {
    try await send(
      .indexes / indexUid / .documents / documentID.description,
      on: eventLoop
    )
  }

  /// Add an array of documents or replace them if they already exist. If the provided index does not exist, it will be created.
  ///
  /// If you send an already existing document (same document id) the whole existing document will be overwritten by the new document. Fields that are no longer present in the new document are removed.
  @discardableResult
  public func addOrReplaceDocuments<T>(
    _ documents: [T],
    to indexUid: String,
    primaryKey: String? = nil,
    encoder: JSONEncoder = defaultJSONEncoder,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference where T: Encodable, T: Equatable {
    try await send(
      .indexes / indexUid / .documents,
      on: eventLoop
    ) {
      post(body: documents, encoder: encoder)

      if let primaryKey {
        requestQueries(["primaryKey": primaryKey])
      }
    }
  }

  /// Add a list of documents or update them if they already exist. If the provided index does not exist, it will be created.
  ///
  /// If you send an already existing document (same document id) the old document will be only partially updated according to the fields of the new document. Thus, any fields not present in the new document are kept and remain unchanged.
  @discardableResult
  public func addOrUpdateDocuments<T>(
    _ documents: [T],
    to indexUid: String,
    primaryKey: String? = nil,
    encoder: JSONEncoder = defaultJSONEncoder,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference where T: Encodable, T: Equatable {
    try await send(
      .indexes / indexUid / .documents,
      on: eventLoop
    ) {
      post(body: documents, encoder: encoder)

      if let primaryKey {
        requestQueries(["primaryKey": primaryKey])
      }
    }
  }

  /// Delete one document based on its unique id.
  @discardableResult
  public func delete(
    documentID: String,
    in indexUid: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexUid / .documents / documentID,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }

  /// Delete all documents in the specified index.
  @discardableResult
  public func deleteAll(
    in indexUid: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask {
    try await send(
      .indexes / indexUid / .documents,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }

  /// Delete a selection of documents based on an array of document IDs.
  @discardableResult
  public func deleteBatch<T>(
    _ documentIDs: [T],
    in indexUid: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference
  where T: Encodable {
    try await send(
      .indexes / indexUid / .documents / .deleteBatch,
      on: eventLoop
    ) {
      post(body: documentIDs)
    }
  }
}

extension MeilisearchClient {
  @discardableResult
  public func addOrReplaceDocument<T>(
    _ document: T,
    to indexUid: String,
    primaryKey: String? = nil,
    encoder: JSONEncoder = defaultJSONEncoder,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference where T: Encodable, T: Equatable {
    try await addOrReplaceDocuments(
      [document],
      to: indexUid,
      primaryKey: primaryKey,
      encoder: encoder,
      on: eventLoop
    )
  }

  @discardableResult
  public func addOrUpdateDocument<T>(
    _ document: T,
    to indexUid: String,
    primaryKey: String? = nil,
    encoder: JSONEncoder = defaultJSONEncoder,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference where T: Encodable, T: Equatable {
    try await addOrUpdateDocuments(
      [document],
      to: indexUid,
      primaryKey: primaryKey,
      encoder: encoder,
      on: eventLoop
    )
  }
}
