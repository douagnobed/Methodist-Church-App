//
//  Shimmer.swift
//  NativeMethodist
//
//  Created by Q002 on 07/02/2024.
//

import SwiftUI

struct EventPreloader:View{
    var body: some View{
        ZStack{
           
            ShimmerEffect()
        }
        .frame(width: 240, height: 240)

    }
    
    @ViewBuilder
     private func ShimmerEffect() -> some View{
         VStack(spacing: 20){
             Shimmer().cornerRadius(5).frame(width: 240, height: 240)
             Shimmer().cornerRadius(20).frame(width: 240, height: 30)
         }
     }
}

struct ShimmerView: View {
    
    var body: some View {
        VStack{
            ShimmerEffect()
            ShimmerEffect()
            ShimmerEffect()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.black)
    }
    
    @ViewBuilder
     private func ShimmerEffect() -> some View{
         VStack{
             HStack{
                 Shimmer().cornerRadius(20).frame(width: 60, height: 60)
                 VStack{
                     Shimmer().cornerRadius(5).frame(height: 20)
                     Shimmer().cornerRadius(5).frame(height: 20)
                 }
             }
             Shimmer().cornerRadius(5).frame(height: 150)
         }
     }
}



struct Shimmer: View {
    @State private var startPoint: UnitPoint = .init(x: -1.8, y:-1.2)
    @State private var endPoint: UnitPoint = .init(x: 0, y: -0.2)
   private var gradientColors = [
    Color.gray.opacity(0.2),
    Color.white.opacity(0.2),
    Color.gray.opacity(0.2)
   ]
    var body: some View {
        LinearGradient(colors: gradientColors, startPoint: startPoint, endPoint: endPoint)
            .onAppear{
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: false)){
                    startPoint = .init(x: 1, y: 1)
                    endPoint = .init(x: 2.2, y: 2.2)
                }
            }

    }
}

struct Shimmer_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerView()
    }
}
