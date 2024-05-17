//
//  Organization.swift
//  MethodistMobile
//
//  Created by Q002 on 10/02/2024.
//

import SwiftUI

struct OrganizationView: View {
    @StateObject var organizationVM = OrganizationViewModel()
  
    var body: some View {
        ZStack{
            if(organizationVM.isLoading){
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            VStack {
                HStack{
                    Text("Organizations")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(.white)
                    Spacer()
                   
                }.padding().background(Color("blueColor"))
                
                ScrollView(showsIndicators: false){
                    VStack(spacing: 30){
                        if(!organizationVM.organizations.isEmpty){
                            ForEach(organizationVM.organizations){
                                org in
                                OrgView(organization: org)
                            }
                        }
                        
                    }
                 
                }.padding()
            }
        }.onAppear{
           
            organizationVM.read()
        }.alert(item: $organizationVM.alertItem) { item in
            Alert(title: Text(item.title), message: Text(item.message),  dismissButton: item.button)
        }
        
      
    }
    
 
}

struct Organization_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationView()
    }
}

struct OrgView: View {
    var organization: Organization
    var body: some View {
        HStack{
            Text(organization.organizationName)
                .font(.system(size: 16, weight: .bold, design: .default))
            Spacer()
            Button {
                OrganizationViewModel().requestToJoin(organzation: organization)
            } label: {
                Text("Request to Join")
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .frame(width: 140,height: 40)
                    .background(Color("blueColor"))
                    .cornerRadius(5)
                    .shadow(radius: 5)
            }
            
        }
    }
}
