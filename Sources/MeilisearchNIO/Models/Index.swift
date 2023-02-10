import Foundation

public struct Index: Codable, Equatable {
  /// The index uid.
  public let uid: String

  /// The data when the index was created.
  public let createdAt: Date?

  /// The data when the index was last updated.
  public let updatedAt: Date?

  /// The primary key configured for the index.
  public let primaryKey: String?

  // MARK: Initializers

  init(
    uid: String,
    createdAt: Date? = nil,
    updatedAt: Date? = nil,
    primaryKey: String? = nil
  ) {
    self.uid = uid
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.primaryKey = primaryKey
  }
}
