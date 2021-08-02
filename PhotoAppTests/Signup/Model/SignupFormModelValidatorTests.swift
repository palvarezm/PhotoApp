//
//  SignupFormModelValidatorTests.swift
//  SignupFormModelValidatorTests
//
//  Created by Paul Alvarez on 28/07/21.
//

import XCTest
@testable import PhotoApp

class SignupFormModelValidatorTests: XCTestCase {
    
    var sut: SignupFormModelValidator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override func setUp() {
        sut = SignupFormModelValidator()
    }
    
    override func tearDown() {
        sut = nil
    }

    //MARK: Tests
    
    //MARK: Fisrt Name
    func testSignupFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        //Given
        let validFirstName = "Sergey"
        //When
        let isFirstNameValid = sut.isFirstNameValid(firstName: validFirstName)
        //Then
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should have returned true but is false")
    }
    
    func testSignupFormModelValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        //Given
        let shorterThanValidFirstName = "a"
        //When
        let isFirstNameValid = sut.isFirstNameValid(firstName: shorterThanValidFirstName)
        //Then
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned false for a value with less than \(SignupConstants.firstNameMinLength) but it is true")
    }
    
    func testSignupFormModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFalse() {
        //Given
        let longerThanValidFirstName = "SergeySergey"
        //When
        let isFirstNameValid = sut.isFirstNameValid(firstName: longerThanValidFirstName)
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned false for a value with more than \(SignupConstants.firstNameMaxLength) but it is true")
    }
    
    //MARK: Last Name
    
    func testSignupFormModelValidator_WhenValidLastNameProvided_ShouldReturnTrue() {
        //Given
        let validLastName = "Sergey"
        //When
        let isLastNameValid = sut.isLastNameValid(lastName: validLastName)
        //Then
        XCTAssertTrue(isLastNameValid, "Last name is valid but validation returns false")
    }
    
    func testSignupFormModelValidator_WhenTooShortLastNameProvided_ShouldReturnFalse() {
        //Given
        let shorterThanValidLastName = "a"
        //When
        let isLastNameValid = sut.isLastNameValid(lastName: shorterThanValidLastName)
        //Then
        XCTAssertFalse(isLastNameValid, "Last name is too short <\(SignupConstants.lastNameMinLength) but validation still passes")
    }
    
    func testSignupFormModelValidator_WhenTooLongLastNameProvided_ShouldReturnFalse() {
        //Given
        let longerThanValidLastName = "SergeySergey"
        //When
        let isLastNameValid = sut.isLastNameValid(lastName: longerThanValidLastName)
        //Then
        XCTAssertFalse(isLastNameValid, "Last name is too long > \(SignupConstants.lastNameMaxLength) but validation still passes")
    }
    
    //MARK: Email
    func testSignupFormModelValidator_WhenValidEmailProvided_ShouldReturnTrue() {
        //Given
        let validEmail = "Sergey@mail.com"
        //When
        let isEmailValid = sut.isEmailValid(email: validEmail)
        //Then
        XCTAssertTrue(isEmailValid, "Email has the right format but validation returns false")
    }
    
    //MARK: Password
    
    func testSignupFormModelValidator_WhenValidPasswordProvided_ShouldReturnTrue() {
        //Given
        let validPassword = "abcd1234"
        //When
        let isPasswordValid = sut.isPasswordValid(password: validPassword)
        //Then
        XCTAssertTrue(isPasswordValid, "Password is valid but validation returns false")
    }
    
    func testSignupFormModelValidator_WhenTooShortPasswordProvided_ShouldReturnFalse() {
        //Given
        let shorterThanValidPassword = "abcde"
        //When
        let isPasswordValid = sut.isPasswordValid(password: shorterThanValidPassword)
        //Then
        XCTAssertFalse(isPasswordValid, "Password has less than \(SignupConstants.passwordMinLength) but validation still passed")
    }
    
    func testSignupFormModelValidator_WhenTooLongPasswordProvided_ShouldReturnFalse() {
        //Given
        let longerThanValidPassword = "abcd1234abcd1234"
        //When
        let isPasswordvalid = sut.isPasswordValid(password: longerThanValidPassword)
        //Then
        XCTAssertFalse(isPasswordvalid, "Password has more than \(SignupConstants.passwordMaxLength) but validation still passed")
    }
    
    func testSignupFormModelValidator_WhenPasswordsMatch_ShouldReturnTrue() {
        //Given
        let password = "SergeysPassword"
        let repeatedPassword = "SergeysPassword"
        //When
        let passwordsMatch = sut.doPasswordMatch(password: password, repeatedPassword: repeatedPassword)
        //Then
        XCTAssertTrue(passwordsMatch, "Password and repeated password match but validation returns false")
    }
    
    func testSignupFormModelValidator_WhenPasswordsDontMatch_ShouldReturnFalse() {
        //Given
        let password = "SergeysPassword"
        let repeatedPassword = "SergeysPassword123"
        //When
        let passwordsMatch = sut.doPasswordMatch(password: password, repeatedPassword: repeatedPassword)
        //Then
        XCTAssertFalse(passwordsMatch, "Password and repeated password do not match but validations still passes")
    }
}
