import Foundation

public struct SearchParameters: Encodable, Hashable {
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

  /// A list of searchable attributes written as an array. Defaults to ["*"]
  /// Note: Attributes passed passed must also be present in the searchableAttributes list.
  public let attributesToSearchOn: [String]?

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

  /// Whether to return the search ranking score or not.
  public let showRankingScore: Bool?

  /// Filter on attributes values.
  public let filter: String?

  /// Sort search results according to the attributes and sorting order (`asc` or `desc`) specified
  public let sort: [String]?

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
    attributesToSearchOn: [String]? = nil,
    cropLength: Int? = nil,
    cropMarker: String? = nil,
    attributesToHighlight: [String]? = nil,
    highlightPreTag: String? = nil,
    highlightPostTag: String? = nil,
    showMatchesPosition: Bool? = nil,
    showRankingScore: Bool? = nil,
    filter: String? = nil,
    sort: [String]? = nil,
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
    self.attributesToSearchOn = attributesToSearchOn
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
    self.showRankingScore = showRankingScore
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
      attributesToSearchOn,
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
      showRankingScore,
      sort
  }
}
