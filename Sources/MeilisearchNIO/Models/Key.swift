import Foundation

public struct Key: Codable, Equatable {
  public let name: String?
  public let description: String?
  public let uid: String
  public let key: String
  public let actions: [Action]?
  public let indexes: [String]?
  public let expiresAt: Date?
  public let createdAt: Date
  public let updatedAt: Date
}

extension Key {
  public struct CreatePayload: Codable {
    public let name: String?
    public let description: String?
    public let uid: String?
    public let actions: [Action]
    public let indexes: [String]
    public let expiresAt: Date

    public init(
      name: String? = nil,
      description: String? = nil,
      uid: String? = nil,
      actions: [Action],
      indexes: [String],
      expiresAt: Date
    ) {
      self.name = name
      self.description = description
      self.uid = uid
      self.actions = actions
      self.indexes = indexes
      self.expiresAt = expiresAt
    }
  }

  public struct UpdatePayload: Codable {
    public let name: String?
    public let description: String?

    public init(
      name: String? = nil,
      description: String? = nil
    ) {
      self.name = name
      self.description = description
    }
  }
}
