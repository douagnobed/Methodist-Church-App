//
//  FinancialRecordView.swift
//  NativeMethodist
//
//  Created by Q002 on 08/02/2024.
//

import SwiftUI

struct FinancialRecordView: View {
    var body: some View {
        ZStack{
            
            VStack {
                HStack{
                    Text("Financial Record")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(.white)
                    Spacer()
                    
                }.padding().background(Color("blueColor"))
              
                ScrollView(showsIndicators: false){
                    VStack(spacing: 28){
                        ForEach(0..<18){ tithe in
                            TitheCard()
                            
                        }
                    }

                }
                Spacer()
                
             
            }
        }
       
    }
}

struct FinancialRecordView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialRecordView()
    }
}

struct TitheCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            HStack{
                Text("TITHE")
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(Color("blueColor"))
                Spacer()
                Text("GH₵ 1")
                    .foregroundColor(Color("orangeColor"))
            }
            Divider()
            Text("Month: Jun")
                .font(.system(size: 14, weight: .medium, design: .default))
            Text("via Mobile Money")
                .font(.system(size: 14, weight: .medium, design: .default))
            HStack{
                Spacer()
                Text("9th June 2022")
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width-20)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
