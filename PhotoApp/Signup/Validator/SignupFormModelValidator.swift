//
//  SignupFormModelValidator.swift
//  SignupFormModelValidator
//
//  Created by Paul Alvarez on 28/07/21.
//

import Foundation

class SignupFormModelValidator: SignupModelValidatorProtocol {
    
    func isFirstNameValid(firstName: String) -> Bool {
        let isNotEmpty = !firstName.isEmpty
        let hasMoreOrEqualThanMinCharacters = firstName.count >= SignupConstants.firstNameMinLength
        let hasLessOrEqualThanMaxCharacters = firstName.count <= SignupConstants.firstNameMaxLength
        
        return isNotEmpty && hasMoreOrEqualThanMinCharacters && hasLessOrEqualThanMaxCharacters
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        let isNotEmpty = !lastName.isEmpty
        let hasMoreOrEqualThanMinCharacters = lastName.count >= SignupConstants.firstNameMinLength
        let hasLessOrEqualThanMaxCharacters = lastName.count <= SignupConstants.firstNameMaxLength
        
        return isNotEmpty && hasMoreOrEqualThanMinCharacters && hasLessOrEqualThanMaxCharacters
    }
    
    func isEmailValid(email: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email)
    }
    
    func isPasswordValid(password: String) -> Bool {
        let isNotEmpty = !password.isEmpty
        let hasMoreOrEqualThanMinLength = password.count >= SignupConstants.passwordMinLength
        let hasLessOrEqualThanMaxLength = password.count <= SignupConstants.passwordMaxLength
        
        return isNotEmpty && hasMoreOrEqualThanMinLength && hasLessOrEqualThanMaxLength
    }
    
    func doPasswordMatch(password: String, repeatedPassword: String) -> Bool {
        return password == repeatedPassword
    }
}
