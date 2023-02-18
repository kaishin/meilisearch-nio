import Foundation
import NIO
import NIOHTTP1

extension MeilisearchClient {
  /// Get the private and public key.
  ///
  /// - Warning: You must have the master key to access this route.
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/keys.html#get-keys)
  public func getAllKeys(
    masterKey: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> Page<Key> {
    try await send(
      .keys,
      bearerAuth(masterKey),
      on: eventLoop
    )
  }

  /// Get information on the specified key. Attempting to use this endpoint with a non-existent or deleted key will result in an error.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/keys.html#get-one-key)
  public func getOneKey(
    keyOrUid: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> Key {
    try await send(
      .keys / keyOrUid,
      on: eventLoop
    )
  }

  /// Create an API key with the provided description, permissions, and expiration date.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/reference/api/keys.html#create-a-key)
  public func createKey(
    _ key: Key.CreatePayload,
    on eventLoop: EventLoop? = nil
  ) async throws -> Key {
    try await send(
      .keys,
      post(body: key),
      on: eventLoop
    )
  }

  /// Update the name and description of an API key. Any fields not present in the payload will remain unchanged.
  ///
  /// - SeeAlso: [Official Documentation](https://docs.meilisearch.com/reference/api/keys.html#update-a-key)
  public func updateKey(
    keyOrUid: String,
    _ payload: Key.UpdatePayload,
    on eventLoop: EventLoop? = nil
  ) async throws -> Key {
    try await send(
      .keys / keyOrUid,
      patch(body: payload),
      on: eventLoop
    )
  }
    /// Delete the specified API key.
  ///
  /// - SeeAlso: [Official Documentation](https://docs.meilisearch.com/reference/api/keys.html#delete-a-key)
  public func deleteKey(
    keyOrUid: String,
    _ payload: Key.UpdatePayload,
    on eventLoop: EventLoop? = nil
  ) async throws {
    try await sendIgnoringResponseData(
      .keys / keyOrUid,
      patch(body: payload),
      on: eventLoop
    )
  }
}
