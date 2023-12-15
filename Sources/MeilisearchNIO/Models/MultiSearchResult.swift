import Foundation

public struct MultiSearchResult<T>: Codable, Equatable
  where T: Codable, T: Equatable {
  /// The index UID.
  public let indexUid: String

  /// The search result.
  public let result: SearchResult<T>

  public init(indexUid: String, result: SearchResult<T>) {
    self.indexUid = indexUid
    self.result = result
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(indexUid, forKey: .indexUid)
    try result.encode(to: encoder)
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    indexUid = try container.decode(String.self, forKey: .indexUid)
    result = try SearchResult(from: decoder)
  }

  private enum CodingKeys: String, CodingKey {
    case indexUid, 
      hits,
      offset,
      limit,
      page,
      estimatedTotalHits,
      totalHits,
      totalPages,
      hitsPerPage,
      facetDistribution,
      facetStats,
      processingTimeMs,
      query
  }
}
