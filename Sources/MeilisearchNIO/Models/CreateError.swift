import Foundation

public enum CreateError: Error, Equatable {
  case indexAlreadyExists

  public static func decode(from errorResponse: ErrorResponse) -> Self? {
    guard errorResponse.type == "invalid_request_error",
          errorResponse.code == "index_already_exists"
    else {
      return nil
    }

    return CreateError.indexAlreadyExists
  }
}
