import XCTest

@testable import MeilisearchNIO

final class SettingsTests: XCTestCase {
  func testGetAllSettings() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "displayedAttributes": [
              "*"
            ],
            "searchableAttributes": [
              "*"
            ],
            "filterableAttributes": [],
            "sortableAttributes": [],
            "rankingRules": [
              "words",
              "typo",
              "proximity",
              "attribute",
              "sort",
              "exactness"
            ],
            "stopWords": [],
            "synonyms": {},
            "distinctAttribute": null,
            "typoTolerance": {
              "enabled": true,
              "minWordSizeForTypos": {
                "oneTypo": 5,
                "twoTypos": 9
              },
              "disableOnWords": [],
              "disableOnAttributes": []
            },
            "faceting": {
              "maxValuesPerFacet": 100
            },
            "pagination": {
              "maxTotalHits": 1000
            }
          }
          """
      )
    )

    let settings = try await client.getSettings(for: "games")

    XCTAssertEqual(settings.displayedAttributes, ["*"])
    XCTAssertEqual(settings.searchableAttributes, ["*"])
    XCTAssertEqual(settings.filterableAttributes, [])
    XCTAssertEqual(settings.sortableAttributes, [])
    XCTAssertEqual(
      settings.rankingRules,
      [
        "words",
        "typo",
        "proximity",
        "attribute",
        "sort",
        "exactness",
      ]
    )
    XCTAssertEqual(settings.stopWords, [])
    XCTAssertEqual(settings.typoTolerance?.enabled, true)
    XCTAssertEqual(settings.typoTolerance?.minWordSizeForTypos?.oneTypo, 5)
    XCTAssertEqual(settings.faceting?.maxValuesPerFacet, 100)
    XCTAssertEqual(settings.pagination?.maxTotalHits, 1000)
  }

  func testUpdateAllSettings() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "taskUid": 9,
            "indexUid": "games",
            "status": "enqueued",
            "type": "settingsUpdate",
            "enqueuedAt": "2023-02-16T23:20:12.912869828Z"
          }
          """
      )
    )

    let task = try await client.updateSettings(with: .init(), for: "games")
    XCTAssertEqual(task.taskUid, 9)
    XCTAssertEqual(task.type, .settingsUpdate)
    XCTAssertEqual(task.indexUid, "games")
  }

  func testResetAllSettings() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "taskUid": 10,
            "indexUid": "games",
            "status": "enqueued",
            "type": "settingsUpdate",
            "enqueuedAt": "2023-02-16T23:45:55.285747397Z"
          }
          """
      )
    )

    let task = try await client.updateSettings(with: .init(), for: "games")
    XCTAssertEqual(task.taskUid, 10)
    XCTAssertEqual(task.type, .settingsUpdate)
    XCTAssertEqual(task.indexUid, "games")
  }
}
