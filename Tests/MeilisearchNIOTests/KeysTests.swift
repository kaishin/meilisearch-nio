import XCTest
@testable import MeilisearchNIO

final class KeysTests: XCTestCase {
  func testGetAllKeys() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "results": [
              {
                "name": null,
                "description": "Manage documents: Products + Reviews API key",
                "key": "d0552b41536279a0ad88bd595327b96f01176a60c2243e906c52ac02375f9bc4",
                "uid": "6062abda-a5aa-4414-ac91-ecd7944c0f8d",
                "actions": [
                  "documents.add",
                  "documents.delete"
                ],
                "indexes": [
                  "products",
                  "reviews"
                ],
                "expiresAt": "2023-02-15T21:39:28.450607539Z",
                "createdAt": "2023-02-15T21:39:28.450607539Z",
                "updatedAt": "2023-02-15T21:39:28.450607539Z"
              },
              {
                "name": "Default Search API Key",
                "description": "Use it to search from the frontend code",
                "key": "0a6e572506c52ab0bd6195921575d23092b7f0c284ab4ac86d12346c33057f99",
                "uid": "74c9c733-3368-4738-bbe5-1d18a5fecb37",
                "actions": [
                  "search"
                ],
                "indexes": [
                  "*"
                ],
                "expiresAt": null,
                "createdAt": "2023-02-15T21:39:28.450607539Z",
                "updatedAt": "2023-02-15T21:39:28.450607539Z"
              },
              {
                "name": "Default Admin API Key",
                "description": "Use it for anything that is not a search operation. Caution! Do not expose it on a public frontend",
                "key": "380689dd379232519a54d15935750cc7625620a2ea2fc06907cb40ba5b421b6f",
                "uid": "20f7e4c4-612c-4dd1-b783-7934cc038213",
                "actions": [
                  "*"
                ],
                "indexes": [
                  "*"
                ],
                "expiresAt": null,
                "createdAt": "2023-02-15T21:39:28.450607539Z",
                "updatedAt": "2023-02-15T21:39:28.450607539Z"
              }
            ],
            "offset": 0,
            "limit": 3,
            "total": 7
          }
          """
      )
    )

    let page: Page<Key> = try await client.getAllKeys(masterKey: "123")
    XCTAssertEqual(page.total, 7)
    XCTAssertEqual(page.limit, 3)
    XCTAssertEqual(page.results[0].actions?.first, .addDocuments)
  }

  func testGetOneKey() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "name": null,
            "description": "Add documents: Products API key",
            "key": "d0552b41536279a0ad88bd595327b96f01176a60c2243e906c52ac02375f9bc4",
            "uid": "6062abda-a5aa-4414-ac91-ecd7944c0f8d",
            "actions": [
              "documents.add"
            ],
            "indexes": [
              "products"
            ],
            "expiresAt": "2023-02-15T21:39:28.450607539Z",
            "createdAt": "2023-02-15T21:39:28.450607539Z",
            "updatedAt": "2023-02-15T21:39:28.450607539Z"
          }
          """
      )
    )

    let key = try await client.getOneKey(keyOrUid: "6062abda-a5aa-4414-ac91-ecd7944c0f8d")
    XCTAssertEqual(key.key, "d0552b41536279a0ad88bd595327b96f01176a60c2243e906c52ac02375f9bc4")
  }

  func testCreateKey() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "name": null,
            "description": "Add documents: Products API key",
            "key": "d0552b41536279a0ad88bd595327b96f01176a60c2243e906c52ac02375f9bc4",
            "uid": "6062abda-a5aa-4414-ac91-ecd7944c0f8d",
            "actions": [
              "documents.add"
            ],
            "indexes": [
              "products"
            ],
            "expiresAt": "2023-02-15T21:39:28.450607539Z",
            "createdAt": "2023-02-15T21:39:28.450607539Z",
            "updatedAt": "2023-02-15T21:39:28.450607539Z"
          }
          """
      )
    )

    let key = try await client.createKey(
      .init(
        actions: [.addDocuments],
        indexes: ["products"],
        expiresAt: Date()
      )
    )
    XCTAssertEqual(key.key, "d0552b41536279a0ad88bd595327b96f01176a60c2243e906c52ac02375f9bc4")
  }

  func testUpdateKey() async throws {
    let client = MeilisearchClient.mock(
      networkClient: .mock(
        response:
          """
          {
            "name": "New Name",
            "description": "Add documents: Products API key",
            "key": "d0552b41536279a0ad88bd595327b96f01176a60c2243e906c52ac02375f9bc4",
            "uid": "6062abda-a5aa-4414-ac91-ecd7944c0f8d",
            "actions": [
              "documents.add"
            ],
            "indexes": [
              "products"
            ],
            "expiresAt": "2023-02-15T21:39:28.450607539Z",
            "createdAt": "2023-02-15T21:39:28.450607539Z",
            "updatedAt": "2023-02-15T21:39:28.450607539Z"
          }
          """
      )
    )

    let key = try await client.updateKey(
      keyOrUid: "6062abda-a5aa-4414-ac91-ecd7944c0f8d",
      .init(
        name: "New Name"
      )
    )
    XCTAssertEqual(key.name, "New Name")
  }
}
