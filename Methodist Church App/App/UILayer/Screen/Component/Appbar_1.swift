//
//  Appbar_1.swift
//  MethodistMobile
//
//  Created by Q002 on 17/02/2024.
//

import SwiftUI

struct AppBar<LeadingContent: View, TrailingContent: View>: View {
    let title: String
    let leadingContent: LeadingContent
    let trailingContent: TrailingContent
    let backgroundColor: Color
    
    init(title: String, @ViewBuilder leadingContent: () -> LeadingContent, @ViewBuilder trailingContent: () -> TrailingContent, backgroundColor: Color = .blue) {
        self.title = title
        self.leadingContent = leadingContent()
        self.trailingContent = trailingContent()
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        HStack {
            leadingContent
                .padding()
            Spacer()
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
            Spacer()
            trailingContent
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
    }
}

struct ContentView: View {
    var body: some View {
        AppBar(title: "Title",
               leadingContent: {
                   Button(action: {
                       // Add leading button action
                   }) {
                       Image(systemName: "arrow.left")
                           .foregroundColor(.white)
                   }
               },
               trailingContent: {
                   Button(action: {
                       // Add trailing button action
                   }) {
                       Image(systemName: "gear")
                           .foregroundColor(.white)
                   }
               })
            .edgesIgnoringSafeArea(.top)
    }
}



struct Appbar_1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
