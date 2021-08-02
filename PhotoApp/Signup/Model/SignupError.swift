//
//  SignupError.swift
//  SignupError
//
//  Created by Paul Alvarez on 28/07/21.
//

import Foundation

enum SignupError: LocalizedError, Equatable {
    case invalidResponseModel
    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidPassword
    case invalidRepeatedPassword
    case invalidRequestURLString
    case failedRequest
}
