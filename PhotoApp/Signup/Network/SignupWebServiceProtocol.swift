//
//  SignupWebServiceProtocol.swift
//  SignupWebServiceProtocol
//
//  Created by Paul Alvarez on 29/07/21.
//

protocol SignupWebServiceProtocol {
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping SignupResponseClosure) -> Void
}
