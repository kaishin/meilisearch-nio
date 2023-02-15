import Vapor
import MeilisearchNIO

func routes(_ app: Application) throws {
  app.get("indexes") { req in
    try await req.meilisearch.listIndexes(limit: 10)
  }

  app.get("index", ":id") { req in
    let uid = req.parameters.get("id")!
    return try await req.meilisearch.getIndex(uid)
  }
}
