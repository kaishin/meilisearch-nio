import Foundation

public struct Dump: Codable, Equatable {
  public let uid: String
  public let status: Status

  public enum Status: Codable, Equatable {
    case inProgress
    case failed
    case done

    public enum CodingError: Error {
      case unknownStatus
    }

    public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      let rawStatus = try container.decode(String.self)

      switch rawStatus {
      case "in_progress":
        self = .inProgress
      case "dump_process_failed":
        self = .failed
      case "done":
        self = .done
      default:
        throw CodingError.unknownStatus
      }
    }

    public func encode(to encoder: Encoder) throws {}
  }
}
