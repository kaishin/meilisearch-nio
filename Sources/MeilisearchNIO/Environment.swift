#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

enum Environment {
  static subscript(_ name: String) -> String? {
    guard let value = getenv(name) else {
      return nil
    }

    return String(cString: value)
  }

  static subscript(_ key: ConfigKeys) -> String? {
    Self[key.rawValue]
  }
}
