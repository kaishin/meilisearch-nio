import Foundation

public struct GetTaskQueryParameters: Encodable, Hashable {
  /// Number of tasks to return.
  public let limit: Int?

  /// UID of the first task returned.
  public let from: Int?

  /// Filter tasks by their uid.
  public let uids: [Int]

  /// Filter tasks by their status.
  public let statuses: [OperationTask.StatusReference]

  /// Filter tasks by their type.
  public let types: [OperationTask.TypeReference]

  /// Filter tasks by their indexUid. Case-sensitive.
  public let indexUids: [String]

  /// Filter tasks by their canceledBy field.
  public let canceledBy: [Int]

  /// Filter tasks by their enqueuedAt field.
  public let beforeEnqueuedAt: Date?

  /// Filter tasks by their startedAt field.
  public let beforeStartedAt: Date?

  /// Filter tasks by their finishedAt field.
  public let beforeFinishedAt: Date?

  /// Filter tasks by their enqueuedAt field.
  public let afterEnqueuedAt: Date?

  /// Filter tasks by their startedAt field.
  public let afterStartedAt: Date?

  /// Filter tasks by their finishedAt field.
  public let afterFinishedAt: Date?

  public init(
    limit: Int? = nil,
    from: Int? = nil,
    uids: [Int] = [],
    statuses: [OperationTask.StatusReference] = [],
    types: [OperationTask.TypeReference] = [],
    indexUids: [String] = [],
    canceledBy: [Int] = [],
    beforeEnqueuedAt: Date? = nil,
    beforeStartedAt: Date? = nil,
    beforeFinishedAt: Date? = nil,
    afterEnqueuedAt: Date? = nil,
    afterStartedAt: Date? = nil,
    afterFinishedAt: Date? = nil
  ) {
    self.limit = limit
    self.from = from
    self.uids = uids
    self.statuses = statuses
    self.types = types
    self.indexUids = indexUids
    self.canceledBy = canceledBy
    self.beforeEnqueuedAt = beforeEnqueuedAt
    self.beforeStartedAt = beforeStartedAt
    self.beforeFinishedAt = beforeFinishedAt
    self.afterEnqueuedAt = afterEnqueuedAt
    self.afterStartedAt = afterStartedAt
    self.afterFinishedAt = afterFinishedAt
  }

  func toQueryParameters() -> [String: String] {
    var queries = [String: String]()

    if let limit {
      queries["limit"] = limit.description
    }

    if let from {
      queries["from"] = from.description
    }

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

    if !canceledBy.isEmpty {
      queries["canceledBy"] = canceledBy.map(\.description).joined(separator: ",")
    }

    if let beforeEnqueuedAt {
      queries["beforeEnqueuedAt"] = beforeEnqueuedAt.formatted(.iso8601)  
    }

    if let beforeStartedAt {
      queries["beforeStartedAt"] = beforeStartedAt.formatted(.iso8601)  
    }

    if let beforeFinishedAt {
      queries["beforeFinishedAt"] = beforeFinishedAt.formatted(.iso8601)  
    }

    if let afterEnqueuedAt {
      queries["afterEnqueuedAt"] = afterEnqueuedAt.formatted(.iso8601)  
    }

    if let afterStartedAt {
      queries["afterStartedAt"] = afterStartedAt.formatted(.iso8601)  
    }

    if let afterFinishedAt {
      queries["afterFinishedAt"] = afterFinishedAt.formatted(.iso8601)  
    }

    return queries
  }
}
