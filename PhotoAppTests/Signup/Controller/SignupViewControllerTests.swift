//
//  SignupViewControllerTests.swift
//  SignupViewControllerTests
//
//  Created by Paul Alvarez on 29/07/21.
//

import XCTest
@testable import PhotoApp

class SignupViewControllerTests: XCTestCase {

    var storyboard: UIStoryboard!
    var sut: SignupViewController!
    var mockSignupPresenter: MockSignupPresenter!
    
    override func setUp() {
        storyboard = UIStoryboard(name: "Signup", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: SignupViewController.self)) as? SignupViewController
        sut?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        storyboard = nil
        sut = nil
    }
    
    func testSignupViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        //Given
        //When
        let unwrappedFirstNameTextField = try XCTUnwrap(sut.firstNameTextField, "The firstName textfield is not connected to storyboard")
        let unwrappedLastNameTextField = try XCTUnwrap(sut.lastNameTextField, "The lastName textfield is not connected to storyboard")
        let unwrappedEmailTextField = try XCTUnwrap(sut.emailTextField, "The email textfield is not connected to storyboard")
        let unwrappedPasswordTextField = try XCTUnwrap(sut.passwordTextField, "The password textfield is not connected to storyboard")
        let unwrappedRepeatedPasswordTextField = try XCTUnwrap(sut.repeatedPasswordTextField, "The repeated password textfield is not connected to storyboard")
        //Then
        XCTAssertEqual(unwrappedFirstNameTextField.text, "", "The first name textfield is empty")
        XCTAssertEqual(unwrappedLastNameTextField.text, "", "The last name textfield is empty")
        XCTAssertEqual(unwrappedEmailTextField.text, "", "The email textfield is empty")
        XCTAssertEqual(unwrappedPasswordTextField.text, "", "The password textfield is empty")
        XCTAssertEqual(unwrappedRepeatedPasswordTextField.text, "", "The repeated password textfield is empty")
    }

    func testSignupViewController_WhenCreated_HasSignupButtonAndAction() throws {
        //Given
        let signupButton = try XCTUnwrap(sut.signupButton, "Signup button is not connected to storyboard")
        //When
        let signupButtonActions = try XCTUnwrap( signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
        //Then
        XCTAssertEqual(signupButtonActions.count, 1, "Signup button doesnt have only one action assigned")
        XCTAssertTrue(signupButtonActions.contains("onSignupButtonTapped"), "There is not action with a name onSignupButtonTapped assigned to signup button")
    }
    
    func testSignupViewController_WhenSignupButtonTapped_CallsSignup() {
        //Given
        let mockSignupModelValidator = MockSignupModelValidator()
        let mockSignupWebService = MockSignupWebService()
        let mockSignupViewDelegate = MockSignupViewDelegate()
        
        let mockSignupPresenter = MockSignupPresenter(formModelValidator: mockSignupModelValidator, webService: mockSignupWebService, viewDelegate: mockSignupViewDelegate)
        
        sut.presenter = mockSignupPresenter
        //When
        sut.signupButton.sendActions(for: .touchUpInside)
        //Then
        XCTAssertTrue(mockSignupPresenter.signupCalled, "The signup() method was not called on a Presenter object when the signup button was tapped in a SignupViewController")
    }
}
