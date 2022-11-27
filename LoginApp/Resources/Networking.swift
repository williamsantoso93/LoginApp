//
//  Networking.swift
//  LoginApp
//
//  Created by William Santoso on 27/11/22.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
    case encodingError
    case errorMessage(String)
}

class Networking {
    static var shared = Networking()
    
    public func postData<T:Codable, U: Codable>(to urlString: String, postData: T, completionResponse: @escaping (Result<U,NetworkError>) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(postData) else {
            print(postData)
            print("Error: Trying to convert model to JSON data")
            return completionResponse(.failure(.encodingError))
        }
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return completionResponse(.failure(.noData))
            }
            
            if let decoded = try? JSONDecoder().decode(ErrorMessage.self, from: data) {
                return completionResponse(.failure(.errorMessage(decoded.error)))
            }
            
            guard let decoded = try? JSONDecoder().decode(U.self, from: data) else {
                print(urlString)
                print(String(data: data, encoding: .utf8) ?? "no data")
                
                return completionResponse(.failure(.decodingError))
            }
            
            completionResponse(.success(decoded))
        }.resume()
    }
}
