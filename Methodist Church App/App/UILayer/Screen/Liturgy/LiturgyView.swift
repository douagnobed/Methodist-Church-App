//
//  LiturgyView.swift
//  NativeMethodist
//
//  Created by Q002 on 06/02/2024.
//

import SwiftUI


struct LiturgyView: View {
    let taps:[String] = ["Order", "Liturgist", "Liturgy"]
    @State private var selectedOption: String? = "Order"
    var body: some View {
      
        ZStack{
            
            VStack(spacing: .zero) {
               
                CustomAppbar(title: "Liturgy")
                
                ZStack{
                    Color("bgColor").ignoresSafeArea()

                    VStack{
                        HStack(alignment: .center,spacing: 40) {
                            ForEach(taps, id: \.self) { option in
                                RadioButton(selectedOption: selectedOption ?? "", option: option, action: {
                                    withAnimation{
                                        self.selectedOption = option
                                    }
                                  
                                })
                                  }
                        }.padding(.vertical, 20)
                        Divider()
                            .frame(height: 1.5)
                            .overlay(.gray)
                            .padding(.horizontal)
                        ScrollView(){
                          
                            VStack(spacing: 20){
                                if(selectedOption == "Order"){
                                    LiturgyOrderView()
                                }
                                else if(selectedOption == "Liturgist"){
                                    LiturgyLiturgistView()
                                }
                                else if(selectedOption == "Liturgy"){
                                    LiturgyLiturgyView()
                                }
                            }
                            .padding()
                              
                           
                        }
                    }
                }
            }
        }
      
    }

}

struct LiturgyView_Previews: PreviewProvider {
    static var previews: some View {
        LiturgyView()
    }
}

struct LiturgyOrderView: View {
    var body: some View {
        ForEach(listurgyList) { list in
            ExpansionTile(
                title: "\(list.emoji ?? "") \(list.title)",
                trailingIcon: "chevron.right",
                trailingIconOnExpanded: nil,
                content: VStack{
                    if(list.liturgyContent != nil && !(list.liturgyContent!.isEmpty)){
                        ForEach(list.liturgyContent!) { content in
                            VStack(alignment: .leading, spacing: 10){
                                if(content.title != nil){
                                    Text(content.title!)
                                        .font(.system(size: 16, weight: .bold, design: .default)).padding(.vertical)
                                }
                                Text(content.content)
                            }
                            
                        }
                    }
                    
                }
            )
        }
    }
}

struct LiturgyLiturgistView: View {
    var body: some View {
        ForEach(liturgistContent) { list in
            ExpandedTile(
                title: "\(list.title)",
                trailingIcon: nil,
                content: VStack{
                    
                    if(list.liturgyContent != nil && !(list.liturgyContent!.isEmpty)){
                        ForEach(list.liturgyContent!) { content in
                            VStack(alignment: .leading, spacing: 10){
                                if(content.title != nil){
                                    Text(content.title!)
                                        .font(.system(size: 16, weight: .bold, design: .default)).padding(.vertical)
                                }
                                Text(content.content)
                                
                            }
                            
                        }
                    }
                    
                }
            )
        }
    }
}


struct LiturgyLiturgyView: View {
    var body: some View {
        ForEach(liturgyContent) { list in
            ExpandedTile(
                title: "\(list.title)",
                trailingIcon: nil,
                content: VStack{
                    
                    if(list.liturgyContent != nil && !(list.liturgyContent!.isEmpty)){
                        ForEach(list.liturgyContent!) { content in
                            VStack(alignment: .leading, spacing: 10){
                                if(content.title != nil){
                                    Text(content.title!)
                                        .font(.system(size: 16, weight: .bold, design: .default)).padding(.vertical)
                                }
                                Text(content.content)
                                
                            }
                            
                        }
                    }
                    
                }
            )
        }
    }
}
