//
//  SideMenu.swift
//  MethodistMobile
//
//  Created by Q002 on 22/02/2024.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowingMenu: Bool
    
    var body: some View {
        ZStack {
            if isShowingMenu {
                Rectangle().opacity(0).ignoresSafeArea().onTapGesture {
                    withAnimation(.easeInOut){
                        isShowingMenu.toggle()
                    }
                }
                
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        SideMenuHeaderView()
                        VStack(alignment: .leading, spacing: 2){
                            SideMenuTabs()
                            SideMenuTabs()
                            SideMenuTabs()
                            SideMenuTabs()
                        }
                        Spacer()
                    }
                    
                    .frame(width: 270, alignment: .leading)
                    .background(.white)
                    Spacer()
                }
            }
        }
        
    }
}

struct SideMenuView_Previews: PreviewProvider {
   
    static var previews: some View {
        SideMenuView(isShowingMenu: .constant(true))
    }
}



struct SideMenuTabs: View {
    var body: some View {
        HStack{
            Image(systemName: "text.book.closed.fill")
                .resizable()
                .imageScale(.large)
                .foregroundColor(.black)
                .frame(width: 22, height: 24)
            Text("Books")
                .font(.system(size: 16, weight: .medium, design: .default)).padding(.horizontal, 20)
        }.padding()
    }
}
