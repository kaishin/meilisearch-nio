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

  func testCreateIndex() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(response:
      """
      {
        "taskUid": 1,
        "indexUid": "games",
        "status": "enqueued",
        "type": "indexCreation",
        "enqueuedAt": "2023-02-15T13:19:39.736117754Z"
      }
      """
      )
    )

    let task = try await client.createIndex("games")
    XCTAssertEqual(task.taskUid, 1)
    XCTAssertEqual(task.type, .indexCreation)
    XCTAssertEqual(task.indexUid, "games")
  }
  
  func testUpdateIndex() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(response:
      """
      {
        "taskUid": 2,
        "indexUid": "games",
        "status": "enqueued",
        "type": "indexUpdate",
        "enqueuedAt": "2023-02-15T16:38:56.685639581Z"
      }
      """
      )
    )

    let task = try await client.updateIndex("games", primaryKey: "id")
    XCTAssertEqual(task.taskUid, 2)
    XCTAssertEqual(task.type, .indexUpdate)
    XCTAssertEqual(task.indexUid, "games")
  }

  func testDeleteIndex() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(response:
      """
      {
        "taskUid": 3,
        "indexUid": "movies",
        "status": "enqueued",
        "type": "indexDeletion",
        "enqueuedAt": "2023-02-15T16:47:13.632499234Z"
      }
      """
      )
    )

    let task = try await client.deleteIndex("movies")
    XCTAssertEqual(task.taskUid, 3)
    XCTAssertEqual(task.type, .indexDeletion)
    XCTAssertEqual(task.indexUid, "movies")
  }

  func testIndexSwap() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(response:
      """
      {
        "taskUid": 5,
        "indexUid": null,
        "status": "enqueued",
        "type": "indexSwap",
        "enqueuedAt": "2023-02-15T16:57:17.748096814Z"
      }
      """
      )
    )

    let task = try await client.deleteIndex("movies")
    XCTAssertEqual(task.taskUid, 5)
    XCTAssertEqual(task.type, .indexSwap)
    XCTAssertNil(task.indexUid)
  }
}
