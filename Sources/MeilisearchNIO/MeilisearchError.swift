import Foundation

public enum MeilisearchError: Error {
  case missingConfiguration(String)
  case missingResponseData
  case malformedRequestURL
  case serverNotFound
  case invalidHost
  case invalidJSON
  case timeOut(timeOut: Double)
}

public struct ErrorResponse: Error, Codable {
  public let message: String
  public let code: String
  public let type: String
  public let link: String?
}
