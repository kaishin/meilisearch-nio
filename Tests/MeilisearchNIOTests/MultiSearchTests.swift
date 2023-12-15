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

    let response: MultiSearchResponse<Game> = .init(
      results: [
        MultiSearchResult(
          indexUid: "games",
          result: .init(
            hits: [
              Game(uid: "123", name: "Bloodborne")
            ],
            offset: 0,
            limit: 20,
            estimatedTotalHits: 1,
            processingTimeMs: 0,
            query: "blood"
          )
        ),
        .init(
          indexUid: "games",
          result: .init(
            hits: [
              Game(uid: "456", name: "Dark Souls")
            ],
            offset: 0,
            limit: 20,
            estimatedTotalHits: 1,
            processingTimeMs: 0,
            query: "blood"
          )
        )
      ]
    )

    XCTAssertEqual(response.results.count, 2)
    XCTAssertEqual(response.results[0].indexUid, "games")
    XCTAssertEqual(response.results[0].result.hits.count, 1)
    XCTAssertEqual(response.results[0].result.hits[0].name, "Bloodborne")
    XCTAssertEqual(response.results[0].result.hits[0].id, "123")
    XCTAssertEqual(response.results[0].result.query, "blood")
    XCTAssertEqual(response.results[0].result.limit, 20)
    XCTAssertEqual(response.results[0].result.estimatedTotalHits, 1)

    XCTAssertEqual(response.results[1].indexUid, "games")
    XCTAssertEqual(response.results[1].result.hits.count, 1)
    XCTAssertEqual(response.results[1].result.hits[0].name, "Dark Souls")
    XCTAssertEqual(response.results[1].result.hits[0].id, "456")
    XCTAssertEqual(response.results[1].result.query, "blood")
    XCTAssertEqual(response.results[1].result.limit, 20)
    XCTAssertEqual(response.results[1].result.estimatedTotalHits, 1)
  }
}
