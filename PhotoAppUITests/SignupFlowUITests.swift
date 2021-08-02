//
//  PhotoAppUITests.swift
//  PhotoAppUITests
//
//  Created by Paul Alvarez on 28/07/21.
//

import XCTest
@testable import PhotoApp

class SignupFlowUITests: XCTestCase {
    var app: XCUIApplication!
    var firstName: XCUIElement!
    var lastName: XCUIElement!
    var email: XCUIElement!
    var password: XCUIElement!
    var repeatedPassword: XCUIElement!
    var signupButton: XCUIElement!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = XCUIApplication()
        app.launchArguments = ["-skipOnboarding", "-debugServer"]
//        app.launchEnvironment = ["signupURL": "http://appsdeveloperblog.com:8080/signup-mock-service/users",
//                                 "inAppPurchasesEnabled": "true",
//                                 "inAppAdsEnabled": "true"]
        app.launch()
        
        let createAccountButton = app.buttons["createAccountButton"]
        createAccountButton.tap()

        firstName = app.textFields["firstNameTextField"]
        lastName = app.textFields["lastNameTextField"]
        email = app.textFields["emailTextField"]
        password = app.secureTextFields["passwordTextField"]
        repeatedPassword = app.secureTextFields["repeatedPasswordTextField"]
        signupButton = app.buttons["signupButton"]

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        app = nil
        firstName = nil
        lastName = nil
        email = nil
        password = nil
        repeatedPassword = nil
        signupButton = nil
        try super.tearDownWithError()
    }

    func testSignupViewController_WhenViewIsLoaded_RequiredUIElementsAreEnabled() throws {
        // UI tests must launch the application that they test.
        XCTAssertTrue(firstName.isEnabled, "First name uitextfield is not enabled for interactions")
        XCTAssertTrue(lastName.isEnabled, "LastName uitextfield is not enabled for interactions")
        XCTAssertTrue(email.isEnabled, "Email uitextfield is not enabled for interactions")
        XCTAssertTrue(password.isEnabled, "Password uitextfield is not enabled for interactions")
        XCTAssertTrue(repeatedPassword.isEnabled, "RepeatedPassword uitextfield is not enabled for interactions")
        XCTAssertTrue(signupButton.isEnabled, "Signup button is not enabled for interactions")
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSignupViewController_WhenInvalidInformationProvided_PresentsErrorAlert() {
        //Given
        //When
        firstName.tap()
        firstName.typeText("S")
        
        lastName.tap()
        lastName.typeText("S")
        
        email.tap()
        email.typeText("@")
        
        password.tap()
        password.typeText("123456")
        
        repeatedPassword.tap()
        repeatedPassword.typeText("123")
        
        signupButton.tap()
        //Then
        let errorAlert = app.alerts["alert"]
        XCTAssertTrue(errorAlert.waitForExistence(timeout: 1.0), "An alert dialog was not presented when an invalid signup form was submitted")
    }
    
    func testSignupViewController_WhenValidInformationProvided_PresentsSuccessAlert() {
        //Given
        //When
        firstName.tap()
        firstName.typeText("Sergey")
        
        lastName.tap()
        lastName.typeText("SergeysLN")
        
        email.tap()
        email.typeText("Sergey@mail.com")
        
        password.tap()
        password.typeText("123456")
        
        repeatedPassword.tap()
        repeatedPassword.typeText("123456")
        
        signupButton.tap()
        //Then
        let successAlert = app.alerts["alert"]
        XCTAssertTrue(successAlert.waitForExistence(timeout: 1.0), "An alert dialog was not presented when an valid signup form was submitted")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
