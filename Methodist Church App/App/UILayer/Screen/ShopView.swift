//
//  ShopView.swift
//  NativeMethodist
//
//  Created by Q002 on 05/02/2024.
//

import SwiftUI

struct ShopView: View {
    @State private var isShowingWebView: Bool = false
    @State private var isShowingAlert: Bool = false
    var body: some View {
        
        NavigationView{
            ZStack{
                VStack {
                    CustomAppbar(title: "Shop")
                    
                    ScrollView(){
                        VStack(alignment: .leading, spacing: 20){
                            ShopBook(title: "WBL", image: "wbl_half_123", onTap: {
                                isShowingAlert = true
                            }).alert("Alert", isPresented: $isShowingAlert) {
                               
                            }
                            ShopBook(title: "Sentinel", image: "sentinel", onTap: {
                                UIApplication.shared.open(URL(string: "https://mcrp.qliqintegrations.com/support-project")!
                                )

                            })
                            NavigationLink {
                                PaymentView()
                            } label: {
                                ShopBook(title: "Lent", image: "lent_2023", onTap: {
                                    isShowingWebView.toggle()
                                })
                            }

                          
                            
                        }.frame(maxWidth: .infinity, alignment: .leading)
                       
                        
                     
                    }.padding()
                }
            }
          
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}

struct ShopBook: View {
    let title: String
    let image: String
    let onTap: ()->()
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.system(size: 18, weight: .medium, design: .default))
            VStack{
                Image(image)
                    .resizable()
                    .renderingMode(.original)
                Text("WBL first half 2023")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14, weight: .medium, design: .default)).padding(10)
            }.frame(width: 160, height: 200)
                .background(.white)
                .cornerRadius(10)
            .shadow(radius: 5, x: 0, y:5)        }.padding(.bottom, 20).onTapGesture {
                self.onTap()
            }
    }
}



