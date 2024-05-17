//
//  ManageClass.swift
//  MethodistMobile
//
//  Created by Q002 on 10/02/2024.
//

import SwiftUI

struct ManageClassView: View {
    let segements = ["mark attendance", "Attendance history"]
    @State private var selectedSegmentedBtn: String? = "mark attendance"
    @StateObject private var classAttendanceVM = ClassAttendanceViewModel()
    var body: some View {
       
        ZStack{
            VStack(alignment: .leading) {
                HStack{
                    Text("Manage Class")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(.white)
                    Spacer()
                    
                }.padding().background(Color("blueColor"))
                VStack {
                    Picker("", selection: $selectedSegmentedBtn){
                        ForEach(segements, id: \.self){
                            seg in
                            Text(seg).onTapGesture {
                                withAnimation{
                                    self.selectedSegmentedBtn = seg
                                }
                            }
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle()).padding()
                    Spacer()
                    if(selectedSegmentedBtn == "mark attendance")
                    {
                        MarkAttendanceView()
                    }else{
                        Text("No Segmented selected")
                    }
                        
                }
            }.alert(item: $classAttendanceVM.alertItem) { item in
                Alert(title: Text(item.title), message: Text(item.message),  dismissButton: item.button)
            }

        }.alert(item: $classAttendanceVM.alertItem) { item in
            Alert(title: Text(item.title), message: Text(item.message),  dismissButton: item.button)
        }
        
    }
    
}

struct ManageClass_Previews: PreviewProvider {
    static var previews: some View {
        ManageClassView()
    }
}

struct AttendanceRow: View {
    var attendanceMember:AttendanceMember
    @State private var present:String = ""
    @State private var reason:String = ""
    @StateObject private var classAttendanceVM = ClassAttendanceViewModel()
    var body: some View {
        VStack(spacing: 30){
            HStack{
                Text("\(attendanceMember.lastName) \(attendanceMember.firstName)")
                    .font(.system(size: 16, weight: .bold, design: .default))
                Spacer()
                RadioButton(selectedOption: classAttendanceVM.userAlreadyMarked(memberCode: attendanceMember.username) == nil ?present:classAttendanceVM.userAlreadyMarked(memberCode: attendanceMember.username)?.attendanceStatus == 0 ? "A":present, option: "A", action: {
                    withAnimation{
                        present = "A"
                        classAttendanceVM.markClassAttendance(attendance: Attendance(memberId: attendanceMember.id, memberCode: attendanceMember.username, attendanceStatus: present ==  "A" ? 0 : 1, reason: reason != "" ? reason:nil))
                    }
                })
                RadioButton(selectedOption: classAttendanceVM.userAlreadyMarked(memberCode: attendanceMember.username) == nil ? present:classAttendanceVM.userAlreadyMarked(memberCode: attendanceMember.username)?.attendanceStatus == 1 ? "P":present, option: "P", action: {
                    withAnimation{
                        present = "P"
                        reason = ""
                        classAttendanceVM.markClassAttendance(attendance: Attendance(memberId: attendanceMember.id, memberCode: attendanceMember.username, attendanceStatus: present ==  "A" ? 0 : 1))
                    }
                    
                })
                
            }
        }
        if(present == "A"){
            TextField("Reason for absence", text: $reason).onChange(of: reason) { newValue in
                // Send the input when the user finishes typing
                print("User input: \(newValue)")
                classAttendanceVM.markClassAttendance(attendance: Attendance(memberId: attendanceMember.id, memberCode: attendanceMember.username, attendanceStatus: present ==  "A" ? 0 : 1, reason: reason != "" ? newValue:nil))
            }
        }
    }
    
    
}

struct MarkAttendanceView: View {
   @StateObject private var classAttendanceVM = ClassAttendanceViewModel()
    var body: some View {
        VStack{
            if(classAttendanceVM.isLoading){
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            else{
                if(!classAttendanceVM.classMembers.isEmpty)
                {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 30){
                            ForEach(classAttendanceVM.classMembers){
                                attendanceMember in
                                AttendanceRow(attendanceMember: attendanceMember)
                            }
                            Button {
                                classAttendanceVM.submitAttendance()
                            } label: {
                                Text("✔️Submit")
                            }

                        }
                    }.padding()
                }
            }

        }
        
        .onAppear{
            classAttendanceVM.read()
        }
    }
}
