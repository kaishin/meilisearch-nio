import Foundation

public struct Health: Codable, Equatable {
  /// Status of the Meilisearch server
  public let status: String
}
