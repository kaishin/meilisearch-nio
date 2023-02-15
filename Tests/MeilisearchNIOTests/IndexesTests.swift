import XCTest
@testable import MeilisearchNIO

final class IndexesTests: XCTestCase {
  func testListIndexes() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(response: 
      """
      {
        "results": [
          {
            "uid": "movies",
            "createdAt": "2023-02-11T11:26:23.179492822Z",
            "updatedAt": "2023-02-11T11:26:23.200074947Z",
            "primaryKey": "id"
          }
        ],
        "offset": 0,
        "limit": 20,
        "total": 1
      }
      """
      )
    )

    let indexes = try await client.listIndexes()
    XCTAssertEqual(indexes.limit, 20)
    XCTAssertEqual(indexes.total, 1)
    XCTAssertEqual(indexes.results[0].uid, "movies")
    XCTAssertEqual(indexes.results[0].primaryKey, "id")
  }

  func testGetIndex() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(response:
      """
      {
        "uid": "movies",
        "createdAt": "2023-02-11T11:26:23.179492822Z",
        "updatedAt": "2023-02-11T11:26:23.200074947Z",
        "primaryKey": "id"
      }
      """
      )
    )

    let index = try await client.getIndex("uid")
    XCTAssertEqual(index.uid, "movies")
    XCTAssertEqual(index.primaryKey, "id")
  }
}
