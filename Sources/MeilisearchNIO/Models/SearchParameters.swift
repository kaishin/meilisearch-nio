import Foundation

public struct SearchParameters: Codable, Equatable {
  /// Query string (mandatory).
  public let query: String

  /// Number of documents to take.
  public let limit: Int

  /// Number of documents to skip.
  public let offset: Int

  /// Document attributes to show.
  public let attributesToRetrieve: [String]

  /// Which attributes to crop.
  public let attributesToCrop: [String]?

  /// Length used to crop field values.
  public let cropLength: Int

  /// Attributes whose values will contain highlighted matching terms.
  public let attributesToHighlight: [String]?

  /// Filter queries by an attribute value.
  public let filter: String?

  /// Sort search results according to the attributes and sorting order (`asc` or `desc`) specified
  public let sort: [String]?

  /// Retrieve the count of matching terms for each facets.
  public let facetsDistribution: [String]?

  /// Defines whether an object that contains information about the matches should be returned or not.
  public let matches: Bool

  public init(
    query: String = "",
    offset: Int = 0,
    limit: Int = 20,
    attributesToRetrieve: [String] = ["*"],
    attributesToCrop: [String]? = nil,
    cropLength: Int = 200,
    attributesToHighlight: [String]? = nil,
    filter: String? = nil,
    sort: [String]? = nil,
    facetsDistribution: [String]? = nil,
    matches: Bool = false
  ) {
    self.query = query
    self.offset = offset
    self.limit = limit
    self.attributesToRetrieve = attributesToRetrieve
    self.attributesToCrop = attributesToCrop
    self.cropLength = cropLength
    self.attributesToHighlight = attributesToHighlight
    self.filter = filter
    self.sort = sort
    self.facetsDistribution = facetsDistribution
    self.matches = matches
  }

  public static func query(_ value: String) -> Self {
    .init(query: value)
  }

  enum CodingKeys: String, CodingKey {
    case query = "q"
    case offset,
         limit,
         attributesToRetrieve,
         attributesToCrop,
         cropLength,
         attributesToHighlight,
         filter,
         sort,
         facetsDistribution,
         matches
  }
}
