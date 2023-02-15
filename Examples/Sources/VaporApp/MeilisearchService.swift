import MeilisearchNIO
import Vapor

// MARK: - Application
extension Application {
  struct MeilisearchClientKey: StorageKey {
    typealias Value = MeilisearchClient
  }

  public var meilisearch: MeilisearchClient {
    get {
      guard
        let client = storage[MeilisearchClientKey.self]
      else {
        fatalError("MeilisearchClient is not setup. Set application.meilisearch first.")
      }

      return client
    }

    set {
      storage.set(MeilisearchClientKey.self, to: newValue)
    }
  }
}

// MARK: - Request Extensions
extension Request {
  public var meilisearch: MeilisearchClient {
    application.meilisearch
  }
}

// MARK: - Content
extension Index: Content {}
extension Page: Content {}

