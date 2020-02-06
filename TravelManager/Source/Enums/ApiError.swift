import Foundation

enum ApiError: Error {
    case userNotFoundError
    case parsingError
}

extension ApiError: LocalizedError {
     
    var errorDescription: String? {
        switch self {
        case .userNotFoundError:
            return "Unable to load user."
        case .parsingError:
            return "Unable to load data."
        }
    }
}
