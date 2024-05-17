//
//  ErrorType.swift
//  MethodistMobile
//
//  Created by Q002 on 18/02/2024.
//

import Foundation

enum ErrorType: Error{
    case invalidUrl
    case invalidData
    case invalidResponse
    case unableToComplete
    case encodingFailed
    case decodingFailed
    case networkError
    case invalidStatusCode(Int)
}


