//
//  CustomAppbar.swift
//  MethodistMobile
//
//  Created by Q002 on 17/02/2024.
//

import SwiftUI

struct CustomAppbar: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var title: String
    var tittleSpacing: Double = 2
    var leadingIcon:String? = nil
    var centerTitle:Bool = false
    var titleStyle:Font? = .system(size: 16, weight: .medium, design: .default)
    var action: AnyView?
    var backgroundColor: Color = Color("blueColor")
    var hideBackButton:Bool = false
    
    var backButton : some View {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack(spacing: tittleSpacing) {
                    Image(systemName: leadingIcon ?? "chevron.left").foregroundColor(.white)
                        .font(.title2)
                    if centerTitle{
                        Spacer()
                    }
                    Text(title)
                        .font(titleStyle)
                        .foregroundColor(.white)
                    if centerTitle{
                        Spacer()
                    }
                   
                }
            }
        }
    var body: some View {
        HStack{
            if !hideBackButton{
                backButton
            }
            else{
                Text(title)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(.white)
            }
            Spacer()
            if let view = action {
                view
                }
            
        }.padding().background(backgroundColor)
    }
}

struct CustomAppbar_Previews: PreviewProvider {
    static var previews: some View {
        CustomAppbar(title: "Find")
    }
}
