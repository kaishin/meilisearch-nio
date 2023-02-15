import Vapor

// configures your application
public func configure(_ app: Application) throws {
  app.meilisearch = try .init(httpClient: app.http.client.shared)
  // register routes
  try routes(app)
}
