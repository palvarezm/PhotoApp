//
//  MockSignupModelValidator.swift
//  MockSignupModelValidator
//
//  Created by Paul Alvarez on 29/07/21.
//

@testable import PhotoApp

class MockSignupModelValidator: SignupModelValidatorProtocol {
    var isFirstNameValidated = false
    var isLastNameValidated = false
    var isEmailValidated = false
    var isPasswordValidated = false
    var arePasswordsEqual = false
    
    func isFirstNameValid(firstName: String) -> Bool {
        isFirstNameValidated = true
        return isFirstNameValidated
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        isLastNameValidated = true
        return isLastNameValidated
    }
    
    func isEmailValid(email: String) -> Bool {
        isEmailValidated = true
        return isEmailValidated
    }
    
    func isPasswordValid(password: String) -> Bool {
        isPasswordValidated = true
        return isPasswordValidated
    }
    
    func doPasswordMatch(password: String, repeatedPassword: String) -> Bool {
        arePasswordsEqual = true
        return arePasswordsEqual
    }
}
