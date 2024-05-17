//
//  DashboardView.swift
//  NativeMethodist
//
//  Created by Q002 on 08/02/2024.
//

import SwiftUI

struct DashboardView: View {

    @StateObject private var societyEventtVM = SocietyEventViewModel()
    @StateObject private var authVM = AuthViewModel()
    
    @State var presentSideMenu = false
      @State var selectedSideMenuTab = 0
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
           
            VStack(spacing: .zero) {
                DashboardTopView(presentSideMenu: $presentSideMenu)
                ScrollView{
                    ZStack{
                        VStack{
                            Wave(yOffset: 0.75)
                                .fill(Color("blueColor"))
                                .frame(height: 80)
                                .padding(.zero)
                            VStack{
                                
                            }.frame(height: 100)
                        }
                        HStack(spacing: 60){
                            NavigationLink {
                                FinancialRecordView().navigationBarBackButtonHidden(true)
                            } label: {
                                DashboardMenuButton(title: "Payments", icon: "payment_vec", bgColor: Color("lightBlue"), iconSize: 80, isImage: true, onTap: {})
                            }
                            
                            NavigationLink {
                                ManageClassView().navigationBarBackButtonHidden(true)
                            } label: {
                                DashboardMenuButton(title: "Forum", icon: "class_talk", bgColor: .white, iconSize: 80, isImage: true, onTap: {})
                            }

                            
                            
                            NavigationLink {
                                OrganizationView().navigationBarBackButtonHidden(true)
                            } label: {
                                DashboardMenuButton(title: "Organizations", icon: "group_people", bgColor: Color("pinkColor"), iconSize: 80, isImage: true, onTap: {}).padding(.bottom)
                            }

                           
                        }
                    }
                   
                    
                    HStack(spacing: 90){
                        AppointmentChannelView(image: "watch_ico", title: "Methodist Channel")
                        AppointmentChannelView(image: "appointment_ico", title: "Book Appointment")
                    }.padding(.bottom, 60)
                    VStack(alignment: .leading, spacing: 10){
                        Text("Today's Bible Reading")
                            .font(.system(size: 16, weight: .medium, design: .default))
                        Text("WATCHNIGHT")
                            .font(.system(size: 16, weight: .bold, design: .default))
                            .foregroundColor(Color("blueColor"))
                        Text("John 3:16-21")
                            .font(.system(size: 16, weight: .medium, design: .default))
                        Text("Humankind has rejected the light")
                            .font(.system(size: 16, weight: .medium, design: .default))
                    }.padding(20)
                        .background(.white)
                        .shadow(radius: 10, x: -10.0, y: 10.0)
                        .cornerRadius(20)
                    VStack(alignment: .leading){
                        Text("Society Event")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 18, weight: .medium, design: .default))
                        
                        ScrollView(.horizontal,  showsIndicators: false){
                            HStack(spacing: 20){
                                if(!societyEventtVM.societyEvents.isEmpty)
                                {
                                    ForEach(0..<10)
                                    {_ in
                                        Image("knowing_god")
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 240, height: 240)
                                            .cornerRadius(20)
                                            
                                    }
                                }else{
                                    VStack(alignment: .center,spacing: 8){
                                       Text("🌼")
                                            .font(.system(size: 14, weight: .medium, design: .default)).padding(.top, 40)
                                        
                                        Text("There are no society yet")
                                             .font(.system(size: 14, weight: .medium, design: .default))
                                    }.frame(width: UIScreen.main.bounds.width)
                                }
                            }
                            
                        }
                    }.padding()
                    
                    VStack(alignment: .leading){
                        Text("Society Announcements")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 18, weight: .medium, design: .default))
                        
                        ScrollView(.horizontal,  showsIndicators: false){
                            VStack(alignment: .center,spacing: 8){
                               Text("🌼")
                                    .font(.system(size: 14, weight: .medium, design: .default)).padding(.top, 40)
                                
                                Text("There are no announcement yet")
                                     .font(.system(size: 14, weight: .medium, design: .default))
                            }.frame(width: UIScreen.main.bounds.width)
                            
                        }
                    }.padding()

                    Spacer()
                }.onAppear {
                    
                    UIScrollView.appearance().bounces = false
                    authVM.authenticateUser()
                    societyEventtVM.read()
                  }
                  .onDisappear {
                    UIScrollView.appearance().bounces = true
                  }

            }
            .offset(x: presentSideMenu ? UIScreen.main.bounds.width - 200 : 0)
            .scaleEffect(presentSideMenu ? 1.3 : 1)
            // Overlay to fade out the background when menu is open
                       Color.white.opacity(presentSideMenu ? 1 : 0)
                           .edgesIgnoringSafeArea(.all)
                           .animation(.easeInOut(duration: 0.3)).onTapGesture {
                               withAnimation(.easeInOut){
                                   presentSideMenu.toggle()
                               }
                           }.zIndex(presentSideMenu ? 2 : -1)
            SideMenuView(isShowingMenu: $presentSideMenu).animation(.easeInOut(duration: 0.3)).zIndex(presentSideMenu ? 3 : 1)
           
        }
        .alert(item: $authVM.alertItem) { item in
            Alert(title: Text(item.title), message: Text(item.message), dismissButton: Alert.Button.default(Text("Authenticate"), action: {
                
                dismiss()
            }))
        }.onAppear{
            
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
            DashboardView()   
    }
}



struct DashboardTopView: View {
    @Binding var presentSideMenu:Bool
    var body: some View {
        VStack(spacing: .zero){
            HStack{
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(.white).onTapGesture {
                        withAnimation {
                            presentSideMenu.toggle()
                        }
                    }
                Spacer()
                Text("Christ Ntsi")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(.white)
                Spacer()
                
                
            }.padding().background(Color("blueColor"))
            
           
        }
    }
}

struct AppointmentChannelView: View {
    let image: String
    let title: String
    var body: some View {
        VStack{
            Image(image)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 90, height: 90)
            Text(title)
                .font(.system(size: 14, weight: .bold, design: .default)).foregroundColor(Color("blueColor"))
        }
    }
}

