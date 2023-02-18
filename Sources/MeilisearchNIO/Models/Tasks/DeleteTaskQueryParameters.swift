import Foundation

public struct DeleteTaskQueryParameters: Encodable, Hashable {
  /// Cancel tasks by their uid.
  public let uids: [Int]

   /// Cancel tasks by their status.
  public let statuses: [OperationTask.StatusReference]

  /// Cancel tasks by their type.
  public let types: [OperationTask.TypeReference]

  /// Cancel tasks by their indexUid. Case-sensitive.
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
      queries["beforeEnqueuedAt"] = Formatter.iso8601.string(from: beforeEnqueuedAt)  
    }

    if let beforeStartedAt {
      queries["beforeStartedAt"] = Formatter.iso8601.string(from: beforeStartedAt)  
    }

    if let beforeFinishedAt {
      queries["beforeFinishedAt"] = Formatter.iso8601.string(from: beforeFinishedAt)  
    }

    if let afterEnqueuedAt {
      queries["afterEnqueuedAt"] = Formatter.iso8601.string(from: afterEnqueuedAt)  
    }

    if let afterStartedAt {
      queries["afterStartedAt"] = Formatter.iso8601.string(from: afterStartedAt)  
    }

    if let afterFinishedAt {
      queries["afterFinishedAt"] = Formatter.iso8601.string(from: afterFinishedAt)  
    }

    return queries
  }
}

