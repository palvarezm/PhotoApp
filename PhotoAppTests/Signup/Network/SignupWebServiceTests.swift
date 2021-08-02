//
//  SignupWebServiceTests.swift
//  SignupWebServiceTests
//
//  Created by Paul Alvarez on 28/07/21.
//

import XCTest
@testable import PhotoApp

class SignupWebServiceTests: XCTestCase {
    
    var sut: SignupWebService!
    var signupFormRequestModel: SignupFormRequestModel!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignupWebService(urlSession: urlSession, urlString: SignupConstants.signupURLString)
        signupFormRequestModel = SignupFormRequestModel(firstName: "Sergey", lastName: "SergeysLN", email: "Sergeysemail@mail.com", password: "SergeysPW")
    }
    
    override func tearDown() {
        sut = nil
        signupFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }

    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnsSucess() {
        //Given
        let jsonString = SignupConstants.okResponseJsonString
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        //When
        sut.signup(withForm: signupFormRequestModel) { (responseModel, error) in
            //Then
            XCTAssertEqual(responseModel?.status, "ok")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 3.0)
    }
    
    func testSignupWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        //Given
        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        //When
        let expectation = self.expectation(description: "Signup() method expectation for a response that contains a different JSON structure")
        sut.signup(withForm: signupFormRequestModel) { (responseModel, error) in
            //Then
            XCTAssertNil(responseModel, "The response model should have been nil but it's not")
            XCTAssertEqual(error, SignupError.invalidResponseModel, "The signup method should retrieve a responseModelParsingError but it doesn't")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 3.0)
    }
    
    func testSignupWebService_WhenEmptyURLStringProvided_ReturnsError() {
        //Given
        let expectation = self.expectation(description: "An empty request URL string expectation")
        sut = SignupWebService(urlString: "")
        //When
        sut.signup(withForm: signupFormRequestModel) { (responseModel, error) in
            //Then
            XCTAssertEqual(error, SignupError.invalidRequestURLString, "When empty URL string request is called, error should be invalidRequestUrlString")
            XCTAssertNil(responseModel, "Response model should be nil on an empty URL String request")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 3.0)
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        //Given
        let expectation = self.expectation(description: "A failed Request expectation")
        MockURLProtocol.error = SignupError.failedRequest
        //When
        sut.signup(withForm: signupFormRequestModel) { (responseModel, error) in
            XCTAssertEqual(error, SignupError.failedRequest, "The signup method did not return an expected error for a failed request")
            XCTAssertNil(responseModel)
            expectation.fulfill()
        }
        //Then
        self.wait(for: [expectation], timeout: 3.0)
    }
}
