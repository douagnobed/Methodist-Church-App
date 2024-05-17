//
//  SideMenuHeaderView.swift
//  MethodistMobile
//
//  Created by Q002 on 24/02/2024.
//

import SwiftUI

struct SideMenuHeaderView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Image("menuheader")
                .resizable()
                .renderingMode(.original)
                .frame(width: 270, height: 260).aspectRatio(contentMode: .fill).ignoresSafeArea()
            Color(.black).opacity(0.2)
            VStack(alignment: .leading){
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .frame(width: 68, height: 68)
                
                VStack(alignment: .leading, spacing: 6){
                    Text("Obed")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("M0416010006")
                        .foregroundColor(.white)
                        .font(.subheadline)
                    
                }
            }.padding()
            
        }
        
        .frame(width: 270, height: 250).ignoresSafeArea()
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView()
    }
}
