import Foundation

public struct Version: Codable, Equatable {
  /// Current hash from the build.
  public let commitSha: String

  /// Date when the server was compiled.
  public let commitDate: Date

  /// Package version, human readable, overly documented.
  public let pkgVersion: String
}
