import Foundation

public enum Action: String, Codable {
  case all = "*"
  case search = "search"
  case addDocuments = "documents.add"
  case getDocuments = "documents.get"
  case deleteDocuments = "documents.delete"
  case addIndexes = "indexes.add"
  case getIndexes = "indexes.get"
  case updateIndexes = "indexes.update"
  case deleteIndexes = "indexes.delete"
  case getTaxes = "tasks.get"
  case getSettings = "settings.get"
  case updateSettings = "settings.update"
  case getStats = "stats.get"
  case createDumps = "dumps.create"
  case getDumps = "dumps.get"
  case version = "version"
}
