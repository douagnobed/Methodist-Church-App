//
//  Store.swift
//  MethodistMobile
//
//  Created by Q002 on 13/02/2024.
//

import Foundation
import Alamofire

typealias apiResponse<T: Codable> =  (Swift.Result<T?, ErrorType>) -> Void

protocol Store{
    associatedtype T
    func create(item: T)
    func readById(id: Any)
    func readAll(completion: @escaping ([T]?) -> Void)
    func update(item: T)
    func delete(item: T)
}

class ModelStore<T: Codable>: Store{
    func readAll(completion: @escaping ([T]?) -> Void) {
            print("")
    }
    
    var isLoading:Bool = false
    
   
    func create(item: T) {
        print("")
    }
    
    func readById(id: Any) {
        print("")
    }
    
    
    func update(item: T) {
        print("")
    }
    
    func delete(item: T) {
        print("")
    }
    
    
}


class NetworkManager<T: Codable>{
   
   
    
    
    func create(entity: Codable,endpoint:String, token:String?, completion: @escaping apiResponse<T>){
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if(token != nil){
            request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        }
        
        guard let jsonData = try? JSONEncoder().encode(entity) else {
            completion(.failure(ErrorType.encodingFailed))
            return
        }
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            print("====================================")
            print(data?.description)
            print("====================================")
            print(response)
            print("====================================")
            print(error)
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                completion(.failure(ErrorType.networkError))
                return
            }
            
            if response.statusCode == 200 {
                do {
                    let responseData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseData))
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
     
     
    
    func getData(endpoint:String, token: String? = nil, completed: @escaping apiResponse<T>){
                 guard let url = URL(string: endpoint)  else {
                     completed(.failure(ErrorType.invalidUrl))
                     return
                 }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if(token != nil){
            request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                     
                     print(data)
            print("=========================================== \(T.self)")
                     print(response)
            print("=========================================== \(T.self)")
                     print(error)
                  
                     if let _ = error {
                         print(error?.localizedDescription)
                         completed(.failure(ErrorType.unableToComplete))
                         return
                     }

                     guard let response = response as? HTTPURLResponse, response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 else{
                         completed(.failure(ErrorType.invalidResponse))
                         return
                     }

                     guard let data = data else{
                         completed(.failure(ErrorType.invalidData))
                         return
                     }

                     do{
                         let decoder = JSONDecoder()
                         let decodedResponse = try decoder.decode(T.self, from: data)
                         completed(.success(decodedResponse))
                     }catch{
                         completed(.failure(ErrorType.invalidData))
                     }
                 }

                 task.resume()

    }
}
