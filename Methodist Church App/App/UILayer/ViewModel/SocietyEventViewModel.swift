//
//  SocietyEventViewModel.swift
//  MethodistMobile
//
//  Created by Q002 on 22/02/2024.
//

import Foundation
import SwiftUI

final class SocietyEventViewModel:ObservableObject{
    private var societyStore = NetworkManager<SocietyEventList>()
     private var authVM = AuthViewModel()
    @Published var  societyEvents: [SocietyEvent] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading:Bool = false
    
    func read()->Void{
        isLoading = true
        guard let user = authVM.user, let token = authVM.user?.token else{
            isLoading = false
            alertItem = AlertItem(
             id: 1,
             title: "UnAuthorized", message: "You are unauthenticated", button: .default(Text("ok")))
            return
        }
        
        societyStore.getData(endpoint: Endpoint.societyEvent) { result in
            switch result {
               case .success(let dataResponse):
                print("Login successful! Token: \(String(describing: dataResponse))")
                self.isLoading = false
                self.societyEvents = dataResponse!.data
                print(dataResponse)
                print(self.societyEvents)
               case .failure(let error):
                print(error)
                self.isLoading = false
                self.alertItem = AlertItem(
                        id: 1,
                        title: "Server Error", message: error.localizedDescription, button: .default(Text("ok")))
                   print("Failed to retrieve Society Event: \(error)")
               
               }
        }
    }
}
