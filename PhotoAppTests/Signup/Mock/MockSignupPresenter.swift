//
//  MockSignupPresenter.swift
//  MockSignupPresenter
//
//  Created by Paul Alvarez on 29/07/21.
//

@testable import PhotoApp

class MockSignupPresenter: SignupPresenterProtocol {
    
    var signupCalled = false
    
    required init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol, viewDelegate: SignupViewDelegateProtocol) {
        
    }
    
    func onSignupTap(formModel: SignupFormModel) {
        signupCalled = true
    }
    
}
