//
//  SignupPresenterProtocol.swift
//  SignupPresenterProtocol
//
//  Created by Paul Alvarez on 29/07/21.
//

protocol SignupPresenterProtocol: AnyObject {
    
    init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol, viewDelegate: SignupViewDelegateProtocol)
    
    func onSignupTap(formModel: SignupFormModel) -> (Void)
}
