//
//  SignupConstants.swift
//  SignupConstants
//
//  Created by Paul Alvarez on 28/07/21.
//

struct SignupConstants {
    static let signupURLString = "http://appsdeveloperblog.com:8080/signup-mock-service/users"
    static let okResponseJsonString = "{\"status\":\"ok\"}"
    //MARK: First Name
    static let firstNameMinLength = 2
    static let firstNameMaxLength = 10
    //MARK: Last Name
    static let lastNameMinLength = 2
    static let lastNameMaxLength = 10
    //MARK: Password
    static let passwordMinLength = 7
    static let passwordMaxLength = 15
}
