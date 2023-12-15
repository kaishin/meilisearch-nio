import Foundation

public struct MultiSearchResponse<T>: Codable, Equatable where T: Codable, T: Equatable {
  public let results: [MultiSearchResult<T>]

  public init (results: [MultiSearchResult<T>]) {
    self.results = results
  }
}
