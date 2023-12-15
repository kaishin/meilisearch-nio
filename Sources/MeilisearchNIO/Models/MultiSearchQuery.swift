import Foundation

public struct MultiSearchQuery: Encodable, Hashable {
  public let indexUid: String
  public let parameters: SearchParameters

  public func encode(to encoder: Encoder) throws {
    // Flatten the parameters into the query string.
    var container = encoder.container(keyedBy: CodingKeys.self)

    try parameters.encode(to: encoder)
    try container.encode(indexUid, forKey: .indexUid)
  }

  private enum CodingKeys: String, CodingKey {
    case query = "q"
    case indexUid,
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
      offset,
      page,
      showMatchesPosition,
      showRankingScore,
      sort
  }
}
