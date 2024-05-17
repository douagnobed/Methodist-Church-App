//
//  ClassAttendanceViewModel.swift
//  MethodistMobile
//
//  Created by Q002 on 22/02/2024.
//

import Foundation
import SwiftUI

final class ClassAttendanceViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var classMembers:[AttendanceMember] = []
    @Published var attendanceList:[Attendance] = []
    private var classMembersStore = NetworkManager<AttendanceMemberList>()
    private var authVM = AuthViewModel()
    @Published var alertItem:AlertItem?
    
    func userAlreadyMarked(memberCode: String)-> Attendance?{
        if let object = attendanceList.first(where: { $0.memberCode == memberCode }) {
            return object
        }
        return nil
    }
    
    
    func markClassAttendance(attendance:Attendance)-> Void{
        
        if let index = attendanceList.firstIndex(where: { $0.memberCode == attendance.memberCode }) {
            var objectToUpdate = attendanceList[index]
            objectToUpdate.attendanceStatus = attendance.attendanceStatus
            objectToUpdate.reason = attendance.reason
            attendanceList[index] = objectToUpdate
            print(objectToUpdate)
        } else {
            attendanceList.append(attendance)
            print(attendance)
            
        }
        print(attendanceList)
    }
    
    func submitAttendance() -> Void{
        if(attendanceList.count <= 0 || attendanceList.count < classMembers.count){
            self.alertItem = AlertItem(
                id: 1,
                title: "Incomplete", message: "You have marked \(attendanceList.count) of \(classMembers.count) members", button: .default(Text("ok")))
        }
        else{
            print("=====================================================")
            print(attendanceList)
        }
    }
    
    func read() -> Void{
        isLoading = true
        guard let user = authVM.user, let token = authVM.user?.token else{
            isLoading = false
            alertItem = AlertItem(
             id: 1,
             title: "UnAuthorized", message: "You are unauthenticated", button: .default(Text("ok")))
            return
        }
        
        classMembersStore.getData(endpoint: "\(Endpoint.memberByClass)/\(user.classId)", token: token) { result in
            switch result {
               case .success(let dataResponse):
                print("Login successful! Token: \(String(describing: dataResponse))")
                self.isLoading = false
                self.classMembers = dataResponse!.data
                print(dataResponse)
                print(self.classMembers)
               case .failure(let error):
                print(error)
                self.isLoading = false
                self.alertItem = AlertItem(
                        id: 1,
                        title: "Server Error", message: error.localizedDescription, button: .default(Text("ok")))
                   print("Failed to retrieve Class Members: \(error)")
               
               }
            
        }
        
     }
     
}
