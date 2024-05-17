//
//  RadioButton.swift
//  NativeMethodist
//
//  Created by Q002 on 06/02/2024.
//

import SwiftUI

struct RadioButton: View {
   var selectedOption:String
    var option: String
    var action: () -> ()
    var color: Color?
    var font:Font?
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: self.selectedOption == option ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(color ?? .black)
                Text(option)
                    .font(font ?? .system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(color ?? .black)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
