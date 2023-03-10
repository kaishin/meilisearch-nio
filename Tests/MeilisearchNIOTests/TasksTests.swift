import XCTest
@testable import MeilisearchNIO

final class TasksTests: XCTestCase {
  func testFailedTask() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(response: 
      """
      {
        "uid": 1,
        "indexUid": "games",
        "status": "failed",
        "type": "documentAdditionOrUpdate",
        "canceledBy": null,
        "details": {
          "receivedDocuments": 1,
          "indexedDocuments": 0
        },
        "error": {
          "message": "Document doesn't have a `uid` attribute: `{\\"name\\":\\"Bloodborne\\",\\"japaneseName\\":\\"Bloodborne\\",\\"platforms\\":[\\"PC\\",\\"Series X\\"],\\"releasedAtText\\":\\"2023-10-31\\",\\"id\\":\\"1B175464-2722-441A-88DD-A12549BD5390\\",\\"artwork\\":[{\\"fileName\\":\\"5a722da7049be40d\\",\\"type\\":\\"cover\\",\\"width\\":865,\\"height\\":1298}],\\"releasedAt\\":720403200}`.",
          "code": "missing_document_id",
          "type": "invalid_request",
          "link": "https://docs.meilisearch.com/errors#missing_document_id"
        },
        "duration": "PT0.007987084S",
        "enqueuedAt": "2023-02-15T21:39:28.438007372Z",
        "startedAt": "2023-02-15T21:39:28.442620455Z",
        "finishedAt": "2023-02-15T21:39:28.450607539Z"
      }
      """
      )
    )

    struct Game: Codable, Equatable, Identifiable {
      let name: String
      var id: String { name }
    }

    let task = try await client.getTask(id: 1)
    XCTAssertEqual(task.uid, 1)
    XCTAssertEqual(task.status.error?.code, .missingDocumentId)
    XCTAssertEqual(task.status.error?.type, .invalidRequest)
  }
}
