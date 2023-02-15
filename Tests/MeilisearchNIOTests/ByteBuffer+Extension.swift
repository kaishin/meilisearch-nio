import Foundation
import NIO

extension ByteBuffer {
  static func from<T>(_ model: T) throws -> Self where T: Encodable {
    let data = try JSONEncoder().encode(model)
    return try from(data)
  }

  static func from(_ string: String) throws -> Self {
    let data = string.data(using: .utf8) ?? .init()
    return try from(data)
  }

  static func from(_ data: Data) throws -> Self {
    var byteBuffer = ByteBufferAllocator().buffer(capacity: data.count)
    byteBuffer.writeBytes(data)
    return byteBuffer
  }
}
