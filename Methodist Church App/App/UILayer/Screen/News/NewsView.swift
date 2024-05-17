//
//  NewsView.swift
//  MethodistMobile
//
//  Created by Q002 on 24/02/2024.
//

import SwiftUI

struct NewsView: View {
   
    
    @StateObject private var newsVM = NewsViewModel()
    var body: some View {
        ZStack{
            VStack {
                CustomAppbar(title: "News", centerTitle: true)
//                HTMLView(htmlContent: htmlContent)
//                    .padding()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                       
                        if(newsVM.newsList != nil && !newsVM.newsList!.data.isEmpty){
                            let result = newsVM.newsList!.data.sorted{$0.id > $1.id}
                            ForEach(result){ item in
                                ZStack(alignment: .top) {
                                    VStack{
                                        if(item.attributes.defaultImage.data
                                            .attributes.formats.small != nil){
                                            AsyncImage(url: URL(string:  item.attributes.defaultImage.data
                                                .attributes.formats.small!.url
                                      )!) { image in
                                                       image
                                                           .renderingMode(.original)
                                                           .resizable()
                                                           .aspectRatio(contentMode: .fill)
                                                   } placeholder: {
                                                       Image(systemName: "photo.fill") .renderingMode(.original)
                                                           .resizable()
                                                           .aspectRatio(contentMode: .fit)
                                                   }.frame(width: 240, height: 240)
                                        }
                                      
                                            
                                        HStack{
                                            Text(item.attributes.title)
                                                 .font(.system(size:18, weight: .bold, design: .default))
                                            Spacer()

                                        }.padding(.vertical)
//                                        HTMLView(htmlContent: item.attributes.content)
                                        ExpandableText(item.attributes.content.removeHTMLTagsAndReplaceParagraph(), lineLimit: 5).padding(.horizontal, 2)
                                    }
                                   
                                }.padding(10).background(.white).cornerRadius(10).shadow(radius: 1.5, x: 1, y:1)
                            }
                        }
                       
                        else{
                          
                                ForEach(0..<6){ _ in
                                    NewsShimmerEffect() 
                                }
                               
                           
                        }
                       
                    }
                }.padding(10)
            }
        }.onAppear{
            newsVM.read()
           
        }
    }
    
    @ViewBuilder
     private func NewsShimmerEffect() -> some View{
         VStack{
            
             Shimmer().cornerRadius(5).frame(height: 150)
             Shimmer().cornerRadius(5).frame(height: 20)
             Shimmer().cornerRadius(5).frame(height: 20)
         }
     }
    
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}



struct HTMLView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.backgroundColor = .yellow // Add background color for debugging
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        print("Updating UITextView")
        let modifiedHTMLContent = htmlContent
            .replacingOccurrences(of: "<p>", with: "<br>")
            .replacingOccurrences(of: "</p>", with: "")
        print("Modified HTML Content:", modifiedHTMLContent)
        let attributedString = try? NSAttributedString(
            data: Data(modifiedHTMLContent.utf8),
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
        print("Attributed String:", attributedString)
        uiView.attributedText = attributedString
    }
}





struct TextView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        let attributedString = try? NSAttributedString(
            data: Data(htmlContent.utf8),
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
        uiView.attributedText = attributedString
    }
}
