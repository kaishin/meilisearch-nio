import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeilisearchClient {
  public func getDocument<T>(
    _ documentID: String,
    in indexUID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> T where T: Codable, T: Equatable {
    try await send(
      .indexes / indexUID / .documents / documentID,
      on: eventLoop
    )
  }

  public func getAllDocuments<T>(
    with getParameters: GetParameters,
    in indexUID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [T] where T: Codable, T: Equatable {
    try await send(
      .indexes / indexUID / .documents,
      requestQueries(getParameters.toQueryParameters()),
      on: eventLoop
    )
  }

  @discardableResult
  public func add(
    _ data: Data,
    to indexUID: String,
    primaryKey: String? = nil,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexUID / .documents,
      pipe(
        post(body: data),
        primaryKey == nil ?
        identity : requestQueries(["primaryKey": primaryKey!])
      ),
      on: eventLoop
    )
  }

  @discardableResult
  public func add<T>(
    _ document: T,
    to indexUID: String,
    primaryKey: String? = nil,
    encoder: JSONEncoder = defaultJSONEncoder,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask where T: Encodable, T: Equatable {
    try await addOrReplaceDocuments(
      [document],
      to: indexUID,
      primaryKey: primaryKey,
      encoder: encoder,
      on: eventLoop
    )
  }

  @discardableResult
  public func update<T>(
    _ document: T,
    to indexUID: String,
    primaryKey: String? = nil,
    encoder: JSONEncoder = defaultJSONEncoder,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask where T: Encodable, T: Equatable {
    try await addOrUpdateDocuments(
      [document],
      to: indexUID,
      primaryKey: primaryKey,
      encoder: encoder,
      on: eventLoop
    )
  }

  @discardableResult
  public func addOrReplaceDocuments<T>(
    _ documents: [T],
    to indexUID: String,
    primaryKey: String? = nil,
    encoder: JSONEncoder = defaultJSONEncoder,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask where T: Encodable, T: Equatable {
    try await send(
      .indexes / indexUID / .documents,
      pipe(
        post(body: documents, encoder: encoder),
        primaryKey == nil ?
        identity : requestQueries(["primaryKey": primaryKey!])
      ),
      on: eventLoop
    )
  }

  @discardableResult
  public func addOrUpdateDocuments<T>(
    _ documents: [T],
    to indexUID: String,
    primaryKey: String? = nil,
    encoder: JSONEncoder = defaultJSONEncoder,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask where T: Encodable, T: Equatable {
    try await send(
      .indexes / indexUID / .documents,
      pipe(
        put(body: documents, encoder: encoder),
        primaryKey == nil ?
        identity : requestQueries(["primaryKey": primaryKey!])
      ),
      on: eventLoop
    )
  }

  @discardableResult
  public func delete(
    documentID: String,
    in indexUID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexUID / .documents / documentID,
      requestMethod(.DELETE),
      on: eventLoop
    )
  }

  @discardableResult
  public func deleteAll(
    in indexUID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexUID / .documents,
      requestMethod(.DELETE),
      on: eventLoop
    )
  }

  @discardableResult
  public func deleteMany<T>(
    _ documentIDs: [T],
    in indexUID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask
  where T: Encodable {
    try await send(
      .indexes / indexUID / .documents / .deleteBatch,
      post(body: documentIDs),
      on: eventLoop
    )
  }
}
