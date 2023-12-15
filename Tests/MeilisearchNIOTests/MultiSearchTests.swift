import XCTest
@testable import MeilisearchNIO

final class MultiSearchTests: XCTestCase {
  func testMultiSearch() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "results": [
              {
                "indexUid": "games",
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
              },
              {
                "indexUid": "games",
                "hits": [
                  {
                    "uid": "456",
                    "name": "Dark Souls"
                  }
                ],
                "query": "souls",
                "processingTimeMs": 0,
                "limit": 20,
                "offset": 0,
                "estimatedTotalHits": 1
              }
            ]
          }
          """
      )
    )

    struct Game: Codable, Equatable, Identifiable {
      let uid: String
      let name: String
      var id: String { uid }
    }

    let result: MultiSearchResponse<Game> = try await client.multiSearch(
      with: .init(
        queries: [
          .init(indexUid: "games", parameters: .init(query: "blood")),
          .init(indexUid: "games", parameters: .init(query: "souls"))
        ]
      )
    )

    XCTAssertEqual(result.results.count, 2)
    XCTAssertEqual(result.results[0].indexUid, "games")
    XCTAssertEqual(result.results[0].result.hits.count, 1)
    XCTAssertEqual(result.results[0].result.hits[0].name, "Bloodborne")
    XCTAssertEqual(result.results[0].result.hits[0].id, "123")
    XCTAssertEqual(result.results[0].result.query, "blood")
    XCTAssertEqual(result.results[0].result.limit, 20)
    XCTAssertEqual(result.results[0].result.estimatedTotalHits, 1)

    XCTAssertEqual(result.results[1].indexUid, "games")
    XCTAssertEqual(result.results[1].result.hits.count, 1)
    XCTAssertEqual(result.results[1].result.hits[0].name, "Dark Souls")
    XCTAssertEqual(result.results[1].result.hits[0].id, "456")
    XCTAssertEqual(result.results[1].result.query, "souls")
    XCTAssertEqual(result.results[1].result.limit, 20)
    XCTAssertEqual(result.results[1].result.estimatedTotalHits, 1)
  }
}
