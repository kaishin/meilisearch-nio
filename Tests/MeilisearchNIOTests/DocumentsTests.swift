import XCTest

@testable import MeilisearchNIO

final class DocumentsTests: XCTestCase {
  func testGetAllDocuments() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "results": [
              {
                "uid": "123",
                "name": "Bloodborne"
              }
            ],
            "offset": 0,
            "limit": 50,
            "total": 1
          }
          """
      )
    )

    struct Game: Codable, Equatable, Identifiable {
      let uid: String
      let name: String
      var id: String { uid }
    }

    let page: Page<Game> = try await client.getAllDocuments(in: "games")
    XCTAssertEqual(page.total, 1)
    XCTAssertEqual(page.limit, 50)
    XCTAssertEqual(page.results[0].name, "Bloodborne")
  }

  func testGetDocument() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "uid": "123",
            "name": "Bloodborne"
          }
          """
      )
    )

    struct Game: Codable, Equatable, Identifiable {
      let uid: String
      let name: String
      var id: String { uid }
    }

    let game: Game = try await client.getDocument(withID: "123", in: "games")
    XCTAssertEqual(game.name, "Bloodborne")
  }

  func testAddOrReplaceDocuments() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "taskUid": 3,
            "indexUid": "games",
            "status": "enqueued",
            "type": "documentAdditionOrUpdate",
            "enqueuedAt": "2023-02-15T23:29:57.567942658Z"
          }
          """
      )
    )

    struct Game: Codable, Equatable, Identifiable {
      let uid: String
      let name: String
      var id: String { uid }
    }

    let task = try await client.addOrReplaceDocument(
      Game(uid: "123", name: "Bloodborne"),
      to: "games"
    )

    XCTAssertEqual(task.taskUid, 3)
    XCTAssertEqual(task.type, .documentAdditionOrUpdate)
    XCTAssertEqual(task.indexUid, "games")
  }

  func testAddOrUpdateDocuments() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "taskUid": 4,
            "indexUid": "games",
            "status": "enqueued",
            "type": "documentAdditionOrUpdate",
            "enqueuedAt": "2023-02-15T23:35:37.318412987Z"
          }
          """
      )
    )

    struct Game: Codable, Equatable, Identifiable {
      let uid: String
      let name: String
      var id: String { uid }
    }

    let task = try await client.addOrUpdateDocument(
      Game(uid: "123", name: "Bloodborne"),
      to: "games"
    )

    XCTAssertEqual(task.taskUid, 4)
    XCTAssertEqual(task.type, .documentAdditionOrUpdate)
    XCTAssertEqual(task.indexUid, "games")
  }

  func testDeleteOne() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "taskUid": 6,
            "indexUid": "games",
            "status": "enqueued",
            "type": "documentDeletion",
            "enqueuedAt": "2023-02-15T23:46:11.667399581Z"
          }
          """
      )
    )

    struct Game: Codable, Equatable, Identifiable {
      let uid: String
      let name: String
      var id: String { uid }
    }

    let task = try await client.delete(
      documentID: "1234",
      in: "games"
    )

    XCTAssertEqual(task.taskUid, 6)
    XCTAssertEqual(task.type, .documentDeletion)
    XCTAssertEqual(task.indexUid, "games")
  }

  func testDeleteAll() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "taskUid": 7,
            "indexUid": "games",
            "status": "enqueued",
            "type": "documentDeletion",
            "enqueuedAt": "2023-02-15T23:52:27.055169093Z"
          }
          """
      )
    )

    struct Game: Codable, Equatable, Identifiable {
      let uid: String
      let name: String
      var id: String { uid }
    }

    let task = try await client.delete(
      documentID: "1234",
      in: "games"
    )

    XCTAssertEqual(task.taskUid, 7)
    XCTAssertEqual(task.type, .documentDeletion)
    XCTAssertEqual(task.indexUid, "games")
  }

  func testDeletebatch() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "taskUid": 1,
            "indexUid": "games",
            "status": "enqueued",
            "type": "documentDeletion",
            "enqueuedAt": "2023-02-15T23:52:27.055169093Z"
          }
          """
      )
    )

    struct Game: Codable, Equatable, Identifiable {
      let uid: String
      let name: String
      var id: String { uid }
    }

    let task = try await client.deleteBatch(
      ["1234"],
      in: "games"
    )

    XCTAssertEqual(task.taskUid, 1)
    XCTAssertEqual(task.type, .documentDeletion)
    XCTAssertEqual(task.indexUid, "games")
  }
}
