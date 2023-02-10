import Foundation

public struct CreateIndexPayload: Codable {
  public let uid: String
  public let primaryKey: String?

  public init(uid: String, primaryKey: String? = nil) {
    self.uid = uid
    self.primaryKey = primaryKey
  }
}
