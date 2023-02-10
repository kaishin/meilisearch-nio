import Foundation
import NIOHTTP1
import NIO

extension MeiliSearchClient {
  /// Get the private and public key.
  ///
  /// - Warning: You must have the master key to access this route.
  ///
  /// - More: [Official documentation](https://docs.meilisearch.com/reference/api/keys.html#get-keys)
  public func getKeys(
    masterKey: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [Key] {
    try await send(
      .keys,
      bearerAuth(masterKey),
      on: eventLoop
    )
  }
}
