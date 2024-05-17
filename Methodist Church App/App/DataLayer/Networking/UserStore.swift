//
//  UserStore.swift
//  MethodistMobile
//
//  Created by Q002 on 22/02/2024.
//

import Foundation


struct UserStore{
    
    func login(memberCode: String,password: String,completion: @escaping apiResponse<AuthUser?>)-> Void{
        let loginUrl = URL(string: Endpoint.login)!
           
           var request = URLRequest(url: loginUrl)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
           let loginData = LoginRequest(username: memberCode, password: password)
           guard let jsonData = try? JSONEncoder().encode(loginData) else {
               completion(.failure(ErrorType.encodingFailed))
               return
           }
           
           request.httpBody = jsonData
           
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                   completion(.failure(ErrorType.networkError))
                   return
               }
               
               if response.statusCode == 200 {
                   do {
                       let loginResponse = try JSONDecoder().decode(AuthUser.self, from: data)
                       completion(.success(loginResponse))
                   } catch {
                       completion(.failure(ErrorType.decodingFailed))
                   }
               } else {
                   print(response.description)
                   completion(.failure(ErrorType.invalidStatusCode(response.statusCode)))
               }
           }
           
           task.resume()
    }
}
