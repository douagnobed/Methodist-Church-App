//
//  AddNoteView.swift
//  MethodistMobile
//
//  Created by Q002 on 11/02/2024.
//

import SwiftUI

struct AddNoteView: View {
    var priorities = ["high", "medium", "low"]
    @State private var message:String = ""
    @State private var title:String = ""
    @State private var selectedPriority = "low"
    @StateObject private var noteVM = NoteViewModel()
    var body: some View {
        NavigationStack {
                ZStack{
                        VStack(spacing: 50){
                            VStack {
                                TextField("Title", text: $title)
                                Divider().background(.gray)
                            }
                            HStack {
                                Text("Priority")
                                Spacer()
                                Picker("Priority", selection: $selectedPriority){
                                    ForEach(priorities,id: \.self){
                                        Text($0)
                                    }
                                    
                                }
                            }.padding()
                                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
                            CustomInputField(multilineTextFiled: true, placeholder: "Message", text: $message)
                        }
                  

                }.background(Color("bgColor"))
                .ignoresSafeArea(.all, edges: [.bottom, .top])
                .padding()
                .navigationBarItems(trailing: Button(action: {
                    if(!title.isEmpty && !selectedPriority.isEmpty && !message.isEmpty){
                        noteVM.addNote(title: title, priority: selectedPriority, content: message)
                    }
                    
                }, label: {
                    Image(systemName: "checkmark").aspectRatio( contentMode: .fit).foregroundColor(.green)
                }))
                .alert(item: $noteVM.alertItem) { item in
                    Alert(title: Text(item.title), message: Text(item.message),  dismissButton: item.button)
                }
            
        }.overlay(alignment: .top) {
            Color.clear
                .background(.regularMaterial)
                .ignoresSafeArea(edges: .top)
                .frame(height: 0)
    }
            }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
