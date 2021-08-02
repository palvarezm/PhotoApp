//
//  SignupPresenter.swift
//  SignupPresenter
//
//  Created by Paul Alvarez on 29/07/21.
//

class SignupPresenter: SignupPresenterProtocol {
    private var formModelValidator: SignupModelValidatorProtocol
    private var webService: SignupWebServiceProtocol
    private weak var viewDelegate: SignupViewDelegateProtocol?
    
    required init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol, viewDelegate: SignupViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.webService = webService
        self.viewDelegate = viewDelegate
    }
    
    func onSignupTap(formModel: SignupFormModel) {
        if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
            viewDelegate?.errorHandler(error: SignupError.invalidFirstName)
            return
        }
        if !formModelValidator.isLastNameValid(lastName: formModel.lastName) {
            viewDelegate?.errorHandler(error: SignupError.invalidLastName)
            return
        }
        if !formModelValidator.isEmailValid(email: formModel.email) {
            viewDelegate?.errorHandler(error: SignupError.invalidEmail)
            return
        }
        if !formModelValidator.isPasswordValid(password: formModel.password) {
            viewDelegate?.errorHandler(error: SignupError.invalidPassword)
            return
        }
        if !formModelValidator.doPasswordMatch(password: formModel.password, repeatedPassword: formModel.repeatedPassword) {
            viewDelegate?.errorHandler(error: SignupError.invalidRepeatedPassword)
            return 
        }
        
        let requestModel = SignupFormRequestModel(firstName: formModel.firstName, lastName: formModel.lastName, email: formModel.email, password: formModel.password)
        webService.signup(withForm: requestModel) { (responseModel, error) in
            //todo
            if let _ = responseModel {
                self.viewDelegate?.successfullSignup()
                return
            }
            if let error = error {
                self.viewDelegate?.errorHandler(error: error)
            }
        }
    }
}
