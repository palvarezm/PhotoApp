//
//  SignupPresenterTests.swift
//  SignupPresenterTests
//
//  Created by Paul Alvarez on 29/07/21.
//

import XCTest
@testable import PhotoApp

class SignupPresenterTests: XCTestCase {
    
    var signupFormModel: SignupFormModel!
    var mockSignupModelValidator: MockSignupModelValidator!
    var mockSignupWebService: MockSignupWebService!
    var mockSignupViewDelegate: MockSignupViewDelegate!
    var sut: SignupPresenter!
    
    override func setUp() {
        signupFormModel = SignupFormModel(firstName: "Sergey", lastName: "SergeysLN", email: "sergey@mail.com", password: "sergeyspw", repeatedPassword: "sergeyspw")
        mockSignupModelValidator = MockSignupModelValidator()
        mockSignupWebService = MockSignupWebService()
        mockSignupViewDelegate = MockSignupViewDelegate()
        sut = SignupPresenter(formModelValidator: mockSignupModelValidator, webService: mockSignupWebService, viewDelegate: mockSignupViewDelegate)
    }
    
    override func  tearDown() {
        signupFormModel = nil
        mockSignupModelValidator = nil
        mockSignupWebService = nil
        mockSignupViewDelegate = nil
        sut = nil
    }
    
    func testSignupPresenter_WhenInformationProvided_WillValidateEachProperty() {
        //Given
        //When
        sut.onSignupTap(formModel: signupFormModel)
        //Then
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated, "First name has a valid value but was not validated")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "last name has a valid value but was not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailValidated, "Email has a valid value but was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValidated, "Password  has a valid value but was not validated")
        XCTAssertTrue(mockSignupModelValidator.arePasswordsEqual, "Repeated password has the same value as password but was not validated")
    }
    
    func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod() {
        //Given
        //When
        sut.onSignupTap(formModel: signupFormModel)
        //Then
        XCTAssertTrue(mockSignupWebService.isSignupMethodCalled, "The signup() method was not called in the SignupWebService class")
    }
    
    func testSignupPresenter_WhenSignupOperationSuccessfull_CallsSuccessOnViewDelegate() {
        //Given
        let expectation = expectation(description: "Expected the successfulSignup() method to be called")
        mockSignupViewDelegate.expectation = expectation
        //When
        sut.onSignupTap(formModel: signupFormModel)
        self.wait(for: [expectation], timeout: 3.0)
        //Then
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCallCounter, 1, "The signup() method has been successfully called more than once or never")
    }
    
    func testSignupPresenter_WhenSignupOperationFailed_CallsErrorOnViewDelegate() {
        //Give
        let expectation = expectation(description: "Expected the failedSignup() method to be called")
        mockSignupViewDelegate.expectation = expectation
        mockSignupWebService.returnsError = true
        //When
        sut.onSignupTap(formModel: signupFormModel)
        self.wait(for: [expectation], timeout: 3.0)
        //Then
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCallCounter, 0, "The signup method should have returned successful counter to 0, but it doesn't")
        XCTAssertEqual(mockSignupViewDelegate.failedSignupCallCounter, 1, "The signup method should have returned failed counter to 0, but it doesn't")
        XCTAssertNotNil(mockSignupViewDelegate.signupError, "The signup method should have returned an error but it doesn't")
    }
}
