//
//  AuthUser.swift
//  MethodistMobile
//
//  Created by Q002 on 22/02/2024.
//

import Foundation

struct AuthUser:Codable, Identifiable{
    let id: String
    let token: String
    let email:String?
    let username: String
    let accountType: Int
    let hasVerifiedOtp: Bool
    let firstTimeLogin: Bool
    let joined: String
    let lastLogin: String
    let isActive: Bool
    let memberId: String
    let classId: String
    
}
