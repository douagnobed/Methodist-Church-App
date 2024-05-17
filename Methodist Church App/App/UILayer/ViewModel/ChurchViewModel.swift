//
//  ChurchViewModel.swift
//  MethodistMobile
//
//  Created by Q002 on 26/02/2024.
//

import Foundation
import SwiftUI

final class ChurchViewModel: ObservableObject{
    @Published var churches: [Church]? = []
    @Published var isLoading: Bool = false
    private let churchStore = NetworkManager<Church>()
    @Published var alertItem: AlertItem?
    
    func all()-> Void{
        isLoading = true
        NetworkManager<Churches>().getData(endpoint: "\(Endpoint.society)", token: nil){ data in
            
            DispatchQueue.main.async {
                switch(data)
                {
                case .success(let churches):
                    self.churches = churches?.data
                    self.isLoading = false
                    print(churches)
                case .failure(let error):
                    self.isLoading = false
                    self.alertItem = AlertItem(id: 1, title: "Failed", message: error.localizedDescription, button: .default(Text("Ok")))
                }
            }
        }
    }
    
    func getChurchByCode(churchCode:String)-> Church? {
        self.isLoading = true
        var result:Church? = nil
        churchStore.getData(endpoint: "\(Endpoint.society)/society/\(churchCode)") { data in
            DispatchQueue.main.async {
                switch(data)
                {
                case .success(let church):
                    result = church
                    print(church)
                case .failure(let error):
                    self.alertItem = AlertItem(id: 1, title: "Failed", message: error.localizedDescription, button: .default(Text("Ok")))
                }
            }
        }
        self.isLoading = false
        return result
    }
}
