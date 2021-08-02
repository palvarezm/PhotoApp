//
//  SignupViewController.swift
//  PhotoApp
//
//  Created by Paul Alvarez on 28/07/21.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatedPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var presenter: SignupPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        #if DEBUG
        if CommandLine.arguments.contains("-skipOnboarding") {
            debugPrint("Skip on Boarding is setted")
        }
        #endif
        
        let formModelValidator = SignupFormModelValidator()
        let signupURL = ProcessInfo.processInfo.environment["signupURL"] ?? SignupConstants.signupURLString
        let webService = SignupWebService(urlString: signupURL)
        presenter = SignupPresenter(formModelValidator: formModelValidator, webService: webService, viewDelegate: self)
    }
    
    func setupView() {
        self.view.accessibilityIdentifier = "signupViewController"
        firstNameTextField.placeholder = "First name"
        firstNameTextField.accessibilityIdentifier = "firstNameTextField"
        lastNameTextField.placeholder = "Last name"
        lastNameTextField.accessibilityIdentifier = "lastNameTextField"
        emailTextField.placeholder = "Email"
        emailTextField.accessibilityIdentifier = "emailTextField"
        passwordTextField.placeholder = "Password"
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        passwordTextField.isSecureTextEntry = true
        repeatedPasswordTextField.placeholder = "Please repeat your password"
        repeatedPasswordTextField.accessibilityIdentifier = "repeatedPasswordTextField"
        repeatedPasswordTextField.isSecureTextEntry = true
        signupButton.setTitle("Signup", for: .normal)
        signupButton.accessibilityIdentifier = "signupButton"
    }

    @IBAction func onSignupButtonTapped() {
        let formModel = SignupFormModel(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "", repeatedPassword: repeatedPasswordTextField.text ?? "")
        presenter?.onSignupTap(formModel: formModel)
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "alert"
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension SignupViewController: SignupViewDelegateProtocol {
    func successfullSignup() {
        presentAlert(title: "Success", message: "")
    }
    
    func errorHandler(error: SignupError) {
        presentAlert(title: "Error", message: "")
    }
}
