import Foundation

/// The result of a search request.
///
/// SeeAlso: [Official Documentation](https://docs.meilisearch.com/reference/api/search.html#response)
public struct SearchResult<T>: Codable, Equatable
  where T: Codable, T: Equatable {
  /// Possible hints from the search query.
  public let hits: [T]

  /// Number of documents skipped.
  public let offset: Int?

  /// Number of documents taken.
  public let limit: Int?

  /// Current search results page.
  public let page: Int?

  /// Estimated total number of matches.
  public let estimatedTotalHits: Int?

  /// Exhaustive total number of matches.
  public let totalHits: Int?

  /// Exhaustive total number of search result pages.
  public let totalPages: Int?

  /// Number of results on each page.
  public let hitsPerPage: Int?

  /// Distribution of the given facets.
  public let facetsDistribution: [String: [String: Int]]?

  /// Time, in milliseconds, to process the query.
  public let processingTimeMs: Int

  /// Query string from the search.
  public let query: String
}
