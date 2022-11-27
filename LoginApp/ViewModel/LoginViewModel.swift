//
//  LoginViewModel.swift
//  LoginApp
//
//  Created by William Santoso on 27/11/22.
//

import Foundation

protocol LoginViewModelProtocol {
    func login(user: User, completion: @escaping (String?, NetworkError?) -> Void)
}

internal final class LoginViewModel: LoginViewModelProtocol {
    func login(user: User, completion: @escaping (String?, NetworkError?) -> Void) {
        LoginDomain.postLogin(user: user) { (result: Result<(user: User, token: Token), NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    completion(data.token.token, nil)
                case .failure(let error) :
                    completion(nil, error)
                }
            }
        }
    }
}
