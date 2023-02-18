import Foundation

public struct Page<T: Decodable>: Decodable {
  /// An array of resources
  public let results: [T]

  /// Number of resources skipped
  public let offset: Int

  /// Number of resources returned
  public let limit: Int

  /// Total number of resources
  public let total: Int
}
