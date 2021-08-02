//
//  SignupViewDelegateProtocol.swift
//  SignupViewDelegateProtocol
//
//  Created by Paul Alvarez on 29/07/21.
//

protocol SignupViewDelegateProtocol: AnyObject {
    func successfullSignup()
    func errorHandler(error: SignupError)
}
