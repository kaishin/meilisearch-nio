import Foundation

public struct Health: Codable, Equatable {
  /// Status of the MeiliSearch server
  public let status: String
}
