import Foundation

public enum CreateError: Error, Equatable {
  case indexAlreadyExists

  public static func decode(from errorResponse: ErrorResponse) -> Self? {
    guard errorResponse.type == .invalidRequest,
          errorResponse.code == .indexAlreadyExists
    else {
      return nil
    }

    return CreateError.indexAlreadyExists
  }
}
