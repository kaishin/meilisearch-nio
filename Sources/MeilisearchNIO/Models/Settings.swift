import Foundation

public struct Settings: Codable, Hashable {
  /// Typo tolerance helps users find relevant results even when their search queries contain spelling mistakes or typos.
  ///
  /// - SeeAlso: [Official documentation](https://docs.meilisearch.com/learn/configuration/typo_tolerance.html#configuring-typo-tolerance)
  public struct TypoTolerance: Codable, Hashable {
    /// The typo tolerance setting.
    public struct MinWordSizeForTypos: Codable, Hashable {
      /// The minimum word size for accepting 1 typo; must be between 0 and twoTypos.
      let oneTypo: Int?

      /// The minimum word size for accepting 2 typos; must be between oneTypo and 255.
      let twoTypos: Int?
    }

    /// Whether typo tolerance is enabled or not.
    public let enabled: Bool?

    /// The minimum word size for accepting typos.
    public let minWordSizeForTypos: MinWordSizeForTypos?

    /// An array of words for which the typo tolerance feature is disabled.
    public let disableOnWords: [String]?

    /// An array of attributes for which the typo tolerance feature is disabled.
    public let disableOnAttributes: [String]?
  }

  /// The pagination setting.
  public struct Pagination: Codable, Hashable {
    public let maxTotalHits: Int
  }

  /// The faceting setting.
  public struct Faceting: Codable, Hashable {
    public let maxValuesPerFacet: Int
  }

  /// List of ranking rules for a given `Index`.
  public let rankingRules: [String]?

  /// Optional distinct attribute set for a given `Index`.
  public let distinctAttribute: String?

  /// List of searchable attributes for a given `Index`.
  public let searchableAttributes: [String]?

  /// List of displayed attributes for a given `Index`.
  public let displayedAttributes: [String]?

  /// List of stop-words for a given `Index`.
  public let stopWords: [String]?

  /// List of synonyms and its values for a given `Index`.
  public let synonyms: [String: [String]]?

  /// List of attributes used for filtering
  public let filterableAttributes: [String]?

  /// List of attributes used for sorting
  public let sortableAttributes: [String]?

  /// Typo tolerance settings
  public let typoTolerance: TypoTolerance?

  /// Max hits per query response.
  public let pagination: Pagination?

  /// Faceting settings.
  public let faceting: Faceting?

  public init(
    rankingRules: [String]? = nil,
    searchableAttributes: [String]? = nil,
    displayedAttributes: [String]? = nil,
    stopWords: [String]? = nil,
    synonyms: [String: [String]]? = nil,
    distinctAttribute: String? = nil,
    filterableAttributes: [String]? = nil,
    sortableAttributes: [String]? = nil,
    typoTolerance: TypoTolerance? = nil,
    pagination: Pagination? = nil,
    faceting: Faceting? = nil
  ) {
    self.rankingRules = rankingRules
    self.searchableAttributes = searchableAttributes
    self.displayedAttributes = displayedAttributes
    self.stopWords = stopWords
    self.synonyms = synonyms
    self.distinctAttribute = distinctAttribute
    self.filterableAttributes = filterableAttributes
    self.sortableAttributes = sortableAttributes
    self.typoTolerance = typoTolerance
    self.pagination = pagination
    self.faceting = faceting
  }
}

extension Settings {
  public struct DistinctAttribute: Codable {
    let distinctAttribute: String

    init(_ distinctAttribute: String) {
      self.distinctAttribute = distinctAttribute
    }
  }
}
