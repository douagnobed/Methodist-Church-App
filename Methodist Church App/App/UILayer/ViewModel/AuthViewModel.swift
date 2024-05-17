//
//  AuthViewModel.swift
//  MethodistMobile
//
//  Created by Q002 on 21/02/2024.
//

import SwiftUI
import JWTDecode

final class AuthViewModel: ObservableObject{
    
   
    @AppStorage("authUser") private var authUser: Data?
    @Published var user:AuthUser?
    @Published var path: NavigationPath = NavigationPath()
    @Published var memberCode:String = ""
    @Published var password:String = ""
    @Published var isLoading:Bool = false
    @Published var isLoginDialogPresented = false
    
    
    @Published var alertItem: AlertItem?
    
    private var userStore = UserStore()
    
    init() {
        self.retrieveUserData()
        if(user != nil){
            memberCode = user!.username
            print("============-Member Code-=============")
            print(memberCode)
        }
    }
    
    var isValidData:Bool{
        guard !memberCode.isEmpty && !password.isEmpty else {
            alertItem = AlertItem(
                id: 1,
                title: "Invalid Input", message: "Please check your inputs", button: .default(Text("ok")))
            return false
        }
        return true
    }
    
    
    
    //Login
    func  submitForm()  {
        isLoading = true
      guard isValidData else {
         isLoading = false
          return }
        userStore.login(memberCode: memberCode, password: password) { data in
            DispatchQueue.main.async {
                switch data {
                   case .success(let loginResponse):
                    print("Login successful! Token: \(loginResponse)")
                    self.saveUserToLocal(authUser: loginResponse!!)
                    //After Login move to Dashboard Screen
                    
                    self.isLoading = false
                    self.isLoginDialogPresented = false
                    self.path.append("Dashboard")
                   case .failure(let error):
                    self.alertItem = AlertItem(
                            id: 1,
                            title: "Server Error", message: error.localizedDescription, button: .default(Text("ok")))
                       print("Login failed with error: \(error)")
                    self.isLoading = false
                   }
            }
        }
     
        
    }
    
    //Verify Church Code
    func passwordResetRequest(phoneNumber:String) -> String?{
        isLoading = true
        var result:String? = nil
        let manager = NetworkManager<String>()
        manager.create(entity: PasswordResetRequest(phoneNumber: phoneNumber), endpoint: Endpoint.requestPasswordReset, token: nil) { data in
            DispatchQueue.main.async {
                switch data {
                   case .success(let response):
                    self.isLoading = false
                    result =  response
                   case .failure(let error):
                    self.alertItem = AlertItem(
                            id: 1,
                            title: "Failed", message: error.localizedDescription, button: .default(Text("ok")))
                       print("Password reset request failed with error: \(error)")
                    self.isLoading = false
                    result =  nil
                   }
            }
        }
        isLoading = false
        return result
    }
    
    
    
    
    func authenticateUser() -> Void{
        if(user == nil || isTokenExpired()){
            self.isLoginDialogPresented = true
            self.alertItem = AlertDialog.tokenAlert
            
        }else{
            self.isLoginDialogPresented = false
        }
        
    }
    
    func dismissAuthDialog()-> Void{
        self.isLoginDialogPresented = false
    }
    
    //Check jwt expiration
    func isTokenExpired() -> Bool {
        if(user != nil){
            do {
                let jwt = try decode(jwt: user!.token)
                print(jwt)
                if let expiresAt = jwt.expiresAt {
                    return expiresAt.timeIntervalSinceNow <= 0
                } else {
                    self.isLoginDialogPresented = false
                    // Token does not contain an expiration claim
                    return false
                }
            } catch {
                // Failed to decode JWT
                print("Failed to decode JWT: \(error)")
                self.isLoginDialogPresented = true
                return false
            }
        }
        return false
    }
    
    
    
    func saveUserToLocal(authUser: AuthUser?)-> Void {
        do{
            let data = try? JSONEncoder().encode(authUser)
            self.authUser = data
            alertItem = AlertItem(
                id: 1,
                title: "Success", message: "User creadentials saved successfully", button: .default(Text("ok")))
        }catch{
            alertItem = AlertItem(
                id: 1,
                title: "Failed", message: "error occurred while saving suser credentials", button: .default(Text("ok")))
        }
    }
    
    func retrieveUserData() {
        guard let authUser = authUser else {return}
        
        do{
            let user = try? JSONDecoder().decode(AuthUser.self, from: authUser)
            self.user = user 
        }catch{
            self.isLoginDialogPresented = true
            print("You are unauthenticated")
        }
    }
}
