//
//  SignupWebService.swift
//  SignupWebService
//
//  Created by Paul Alvarez on 28/07/21.
//

import Foundation

typealias SignupResponseClosure = (SignupResponseModel?, SignupError?) -> (Void)

class SignupWebService: SignupWebServiceProtocol {
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlSession: URLSession = .shared, urlString: String) {
        self.urlSession = urlSession
        self.urlString = urlString
    }
    
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping SignupResponseClosure) {
        guard let url = URL(string: urlString) else {
            completionHandler(nil, SignupError.invalidRequestURLString)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(formModel)
        
        let dataTask = urlSession.dataTask(with: request) { (data ,response ,error) in
            if let _ = error {
                completionHandler(nil, SignupError.failedRequest)
                return
            }
            else if let data = data, let signupResponseModel = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                completionHandler(signupResponseModel, nil)
            }
            else {
                completionHandler(nil, SignupError.invalidResponseModel)
            }
        }
        
        dataTask.resume()
    }
}
