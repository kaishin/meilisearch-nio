import Foundation

struct URLPath {
  var fragments: [String]
}

extension URLPath: ExpressibleByStringLiteral {
  init(_ fragments: [String] = []) {
    self.fragments = fragments
  }

  init(_ string: String) {
    self.fragments = string.components(separatedBy: "/")
  }

  init(stringLiteral value: String) {
    self.fragments = value.components(separatedBy: "/")
  }

  var fullPath: String {
    fragments.joined(separator: "/")
  }
}

// MARK: - Custom Operator
func /(
  lhs: String,
  rhs: String
) -> URLPath {
  .init([lhs, rhs])
}

func /(
  lhs: URLPath,
  rhs: String
) -> URLPath {
  var new = lhs
  new.fragments.append(rhs)
  return new
}

func /(
  lhs: URLPath,
  rhs: [String]
) -> URLPath {
  var new = lhs
  new.fragments.append(contentsOf: rhs)
  return new
}

func /(
  lhs: URLPath,
  rhs: CustomStringConvertible
) -> URLPath {
  var new = lhs
  new.fragments.append(rhs.description)
  return new
}

extension URLPath {
  static let dumps = Self(.dumps)
  static let health = Self(.health)
  static let indexes = Self(.indexes)
  static let keys = Self(.keys)
  static let multiSearch = Self(.multiSearch)
  static let stats = Self(.stats)
  static let swapIndexes = Self(.swapIndexes)
  static let tasks = Self(.tasks)
  static let version = Self(.version)
}

extension String {
  static let authorization = "authorization"
  static let cancel = "cancel"
  static let delete = "delete"
  static let deleteBatch = "delete-batch"
  static let displayedAttributes = "displayed-attribute"
  static let distinctAttribute = "distinct-attribute"
  static let documents = "documents"
  static let dumps = "dumps"
  static let faceting = "faceting"
  static let filterableAttributes  = "filterable-attributes"
  static let health = "health"
  static let indexes = "indexes"
  static let keys = "keys"
  static let multiSearch = "multi-search"
  static let pagination = "pagination"
  static let rankingRules = "ranking-rules"
  static let search = "search"
  static let searchableAttributes = "searchable-attributes"
  static let settings = "settings"
  static let sortableAttributes  = "sortable-attributes"
  static let stats = "stats"
  static let status = "status"
  static let stopWords = "stop-words"
  static let synonyms = "synonyms"
  static let swapIndexes = "swap-indexes"
  static let tasks = "tasks"
  static let typoTolerance = "typo-tolerance"
  static let version = "version"
}
