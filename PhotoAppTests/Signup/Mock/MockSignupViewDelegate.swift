//
//  MockSignupViewDelegate.swift
//  MockSignupViewDelegate
//
//  Created by Paul Alvarez on 29/07/21.
//

import XCTest
@testable import PhotoApp

class MockSignupViewDelegate: SignupViewDelegateProtocol {
    
    var expectation: XCTestExpectation?
    var successfulSignupCallCounter = 0
    var failedSignupCallCounter = 0
    var signupError: String?
    
    func successfullSignup() {
        expectation?.fulfill()
        successfulSignupCallCounter += 1
    }
    
    func errorHandler(error: SignupError) {
        expectation?.fulfill()
        failedSignupCallCounter += 1
        signupError = error.localizedDescription
    }
}
