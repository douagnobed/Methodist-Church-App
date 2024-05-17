//
//  NoteList.swift
//  MethodistMobile
//
//  Created by Q002 on 11/02/2024.
//

import SwiftUI

struct NoteListView: View {
    @State private var isAddNotePresented:Bool = false
    @StateObject private var noteVM = NoteViewModel()
    var body: some View {
        
        NavigationStack{
            ZStack{
                VStack {
                    CustomAppbar(title: "Journal")

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 30) {
                            if(noteVM.noteList.isEmpty){
                                Text("Empty List")
                            }
                            else{
                                ForEach(noteVM.noteList){ note in
                                    HStack(alignment: .top) {
                                       (note.priority == "high")
                                        ?
                                        Color.red.frame(width: 5).shadow(radius: 20)
                                        :
                                        (note.priority == "medium")
                                        ?
                                            Color.yellow.frame(width: 5).shadow(radius: 20)
                                        :
                                            Color("blueColor").frame(width: 5).shadow(radius: 20)
                                        
                                    
                                        VStack{
                                            HStack{
                                                Text(note.title ?? "")
                                                     .font(.system(size:18, weight: .bold, design: .default))
                                                Spacer()
                                             
                                                
                                            }.padding(.vertical)
                                            ExpandableText(note.content ?? "", lineLimit: 5).padding(.horizontal, 2)
                                        }
                                       
                                    }.padding(10).background(.white).cornerRadius(10).shadow(radius: 1.5, x: 1, y:1)
                                }
                               
                            }
                          
                           
                        }
                    }.padding(10)
                    
                }
                NavigationLink {
                    AddNoteView()
                } label: {
                        Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                            .background(Color.green)
                             .foregroundColor(.white)
                                .clipShape(Circle())
                         .shadow(radius: 4, x: 0, y: 4)
                }

            }.background(Color("bgColor")).alert(item: $noteVM.alertItem) { item in
                Alert(title: Text(item.title), message: Text(item.message),  dismissButton: item.button)
            }
        }
   
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
    }
}

