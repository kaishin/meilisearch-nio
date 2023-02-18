import XCTest
@testable import MeilisearchNIO

final class SearchTests: XCTestCase {
  func testSearch() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "hits": [
              {
                "uid": "123",
                "name": "Bloodborne"
              }
            ],
            "query": "blood",
            "processingTimeMs": 0,
            "limit": 20,
            "offset": 0,
            "estimatedTotalHits": 1
          }
          """
      )
    )

    struct Game: Codable, Equatable, Identifiable {
      let uid: String
      let name: String
      var id: String { uid }
    }

    let result: SearchResult<Game> = try await client.search(
      in: "games",
      with: .init(query: "blood")
    )

    XCTAssertEqual(result.query, "blood")
    XCTAssertEqual(result.hits.count, 1)
    XCTAssertEqual(result.hits[0].id, "123")
    XCTAssertEqual(result.limit, 20)
    XCTAssertEqual(result.estimatedTotalHits, 1)
  }
}
