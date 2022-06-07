//
//  RegisterError.swift
//  FoodApp
//
//  Created by Anna Shanidze on 03.06.2022.
//

import Foundation

enum RegisterError: Error {
    case emptyFields
    case invalidPassword
    case unexpected(code: Int)
}

extension RegisterError {
    var isFatal: Bool {
        if case RegisterError.unexpected = self { return true }
        else { return false }
    }
}

extension RegisterError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .emptyFields:
            return "Not all fields are filled in."
        case .invalidPassword:
            return "The provided password is not valid."
        case .unexpected(_):
            return "An unexpected error occurred."
        }
    }
}

extension RegisterError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyFields:
            return NSLocalizedString("Please fill in all fields.",
                                     comment: "Empty Fields")
        case .invalidPassword:
            return NSLocalizedString(
                "Please make sure your password is at least 8 characters, contains uppercase and lowercase letters and a number.",
                comment: "Invalid Password"
            )
        case .unexpected(_):
            return NSLocalizedString(
                "An unexpected error occurred.",
                comment: "Unexpected Error"
            )
        }
    }
}
