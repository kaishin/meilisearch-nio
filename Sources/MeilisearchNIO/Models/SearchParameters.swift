import Foundation

public struct SearchParameters: Encodable, Hashable {
  public enum Filter: Encodable, Hashable {
    case string(String)
    case array([String])

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

  public enum MatchingStrategy: String, Encodable, Hashable {
    case all
    case last
  } 

  /// Query string.
  public let query: String?

  /// Number of documents to take.
  public let limit: Int?

  /// Number of documents to skip.
  public let offset: Int?

  /// Request a specific page of results.
  public let page: Int?

  /// Maximum number of documents returned for a page.
  public let hitsPerPage: Int?

  /// Document attributes to show.
  public let attributesToRetrieve: [String]?

  /// Which attributes to crop.
  public let attributesToCrop: [String]?

  /// Length used to crop field values.
  public let cropLength: Int?

  /// Sets a string to mark crop boundaries.
  public let cropMarker: String?

  /// Attributes whose values will contain highlighted matching terms.
  public let attributesToHighlight: [String]?

  /// The string to be inserted before a highlighted word.
  public let highlightPreTag: String?

  /// The string to be inserted after a highlighted word.
  public let highlightPostTag: String?

  /// Adds a _matchesPosition object to the search response that contains the location of each occurrence of queried terms across all fields.
  /// SeeAlso: [Official Documentation](https://docs.meilisearch.com/reference/api/search.html#show-matches-position)
  public let showMatchesPosition: Bool?

  /// Filter queries by an attribute value.
  public let filter: Filter?

  /// Sort search results according to the attributes and sorting order (`asc` or `desc`) specified
  public let sort: Filter?

  /// Retrieve the count of matching terms for each facet.
  public let facets: [String]?

  /// Defines whether an object that contains information about the matches should be returned or not.
  public let matchingStrategy: MatchingStrategy?

  public init(
    query: String? = nil,
    offset: Int? = nil,
    limit: Int? = nil,
    page: Int? = nil,
    hitsPerPage: Int? = nil,
    attributesToRetrieve: [String]? = nil,
    attributesToCrop: [String]? = nil,
    cropLength: Int? = nil,
    cropMarker: String? = nil,
    attributesToHighlight: [String]? = nil,
    highlightPreTag: String? = nil,
    highlightPostTag: String? = nil,
    showMatchesPosition: Bool? = nil,
    filter: Filter? = nil,
    sort: Filter? = nil,
    facets: [String]? = nil,
    matchingStrategy: MatchingStrategy? = nil
  ) {
    self.query = query
    self.offset = offset
    self.limit = limit
    self.page = page
    self.hitsPerPage = hitsPerPage
    self.attributesToRetrieve = attributesToRetrieve
    self.attributesToCrop = attributesToCrop
    self.cropLength = cropLength
    self.cropMarker = cropMarker
    self.attributesToHighlight = attributesToHighlight
    self.filter = filter
    self.sort = sort
    self.facets = facets
    self.matchingStrategy = matchingStrategy
    self.highlightPreTag = highlightPreTag
    self.highlightPostTag = highlightPostTag
    self.showMatchesPosition = showMatchesPosition
  }

  public static func query(_ value: String) -> Self {
    .init(query: value)
  }

  enum CodingKeys: String, CodingKey {
    case query = "q"
    case offset,
      attributesToCrop,
      attributesToHighlight,
      attributesToRetrieve,
      cropLength,
      cropMarker,
      facets,
      filter,
      highlightPreTag,
      highlightPostTag,
      hitsPerPage,
      limit,
      matchingStrategy,
      page,
      showMatchesPosition,
      sort
  }
}
