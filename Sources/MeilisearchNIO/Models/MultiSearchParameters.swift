import Foundation

public struct MultiSearchParameters: Encodable, Hashable {
  public let queries: [MultiSearchQuery]
}
