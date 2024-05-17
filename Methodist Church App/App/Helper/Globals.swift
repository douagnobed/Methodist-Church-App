//
//  Globals.swift
//  NativeMethodist
//
//  Created by Q002 on 06/02/2024.
//

import SwiftUI

struct Globals {
    static func lineSplitter(text: String) -> [String] {
        print(text.components(separatedBy: "\n").count);
        return text.components(separatedBy: "\r")
    }
}



extension String {
    func removeHTMLTagsAndReplaceParagraph() -> String {
        // Replace "</p>" with "\n\n"
        var stringWithoutParagraphs = self.replacingOccurrences(of: "</p>", with: "\n\n")
        
        // Remove HTML tags
        let regex = try! NSRegularExpression(pattern: "<[^>]+>")
        let range = NSRange(location: 0, length: stringWithoutParagraphs.utf16.count)
        let stringWithoutHTML = regex.stringByReplacingMatches(in: stringWithoutParagraphs, options: [], range: range, withTemplate: "")

        return stringWithoutHTML
    }
    
    func removeHTMLTags() -> String {
            // Remove HTML tags
            let regex = try! NSRegularExpression(pattern: "<[^>]+>")
            let range = NSRange(location: 0, length: self.utf16.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
        }
}


struct VerticalDivider: View {
    var color: Color = .gray
    var width: CGFloat = 1

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width)
            .edgesIgnoringSafeArea(.vertical)
    }
}

