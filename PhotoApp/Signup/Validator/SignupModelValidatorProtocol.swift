//
//  SignupModelValidatorProtocol.swift
//  SignupModelValidatorProtocol
//
//  Created by Paul Alvarez on 29/07/21.
//

protocol SignupModelValidatorProtocol {
    func isFirstNameValid(firstName: String) -> Bool
    func isLastNameValid(lastName: String) -> Bool
    func isEmailValid(email: String) -> Bool
    func isPasswordValid(password: String) -> Bool
    func doPasswordMatch(password: String, repeatedPassword: String) -> Bool
}
