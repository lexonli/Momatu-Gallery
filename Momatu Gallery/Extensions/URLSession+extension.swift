//
//  URLSession+extension.swift
//  Momatu Gallery
//
//  Created by Lexon on 2/12/2020.
//

import Foundation
import SwiftyJSON

extension URLSession {
    
    typealias DataTaskCompletionHandler = ((Data?, URLResponse?, Error?) -> ())
    
    /// Gets a data task that performs a GET network request
    /// - Parameters:
    ///   - url: The url to perform the GET
    ///   - result: A result object that contains the data if success, APIServiceError if failed
    /// - Returns: The URLSessionDataTask that performs the GET request
    func get(with url: String, result: @escaping (Result<Data, APIServiceError>) -> Void) -> URLSessionDataTask {
        let url = URL(string: url)!
        let request = URLRequest(url: url)
        return dataTask(with: request, completionHandler: getCompletionHandler(result: result))
    }
    
    private func getCompletionHandler(result: @escaping (Result<Data, APIServiceError>) -> Void) -> DataTaskCompletionHandler {
        return { (data, response, error) in
            if error != nil {
                print("error: ", error.debugDescription)
                result(.failure(.apiError))
                return
            }
            guard let response = response, let data = data else {
                result(.failure(.apiError))
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                result(.failure(.invalidResponse))
                return
            }
            result(.success(data))
        }
    }
}

public enum APIServiceError: Error {
    case apiError
    case invalidResponse
    case decodeError
}
