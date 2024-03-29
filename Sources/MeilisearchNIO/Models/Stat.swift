import Foundation

public struct Stats: Codable, Equatable {
  /// Size of the whole database, in bytes.
  public let databaseSize: Int

  /// Date when the server was last updated.
  public let lastUpdate: Date?

  /// Dictionary of all Indexes containing the stat for each Index.
  public let indexes: [String: IndexStats]
}

public struct IndexStats: Codable, Equatable {
  /// Number of documents in the given index.
  public let numberOfDocuments: Int

  /// Returns if the Index is currently being indexed.
  public let isIndexing: Bool

  /// Usage frequency for each Index field.
  public let fieldDistribution: [String: Int]
}

public struct FacetStats: Codable, Equatable {
  /// The minimum value found in the given facet
  public let min: Double

  /// The maximum value found in the given facet
  public let max: Double
}
