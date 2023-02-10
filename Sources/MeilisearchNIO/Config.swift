import Foundation

enum ConfigKeys: String {
  case url = "MEILISEARCH_URL"
  case apiKey = "MEILISEARCH_API_KEY"
}

public struct MeiliConfig {
  /// Don't put a '/' at the end of the host.
  public let url: String
  public let apiKey: String?

  public init(url: String, apiKey: String? = nil) {
    self.url = url
    self.apiKey = apiKey
  }

  func validate() throws -> Self {
    guard URL(string: url) != nil else {
      throw MeiliSearchError.invalidHost
    }

    return self
  }

  static func fromEnvironmentThrowing() throws -> MeiliConfig {
    guard let url = Environment[ConfigKeys.url] else {
      throw MeiliSearchError.missingConfiguration(ConfigKeys.url.rawValue)
    }

    return .init(url: url, apiKey: Environment[ConfigKeys.apiKey])
  }

  public static var env: MeiliConfig? {
    do {
      return try fromEnvironmentThrowing()
    } catch {
      debugPrint("MeiliSearch configuration error: \(error)")
      return nil
    }
  }

  public static var `default`: MeiliConfig {
    .init(
      url: "http://localhost:7700",
      apiKey: nil
    )
  }
}
