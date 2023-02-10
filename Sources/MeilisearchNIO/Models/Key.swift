import Foundation

public struct Key: Codable, Equatable {
  public var description: String?
  public var key: String
  public var actions: [Action]
  public var indexes: [String]
  public var expiresAt: Date?
  public var createdAt: Date
  public var updatedAt: Date
}
