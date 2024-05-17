//
//  AppbarView.swift
//  MethodistMobile
//
//  Created by Q002 on 13/02/2024.
//

import SwiftUI

struct AppbarView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var backButton : some View {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack(spacing: 0) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                    Text("Cancel")
                }
            }
        }
var body: some View {
         
        NavigationStack {
             ScrollView {
               Text("Hi there!")
                 .padding()
             }
             .navigationBarTitle("", displayMode: .inline)
             
             .toolbarTitleMenu {
               Button("Damn", action: {})
             }
             .navigationBarItems(
               leading: NavigationLink {
                 Text("Profile")
                   .navigationBarBackground()
               } label: {
                 Image(systemName: "person.crop.circle")
               },
               trailing:
                   Menu {
                     NavigationLink {
                       Text("New post")
                         .navigationBarBackground()
                     } label: {
                       Image(systemName: "plus.circle")
                       Text("Create new post")
                     }
                     NavigationLink {
                         DashboardView()
                            // .navigationBarBackButtonHidden(true)
                             .navigationBarTitle("Christ Ntsi")
                        
                     } label: {
                       Image(systemName: "link.circle")
                       Text("Upload picture")
                     }
                   } label: {
                     Image(systemName: "plus.circle")
                   }
             )
             .navigationBarBackground()
           }
    }
}

struct AppbarView_Previews: PreviewProvider {
    static var previews: some View {
        AppbarView()
    }
}


extension View {
  func navigationBarBackground(_ background: Color = Color("blueColor")) -> some View {
    return self
      .modifier(ColoredNavigationBar(background: background))
  }
}

struct ColoredNavigationBar: ViewModifier {
  var background: Color
    
  
  func body(content: Content) -> some View {
    content
      .toolbarBackground(
        background,
        for: .navigationBar
      )
      .toolbarBackground(.visible, for: .navigationBar)
  }
}
