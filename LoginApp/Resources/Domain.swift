//
//  Domain.swift
//  LoginApp
//
//  Created by William Santoso on 27/11/22.
//

import Foundation

class LoginDomain {
    public static func postLogin(user: User, completion: @escaping (Result<(user: User,token: Token), NetworkError>) -> Void) {
        Networking.shared.postData(to: "https://reqres.in/api/login", postData: user) { (result: Result<Token, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    completion(.success((user, data)))
                case .failure(let error) :
                    completion(.failure(error))
                }
            }
        }
    }
}
