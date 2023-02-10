import Foundation

public struct WaitOptions: Codable, Equatable {
  /// Maximum time in seconds before timeOut
  public let timeOut: Double

  /// Interval in seconds between each status call
  public let interval: TimeInterval

  public init(
    timeOut: Double? = 5,
    interval: TimeInterval? = 0.5
  ) {
    self.timeOut = timeOut ?? 5
    self.interval = interval ?? 0.5
  }
}
