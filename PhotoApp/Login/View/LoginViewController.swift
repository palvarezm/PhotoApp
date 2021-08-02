//
//  LoginViewController.swift
//  LoginViewController
//
//  Created by Paul Alvarez on 1/08/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        self.view.accessibilityIdentifier = "loginViewController"
        createAccountButton.setTitle("Create account", for: .normal)
        createAccountButton.accessibilityIdentifier = "createAccountButton"
    }

    @IBAction func onCreateAccountButtonTapped() {
        let destinationStoyboard = UIStoryboard(name: "Signup", bundle: nil)
        let signupViewContoller = destinationStoyboard.instantiateViewController(withIdentifier: String(describing: SignupViewController.self))
        self.navigationController?.pushViewController(signupViewContoller, animated: true)
    }
    
}
