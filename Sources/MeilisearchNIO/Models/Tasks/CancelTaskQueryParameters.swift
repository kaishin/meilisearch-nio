import Foundation

public struct CancelTaskQueryParameters: Encodable, Hashable {
  /// Cancel tasks by their uid.
  public let uids: [Int]

   /// Cancel tasks by their status.
  public let statuses: [OperationTask.StatusReference]

  /// Cancel tasks by their type.
  public let types: [OperationTask.TypeReference]

  /// Cancel tasks by their indexUid. Case-sensitive.
  public let indexUids: [String]

  /// Filter tasks by their enqueuedAt field.
  public let beforeEnqueuedAt: Date?

  /// Filter tasks by their startedAt field.
  public let beforeStartedAt: Date?

  /// Filter tasks by their enqueuedAt field.
  public let afterEnqueuedAt: Date?

  /// Filter tasks by their startedAt field.
  public let afterStartedAt: Date?

  public init(
    uids: [Int] = [],
    statuses: [OperationTask.StatusReference] = [],
    types: [OperationTask.TypeReference] = [],
    indexUids: [String] = [],
    beforeEnqueuedAt: Date? = nil,
    beforeStartedAt: Date? = nil,
    afterEnqueuedAt: Date? = nil,
    afterStartedAt: Date? = nil
  ) {
    self.uids = uids
    self.statuses = statuses
    self.types = types
    self.indexUids = indexUids
    self.beforeEnqueuedAt = beforeEnqueuedAt
    self.beforeStartedAt = beforeStartedAt
    self.afterEnqueuedAt = afterEnqueuedAt
    self.afterStartedAt = afterStartedAt
  }

  func toQueryParameters() -> [String: String] {
    var queries = [String: String]()

    if !uids.isEmpty {
      queries["uids"] = uids.map(\.description).joined(separator: ",")
    }

    if !statuses.isEmpty {
      queries["statuses"] = statuses.map(\.rawValue).joined(separator: ",")
    }

    if !types.isEmpty {
      queries["types"] = types.map(\.rawValue).joined(separator: ",")
    }

    if !indexUids.isEmpty {
      queries["indexUids"] = indexUids.joined(separator: ",")
    }

    if let beforeEnqueuedAt {
      queries["beforeEnqueuedAt"] = beforeEnqueuedAt.ISO8601Format().description
    }

    if let beforeStartedAt {
      queries["beforeStartedAt"] = beforeStartedAt.ISO8601Format().description
    }

    if let afterEnqueuedAt {
      queries["afterEnqueuedAt"] = afterEnqueuedAt.ISO8601Format().description
    }

    if let afterStartedAt {
      queries["afterStartedAt"] = afterStartedAt.ISO8601Format().description
    }

    return queries
  }
}

