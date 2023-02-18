import Foundation

/// Represents the current transaction status.
/// Use the `uid` value to verify the status of a transaction.
public struct OperationTask: Decodable, Hashable {
  /// An abridged model returned as a result of many operations.
  public struct Reference: Decodable, Hashable {
    public let taskUid: Int
    public let indexUid: String?
    public let status: StatusReference
    public let enqueuedAt: Date
    public let type: TypeReference
  }

  /// Unique sequential identifier of the task.
  public let uid: Int

  ///The date the task was enqueued.
  public let enqueuedAt: Date

  /// Unique identifier of the targeted index.
  public let indexUid: String?

  /// Status of the task.
  public let status: Status

  /// Type of operation performed by the task and the associated details.
  public let details: Details

  /// The uid of a taskCancelation task if the task was canceled.
  public let canceledBy: Int?

  /// The total elapsed time the task spent in the processing state, in ISO 8601 format.
  public let duration: String?

  /// The date and time when the task began processing, in RFC 3339 format.
  public let startedAt: Date?

  /// The date and time when the task finished processing, whether failed, succeeded, or canceled, in RFC 3339 format.
  public let finishedAt: Date?

  public enum CodingKeys: String, CodingKey {
    case uid,
      enqueuedAt,
      indexUid,
      status,
      canceledBy,
      error,
      duration,
      details,
      startedAt,
      type,
      finishedAt
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.uid = try container.decode(Int.self, forKey: .uid)
    self.indexUid = try? container.decode(String.self, forKey: .indexUid)
    self.enqueuedAt = try container.decode(Date.self, forKey: .enqueuedAt)
    self.canceledBy = try? container.decode(Int.self, forKey: .canceledBy)
    self.startedAt = try? container.decode(Date.self, forKey: .startedAt)
    self.finishedAt = try? container.decode(Date.self, forKey: .finishedAt)
    self.duration = try? container.decode(String.self, forKey: .duration)
    let status = try container.decode(StatusReference.self, forKey: .status)

    switch status {
    case .enqueued:
      self.status = .enqueued

    case .processing:
      self.status = .processing

    case .succeeded:
      self.status = .succeeded

    case .canceled:
      self.status = .canceled

    case .failed:
      let error = try container.decode(ErrorResponse.self, forKey: .error)
      self.status = .failed(error)
    }

    let type = try container.decode(TypeReference.self, forKey: .type)
    switch type {
    case .documentAdditionOrUpdate:
      let details = try container.decode(Details.DocumentAdditionOrUpdate.self, forKey: .details)
      self.details = .documentAdditionOrUpdate(details)

    case .documentDeletion:
      let details = try container.decode(Details.DocumentDeletion.self, forKey: .details)
      self.details = .documentDeletion(details)

    case .dumpCreation:
      let details = try container.decode(Details.DumpCreation.self, forKey: .details)
      self.details = .dumpCreation(details)

    case .indexCreation:
      let details = try container.decode(Details.IndexCreation.self, forKey: .details)
      self.details = .indexCreation(details)

    case .indexDeletion:
      let details = try container.decode(Details.IndexDeletion.self, forKey: .details)
      self.details = .indexDeletion(details)

    case .indexSwap:
      let details = try container.decode(Details.IndexSwap.self, forKey: .details)
      self.details = .indexSwap(details)

    case .indexUpdate:
      let details = try container.decode(Details.IndexUpdate.self, forKey: .details)
      self.details = .indexUpdate(details)

    case .settingsUpdate:
      let settings = try container.decode(Settings.self, forKey: .details)
      self.details = .settingsUpdate(settings)

    case .snapshotCreation:
      self.details = .snapshotCreation

    case .taskCancelation:
      let details = try container.decode(Details.TaskCancelation.self, forKey: .details)
      self.details = .taskCancelation(details)

    case .taskDeletion:
      let details = try container.decode(Details.TaskDeletion.self, forKey: .details)
      self.details = .taskDeletion(details)
    }
  }
}

extension OperationTask {
  public enum Details: Codable, Hashable {
    case documentAdditionOrUpdate(DocumentAdditionOrUpdate)
    case documentDeletion(DocumentDeletion)
    case dumpCreation(DumpCreation)
    case indexCreation(IndexCreation)
    case indexDeletion(IndexDeletion)
    case indexSwap(IndexSwap)
    case indexUpdate(IndexUpdate)
    case settingsUpdate(Settings)
    case snapshotCreation
    case taskCancelation(TaskCancelation)
    case taskDeletion(TaskDeletion)

    public struct DocumentAdditionOrUpdate: Codable, Hashable {
      /// Number of documents received.
      public let receivedDocuments: Int

      /// Number of documents indexed.
      public let indexedDocuments: Int?
    }

    public struct DocumentDeletion: Codable, Hashable {
      /// Number of documents queued for deletion.
      public let providedIds: Int?

      /// Number of documents deleted.
      public let deletedDocuments: Int?
    }

    public struct IndexCreation: Codable, Hashable {
      /// Value of the `primaryKey` field supplied during index creation.
      public let primaryKey: String?
    }

    public struct IndexUpdate: Codable, Hashable {
      /// Value of the `primaryKey` field supplied during index update.
      public let primaryKey: String?
    }

    public struct IndexDeletion: Codable, Hashable {
      /// Number of deleted documents.
      /// This should equal the total number of documents in the deleted index.
      public let deletedDocuments: Int?
    }

    public struct IndexSwap: Codable, Hashable {
      /// A list of index pairs to swap.
      public let swaps: [SwapIndexes]
    }

    public struct DumpCreation: Codable, Hashable {
      /// The generated uid of the dump. This is also the name of the generated dump file.
      public let dumpUid: String?
    }

    public struct TaskCancelation: Codable, Hashable {
      /// The number of matched tasks.
      /// If the API key used for the request doesn’t have access to an index, tasks relating to that index will not be included in matchedTasks
      public let matchedTasks: Int

      /// The number of tasks successfully canceled. If the task cancellation fails, this will be 0.
      /// Nil when the task status is enqueued or processing
      public let canceledTasks: Int?

      /// The filter used in the cancel task request.
      public let originalFilter: String
    }

    public struct TaskDeletion: Codable, Hashable {
      /// The number of matched tasks.
      /// If the API key used for the request doesn’t have access to an index, tasks relating to that index will not be included in matchedTasks
      public let matchedTasks: Int

      /// The number of tasks successfully deleted. If the task deletion fails, this will be 0.
      /// Nil when the task status is enqueued or processing
      public let deletedTasks: Int?

      /// The filter used in the delete task request.
      public let originalFilter: String
    }
  }

  public enum StatusReference: String, Codable, Hashable {
    case enqueued
    case processing
    case succeeded
    case failed
    case canceled
  }

  public enum Status: Codable, Hashable {
    case enqueued
    case processing
    case succeeded
    case failed(ErrorResponse)
    case canceled

    public var isCompleted: Bool {
      self != .enqueued && self != .processing
    }

    public var error: ErrorResponse? {
      if case let .failed(error) = self {
        return error
      } else {
        return nil
      }
    }
  }

  public enum TypeReference: String, Codable, Hashable {
    case documentAdditionOrUpdate
    case documentDeletion
    case dumpCreation
    case indexCreation
    case indexDeletion
    case indexSwap
    case indexUpdate
    case settingsUpdate
    case snapshotCreation
    case taskCancelation
    case taskDeletion
  }
}
