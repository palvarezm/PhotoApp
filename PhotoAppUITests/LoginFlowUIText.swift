//
//  LoginFlowUIText.swift
//  LoginFlowUIText
//
//  Created by Paul Alvarez on 1/08/21.
//

import XCTest

class LoginFlowUIText: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        
    }

    func testCreateAccountButton_WhenTappedPresentsSignupViewController() throws {
        //Given
        //When
        let signupButton = app.buttons["createAccountButton"]
        signupButton.tap()
        let signupButtonScreenshot = signupButton.screenshot()
        let signupButtonAttachment = XCTAttachment(screenshot: signupButtonScreenshot)
        signupButtonAttachment.name = "Screenshot of signup button"
        signupButtonAttachment.lifetime = .keepAlways
        add(signupButtonAttachment)
        
        let currentAppWindowScreenshot = app.screenshot()
        let currentAppWindowAttachment = XCTAttachment(screenshot: currentAppWindowScreenshot)
        currentAppWindowAttachment.name = "Screenshot of current app window when button is tapped"
        currentAppWindowAttachment.lifetime = .keepAlways
        add(currentAppWindowAttachment)
        //Then
        let signupViewController = app.otherElements["signupViewController"]
        XCTAssertTrue(signupViewController.waitForExistence(timeout: 1.0), "SignupViewController was not created 1 second after create button is tapped")
    }
}
