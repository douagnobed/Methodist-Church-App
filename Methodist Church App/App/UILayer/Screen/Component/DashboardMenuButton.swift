//
//  DashboardMenuButton.swift
//  NativeMethodist
//
//  Created by Q002 on 08/02/2024.
//

import SwiftUI

struct DashboardMenuButton: View {
    var title: String
    var icon: String
    var bgColor: Color
    var iconColor: Color = .black
    var iconSize: CGFloat = 45
    var isImage: Bool = true
    var onTap: ()-> Void
    var body: some View {
        VStack(spacing: 10){
                Button(action: {
                    self.onTap()
                }) {
                    if isImage{
                        Image(icon)
                            .renderingMode(.original)
                            .resizable()
                            
                            .frame(width: iconSize, height: iconSize)
                            .foregroundColor(iconColor)
                            .background(bgColor)
                            .clipShape(Circle())
                    }
                    else{
                        Image(systemName: icon)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: iconSize, height: iconSize)
                            .foregroundColor(iconColor)
                            .background(bgColor)
                            .clipShape(Circle()).padding()
                            
                    }
                }.shadow(radius:  6 , y:   4)
            
            Text(title)
                .font(.system(size: 14, weight: .medium, design: .default)).foregroundColor(Color("blueColor"))
        }
        
    }
}

struct DashboardMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        NavbarButton(title: "Payment", icon: "aqi.medium", bgColor: Color("lightBlue"), iconSize: 100, onTap: {})
    }
}
