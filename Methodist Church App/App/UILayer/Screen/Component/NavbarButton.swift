//
//  NavbarButton.swift
//  NativeMethodist
//
//  Created by Q002 on 04/02/2024.
//

import Foundation
import SwiftUI

struct NavbarButton: View {
    var title: String?
    var icon: String
    var bgColor: Color
    var iconColor: Color = .black
    var iconSize: CGFloat = 45
    var isImage: Bool = false
    var onTap: ()-> Void
    var body: some View {
        VStack(spacing: 5){
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
                            .frame(width: iconSize, height: iconSize)
                            .foregroundColor(iconColor)
                            .background(bgColor)
                            .clipShape(Circle())
                    }
                }.shadow(radius: isImage ? 0 : 6 , y: isImage ? 0 :  4)
            
            if(title != nil){
                Text(title!)
                    .font(.system(size: 12, weight: .medium, design: .default))
            }
        }
        
    }
}
