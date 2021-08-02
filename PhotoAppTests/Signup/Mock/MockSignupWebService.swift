//
//  MockSignupWebService.swift
//  MockSignupWebService
//
//  Created by Paul Alvarez on 29/07/21.
//

@testable import PhotoApp

class MockSignupWebService: SignupWebServiceProtocol {
    
    var isSignupMethodCalled = false
    var returnsError = false
    
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping SignupResponseClosure) {
        isSignupMethodCalled = true
        
        if returnsError {
            completionHandler(nil, SignupError.failedRequest)
        }
        else {
            completionHandler(SignupResponseModel(status: "ok"), nil)
        }
    }
    
}
