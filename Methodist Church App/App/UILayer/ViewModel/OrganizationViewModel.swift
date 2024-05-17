//
//  OrganizationViewModel.swift
//  MethodistMobile
//
//  Created by Q002 on 22/02/2024.
//

import Foundation
import SwiftUI

final class OrganizationViewModel: ObservableObject{
    
    private  var organizationStore = NetworkManager<OrganizationList>()
    private var authVM = AuthViewModel()
    @Published var  organizations: [Organization] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading:Bool = false
    
    init(organizationStore: NetworkManager<OrganizationList> = NetworkManager(), authUserVM: AuthViewModel = AuthViewModel()) {
        self.organizationStore = organizationStore
        self.authVM = authUserVM
    }
    
    func covertDateToString(date: Date)-> String{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let result = df.string(from: date)
       return result
    }
    
    @MainActor
   func read() -> Void{
       isLoading = true
       guard let user = authVM.user, let token = authVM.user?.token else{
           isLoading = false
           alertItem = AlertDialog.unauthorized
           return
       }
       
       organizationStore.getData(endpoint: Endpoint.organization, token: token) { result in
           DispatchQueue.main.async {
               switch result {
                  case .success(let dataResponse):
                   print("Login successful! Token: \(String(describing: dataResponse))")
                   self.isLoading = false
                   self.organizations = dataResponse!.data
                   print(dataResponse)
                   print(self.organizations)
                  case .failure(let error):
                   print(error)
                   self.isLoading = false
                   self.alertItem = AlertItem(
                           id: 1,
                           title: "Server Error", message: error.localizedDescription, button: .default(Text("ok")))
                      print("Failed to retrieve Organization: \(error)")
                  
                  }
           }
           
       }
       
    }
    
    
    func requestToJoin(organzation: Organization)->Void{
        isLoading = true
        let orgStore = NetworkManager<JoinOrganizationResponse>();
        guard let _ = authVM.user, let token = authVM.user?.token else{
            isLoading = false
            alertItem = AlertItem(
             id: 1,
             title: "UnAuthorized", message: "You are unauthenticated", button: .default(Text("ok")))
            return
        }
        
        
        let orgMember: OrganizationMember = OrganizationMember(memberId: authVM.user!.memberId, organizationId: organzation.id, positionId: "a0d85230-ded4-4d3f-aa67-58c46b88e8b9", joinDate: covertDateToString(date: Date()), organizationMemberStatus: 0)
        
        orgStore.create(entity: orgMember,endpoint: Endpoint.organizationMember, token: token) { result in
            DispatchQueue.main.async {
                switch result {
                   case .success(let dataResponse):
                    print("Login successful! Token: \(String(describing: dataResponse))")
                    self.isLoading = false
                    self.alertItem = AlertItem(
                            id: 1,
                            title: "Success", message: "Request placed successfully!", button: .default(Text("ok")))
                    print(dataResponse)
                    print(self.organizations)
                   case .failure(let error):
                    print(error)
                    self.isLoading = false
                    self.alertItem = AlertItem(
                            id: 1,
                            title: "Server Error", message: error.localizedDescription, button: .default(Text("ok")))
                       print("Failed to retrieve Organization: \(error)")
                   
                   
                   }
            }
            
        }
    }
}
