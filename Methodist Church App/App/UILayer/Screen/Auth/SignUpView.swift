//
//  SignUpView.swift
//  NativeMethodist
//
//  Created by Q002 on 09/02/2024.
//

import SwiftUI

struct SignUpView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthDate = Date()
    @State private var phoneNumber = ""
    @State private var password = ""
    var body: some View {
        NavigationView{
            VStack {
                Form{
                    TextField("First Name", text: $firstName, prompt: Text("Enter first name"))
                        .frame(height: 40)
                    TextField("Last Name", text: $lastName).frame(height: 40)
                    DatePicker("Birthdate", selection: $birthDate, displayedComponents: .date).frame(height: 40)
                    TextField("Phone Number", text: $phoneNumber).frame(height: 40)
                    TextField("Email", text: $password).frame(height: 40)
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("✔️ Submit")
                    }
                    }

                }
                
            }.navigationTitle("Member Registration").navigationBarTitleDisplayMode(.inline)
                
           
        }.background(.red)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
