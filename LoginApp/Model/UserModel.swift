//
//  UserModel.swift
//  LoginApp
//
//  Created by William Santoso on 27/11/22.
//

import Foundation

struct User: Codable {
    let email: String
    let password: String
}

struct Token: Codable {
    let token: String
}


struct ErrorMessage: Codable {
    let error: String
}

