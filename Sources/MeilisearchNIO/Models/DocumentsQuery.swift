import Foundation

public struct DocumentsQuery: Encodable, Equatable {
  public enum Filter: Encodable, Hashable {
    case string(String)
    case array([[String]])

    public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()

      switch self {
      case .string(let value):
        try container.encode(value)

      case .array(let value):
        try container.encode(value)
      }
    }
  }

  public let offset: Int?
  public let limit: Int?
  public let fields: [String]?
  public let filter: Filter?
}
