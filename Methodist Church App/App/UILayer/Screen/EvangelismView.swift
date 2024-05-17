//
//  EvangelismView.swift
//  Methodist Church App
//
//  Created by Q002 on 12/03/2024.
//

import SwiftUI

struct EvangelismView: View {
    var evangelism: Evangelism
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.init()){
                    TabView{
                        ForEach(evangelism.content!) { evg in
                            VStack() {
                                ZStack{
                                    Image(evangelism.imageUrl)
                                        .resizable()
                                        .renderingMode(.original)
                                    Color.black.opacity(0.4)
                                    Text(evangelism.title)
                                        .multilineTextAlignment(.leading)
                                        .font(.system(size: 26, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                        .padding(10)
                                    
                                }.frame(height: 300)
                                ScrollView {
                                    VStack{
                                        if(evg.subContent != nil || !evg.subContent!.isEmpty)
                                        {
                                            ForEach(evg.subContent!) { subContent in
                                                VStack(alignment:.leading){
                                                    Text(subContent.title) .multilineTextAlignment(.leading).foregroundColor(Color("blueColor"))
                                                    Divider()
                                                    Text(subContent.content)
                                                }
                                                .background(.white)
                                                    .cornerRadius(10)
                                                    .padding()
                                            }
                                        }
                                    }
                                }
                                Spacer()
                                HStack(spacing: 20){
                                    ForEach(0..<5) { cont in
                                        Capsule()
                                            .fill(Color("blueColor"))
                                            .frame(width: 7, height: 7)
                                    }
                                }.ignoresSafeArea()
                            }
                            
                        }
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        
                }.ignoresSafeArea()
            }.background(Color("bgColor"))
        }
    }
}

struct EvangelismView_Previews: PreviewProvider {
    static var previews: some View {
        EvangelismView(evangelism: evangelisms[0])
    }
}
