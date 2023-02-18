import Foundation
import NIO

extension ByteBuffer {
  static func from<T>(_ model: T) throws -> Self where T: Encodable {
    let data = try JSONEncoder().encode(model)
    return from(data)
  }

  static func from(_ string: String) -> Self {
    let data = string.data(using: .utf8) ?? .init()
    return from(data)
  }

  static func from(_ data: Data) -> Self {
    var byteBuffer = ByteBufferAllocator().buffer(capacity: data.count)
    byteBuffer.writeBytes(data)
    return byteBuffer
  }
}
