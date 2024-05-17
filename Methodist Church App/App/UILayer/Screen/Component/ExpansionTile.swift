//
//  ExpansionTile.swift
//  NativeMethodist
//
//  Created by Q002 on 06/02/2024.
//

import SwiftUI

struct ExpansionTile<Content: View>: View {
    let title: String
    var textColor:Color?
    var trailingIcon: String = "chevron.up"
    var trailingIconColor: Color?
    var backgroundColor:Color?
    let trailingIconOnExpanded: String?
    var content: Content?
    var cornerRadius:CGFloat = 10
    var borderWidth: CGFloat?
    var borderColor:Color?
    
    
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                if(content != nil){
                    withAnimation {
                        self.isExpanded.toggle()
                    }
                }
            }) {
                HStack {
                    Text(title).font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(textColor ?? .black)
                    Spacer()
                    Image(systemName: isExpanded ? trailingIcon : trailingIconOnExpanded != nil ? trailingIconOnExpanded! : trailingIcon)
                        .foregroundColor(trailingIconColor ?? .black)
                }
                .padding()
            }
            if(content != nil)
            {
                if isExpanded {
                    Divider()
                        .frame(height: 1.5)
                        .overlay(.black)
                        .padding(.horizontal)
                    content
                        .padding()
                }
            }
        }
        .background(backgroundColor ?? Color.white)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor ?? .black, lineWidth: borderWidth ?? 1)
        )
//        .cornerRadius(10)
//        .border(.red, width: 4)
//        .shadow(radius: 2)
    }
}


struct ExpandedTile<Content: View>: View {
    let title: String
    var trailingIcon: String?
    var content: Content?
    var cornerRadius:CGFloat = 10
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {}) {
                HStack {
                    Text(title).font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(.black)
                    Spacer()
                    if(trailingIcon != nil){
                        Image(systemName: trailingIcon!)
                            .foregroundColor(.black)
                    }
                }
                .padding()
            }
            if(content != nil)
            {
                
                    Divider()
                        .frame(height: 1.5)
                        .overlay(.black)
                        .padding(.horizontal)
                    content
                        .padding()
                
            }
        }
        .background(Color.white)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 8)
                .stroke(.black, lineWidth: 1)
        )
//        .cornerRadius(10)
//        .border(.red, width: 4)
//        .shadow(radius: 2)
    }
}

struct ExpansionTile_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            ExpansionTile<Text?>(
                title: " Expansion Title",
                trailingIcon: "chevron.right",
                trailingIconOnExpanded: nil,
                content: nil
            ).padding()
            ExpansionTile(
                title: " Expansion Title",
                trailingIcon: "chevron.right",
                trailingIconOnExpanded: nil,
                content: VStack{
                    Text("This is the content of the expansion tile")
                }
            ).padding()
        }
        
        
    }
}
