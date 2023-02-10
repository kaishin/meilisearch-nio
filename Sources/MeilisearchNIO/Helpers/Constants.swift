import Foundation

let defaultJSONDecoder: JSONDecoder = {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
  return decoder
}()

let defaultJSONEncoder: JSONEncoder = {
  let encoder = JSONEncoder()
  encoder.dateEncodingStrategy = .formatted(Formatter.iso8601)
  return encoder
}()
