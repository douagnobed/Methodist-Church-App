//
//  NearbyChurch.swift
//  MethodistMobile
//
//  Created by Q002 on 01/03/2024.
//

import SwiftUI

extension View {
    func navigationBarTitleColor(_ color: Color) -> some View {
        return self.modifier(NavigationBarTitleColorModifier(color: color))
    }
}


struct NavigationBarTitleColorModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .onAppear() {
                let coloredAppearance = UINavigationBarAppearance()
                coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(color)]
                coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(color)]
                UINavigationBar.appearance().standardAppearance = coloredAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            }
    }
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

struct NearbyChurchView: View {
    @StateObject private var churchVM = ChurchViewModel()
    @StateObject private var locationVM =  LocationViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                
                if(churchVM.isLoading){
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                
            
                ScrollView{
                    VStack(spacing: 30){
                        if(churchVM.churches != nil && !churchVM.churches!.isEmpty){
                            ForEach(churchVM.churches!){
                                church in
                                NearbyChurchCard(church: church).onTapGesture {
                                    if(church.latitude != nil && church.longitude != nil)
                                    {
                                        locationVM.navigateOnGoogleMap(sourceLatitude: locationVM.region.center.latitude, sourceLongitude: locationVM.region.center.longitude, destinationLatitude: church.latitude!.toDouble()! , destinationLongitude: church.longitude!.toDouble()!)
                                    }
                                }
                            }
                        }

                    }.padding()

                }
                
            }.onAppear{
                churchVM.all()
            }.alert(item: $churchVM.alertItem) { item in
                Alert(title: Text(item.title), message: Text(item.message),  dismissButton: item.button)
            }
            .navigationBarTitleColor(.red)
            .navigationBarBackground(Color("blueColor"))
            
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("Methodist Churches Near me", displayMode: .inline)
                
               

        }
    }
}

struct NearbyChurchView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyChurchView()
    }
}

struct NearbyChurchCard: View {
    var church:Church
    var body: some View {
        HStack{
            Image(systemName: "building.columns.fill")
            VStack{
                Text(church.societyName)
                Text(church.town)
                Text(church.region)
                Text("miles away")
            }
            Spacer()
        }
        .frame(width: .infinity)
        .padding()
        .background()
        .shadow(radius: 1)
    }
}
