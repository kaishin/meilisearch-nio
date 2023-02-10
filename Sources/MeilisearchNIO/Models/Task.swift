import Foundation

public struct MeiliTask: Codable {
  public let uid: Int
  public let indexUid: String
  public let status: Status
  public let type: TaskType
  public let duration: String?
  public let enqueuedAt: Date
  public let startedAt: Date?
  public let finishedAt: Date?
  // TODO: Add details https://github.com/meilisearch/Meilisearch/blob/fa196986c2d8c1bed6ce4fc0c80d079755b3b71f/meilisearch-http/src/task.rs#L57
}

public extension MeiliTask {
  enum Status: String, Codable {
    case enqueued, processing, succeeded, failed

    public var isCompleted: Bool {
      self == .succeeded || self == .failed
    }
  }

  enum TaskType: String, Codable {
    case indexCreation,
         indexUpdate,
         indexDeletion,
         documentAddition,
         documentPartial,
         documentDeletion,
         settingsUpdate,
         clearAll
  }
}
