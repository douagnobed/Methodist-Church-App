//
//  ExpandableTextView.swift
//  MethodistMobile
//
//  Created by Q002 on 11/02/2024.
//

import SwiftUI

struct ExpandableTextView: View {
    var body: some View {
        ScrollView{
            HStack(alignment: .top) {
                Color.red.frame(width: 5).shadow(radius: 20)
            
                VStack{
                    HStack{
                        Text("Pamuchaaha final meeting")
                             .font(.system(size:18, weight: .bold, design: .default))
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                    }.padding(.vertical)
                    ExpandableText("If you want to be refreshed, do same to others.\nProverbs 11:25(niv)\n\nRomans 16:15\nIf you want to be refreshed, do same to others.\nProverbs 11:25(niv)\n\nRomans 16:15", lineLimit: 5).padding(.horizontal, 2)
                }
               
            }.padding(10).background(.white).cornerRadius(10).shadow(radius: 1.5, x: 1, y:1)
        }
    }
}

struct ExpandableTextView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableTextView()
    }
}


struct ExpandableText: View {
    
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    @State private var shrinkText: String
    
    private var text: String
    let font: UIFont
    let lineLimit: Int
    
    init(_ text: String, lineLimit: Int, font: UIFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)) {
        self.text = text
        _shrinkText =  State(wrappedValue: text)
        self.lineLimit = lineLimit
        self.font = font
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Group {
                Text(self.expanded ? text : shrinkText) + Text(moreLessText)
                    .bold()
                    .foregroundColor(.black)
            }
            .animation(.easeInOut(duration: 1.0), value: false)
            .lineLimit(expanded ? nil : lineLimit)
            .background(
                // Render the limited text and measure its size
                Text(text)
                    .lineLimit(lineLimit)
                    .background(GeometryReader { visibleTextGeometry in
                        Color.clear.onAppear() {
                            let size = CGSize(width: visibleTextGeometry.size.width, height: .greatestFiniteMagnitude)
                            let attributes:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font: font]

                            ///Binary search until mid == low && mid == high
                            var low  = 0
                            var heigh = shrinkText.count
                            var mid = heigh ///start from top so that if text contain we does not need to loop
                            ///
                            while ((heigh - low) > 1) {
                                let attributedText = NSAttributedString(string: shrinkText + moreLessText, attributes: attributes)
                                let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                                if boundingRect.size.height > visibleTextGeometry.size.height {
                                    truncated = true
                                    heigh = mid
                                    mid = (heigh + low)/2
                                    
                                } else {
                                    if mid == text.count {
                                        break
                                    } else {
                                        low = mid
                                        mid = (low + heigh)/2
                                    }
                                }
                                shrinkText = String(text.prefix(mid))
                            }
                            
                            if truncated {
                                shrinkText = String(shrinkText.prefix(shrinkText.count - 2))  //-2 extra as highlighted text is bold
                            }
                        }
                    })
                    .hidden() // Hide the background
            )
            .font(Font(font)) ///set default font
            ///
            if truncated {
                Button(action: {
                    withAnimation{
                        expanded.toggle()
                    }
                }, label: {
                    HStack { //taking tap on only last line, As it is not possible to get 'see more' location
                        Spacer()
                        Text("")
                    }.opacity(0)
                })
            }
        }
    }
    
    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? " read less" : " ... read more"
        }
    }
    
}



