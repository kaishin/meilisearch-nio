import Foundation

public struct GetParameters: Codable, Equatable {
  /// Number of documents to take.
  public let limit: Int

  /// Number of documents to skip.
  public let offset: Int

  /// Document attributes to show.
  public let attributesToRetrieve: [String]

  public init(
    offset: Int = 0,
    limit: Int = 20,
    attributesToRetrieve: [String] = ["*"]
  ) {
    self.offset = offset
    self.limit = limit
    self.attributesToRetrieve = attributesToRetrieve
  }

  func toQueryParameters() -> [String: String] {
    var queries = [String: String]()

      queries["offset"] = offset.description
      queries["limit"] = limit.description
      queries["attributesToRetrieve"] = attributesToRetrieve.joined(separator: ",")

    return queries
  }
}
