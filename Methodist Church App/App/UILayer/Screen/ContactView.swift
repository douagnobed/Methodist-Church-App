//
//  ContactView.swift
//  NativeMethodist
//
//  Created by Q002 on 07/02/2024.
//

import SwiftUI

struct ContactView: View {
    var body: some View {
        ZStack{
            
            VStack(spacing: .zero) {
               
                CustomAppbar(title: "Contact Us")

                
                ZStack{
                    Color("bgColor").ignoresSafeArea()

                    ScrollView(){
                      
                        VStack(spacing: 20){
                            VStack(spacing: 10){
                                Text("CONFERENCE OFFICE")
                                    .font(.system(size: 18, weight: .bold, design: .default))
                                Text("E25/2 Liberia Road, P.O. Box 403, Accra Ghana")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                HStack{
                                    Text("Telephone:")
                                        .foregroundColor(.blue)
                                    VStack{
                                        Text("+233302679233")
                                        Text("+233302679233")
                                    }
                                }
                            }.padding().shadow(radius: 10)
                            ContactComponent()
                        
                        }
                        .padding()
                        
                        
                    }
                    
                }
            }
        }
      
    }
}

struct ContactComponent: View {
    var body: some View {
        ForEach(dioceseList) { list in
            ExpansionTile(
                title: "\(list.name)",
                trailingIcon: "chevron.right",
                trailingIconOnExpanded: nil,
                content: VStack(alignment: .leading){
                    VStack(alignment: .leading, spacing: 10){
                        Text(list.contactOffice)
                        Text(list.contact)
                    }.frame(width: 250,
                            alignment: .leading)
                    if(!(list.branches.isEmpty)){
                        ForEach(0..<list.branches.count) { branch in
                            VStack(alignment: .leading, spacing: 15){
                                
                                Text(list.branches[branch])
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                    
                            }.frame(width: 250,
                                    alignment: .leading)

                        }
                    }
                    
                }
            )
        }
    }
}


struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}






