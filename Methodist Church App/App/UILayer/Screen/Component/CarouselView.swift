//
//  CarouselView.swift
//  MethodistMobile
//
//  Created by Q002 on 18/02/2024.
//

import SwiftUI

struct CarouselView: View {
    var body: some View {
        CarouselSlider(itemCount: 12, child: AnyView(Text("Hello wold")))
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}



struct CarouselSlider: View {
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    let itemCount:Int
    let child: AnyView
    let autoSlide:Bool = true
    
    // Step 3: Manage Selected Image Index
    @State private var selectedImageIndex: Int = 0

    var body: some View {
        ZStack {
            // Step 5: Create TabView for Carousel
            TabView(selection: $selectedImageIndex) {
                // Step 6: Iterate Through Images
                ForEach(0..<itemCount, id: \.self) { index in
                   
                        child
                }
            }// Step 10: Set Carousel Height
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Step 11: Customize TabView Style
            

            // Step 12: Navigation Dots
            HStack {
                ForEach(0..<itemCount, id: \.self) { index in
                    // Step 13: Create Navigation Dots
                    Capsule()
                        .fill(Color.white.opacity(selectedImageIndex == index ? 1 : 0.33))
                        .frame(width: 35, height: 8)
                        .onTapGesture {
                            // Step 14: Handle Navigation Dot Taps
                            selectedImageIndex = index
                        }
                }
                .offset(y: 130) // Step 15: Adjust Dots Position
            }
        }
        .onReceive(timer) { _ in
            // Step 16: Auto-Scrolling Logic
            if(autoSlide)
            {
                withAnimation(.default) {
                    selectedImageIndex = (selectedImageIndex + 1) % itemCount
                }
            }
        }
    }
}

