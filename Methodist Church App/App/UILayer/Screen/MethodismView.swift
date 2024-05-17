//
//  Methodism.swift
//  NativeMethodist
//
//  Created by Q002 on 04/02/2024.
//

import SwiftUI

struct MethodismView: View {
    var body: some View {
        ZStack{
            VStack {
                CustomAppbar(title: "Methodist Identity")

                
                ScrollView(){
                    VStack{
                        HStack(alignment: .top){
                            Image("meth_logo")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                            VStack(spacing: 10){
                                VisionMissionBlock(title: "VISION", description: "To be a vibrant, sprit-filled and spirit-led church for tthe holistic transformation of society")
                                VisionMissionBlock(title: "MISSION", description: "To equip the church foor ministry to the world through the demonstration fo christian faith and love")

                            }
                            
                        }
                    }.padding(.bottom, 20)
                    VStack{
                        VStack(alignment: .leading){
                            Text("Meaning of the Methodist Emblem Logo")
                                .font(.system(size: 16, weight: .bold, design: .default))
                                .textCase(.uppercase)
                                .foregroundColor(Color("blueColor"))
                            Divider()
                            Text("The flag is being raised to remind us of the fact that even though we share in the ecumenical body, we are first and foremoonst, Christians of the Methodiist tradiition. We are proud to have come to faith in Jesus Christ by the gospel preached, taught and practiiced by the power of God to spread scrptual holiness throughout the land. It is therefore important that every Methodist within dioocese, Circuit and society iin the Connexion owns and raiises it at the offices and chapels.\n\n\tThe Gold background symbolizes the richness of our heritage in the gloriooous hope of Jesus Chriist. Iit also brings to mind that the Methodiist heriitage handed over to us by our forebears in pure, dependable and worthwhile, and that a striict adherence to iiti would enable the Methodisit seeking faith to cultivate a personal and living faiith which leads too Salvation in Jesus Christ.\nAgain iit reminds us that as we hoist the flag, embossed with the Ghana methodist emblem, we antiiicipate the day we would be welcomed to take our place in the city of God, the kingdom of God where Chriist the Lord reigns supreme.")
                                .font(.system(size: 16, weight: .medium, design: .default))
                            
                        }.padding(.horizontal, 8)
                    }
                }
            }
        }
      
    }
}

struct Methodism_Previews: PreviewProvider {
    static var previews: some View {
        MethodismView()
    }
}

struct VisionMissionBlock: View {
    let title: String
    let description: String
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .default))
                .foregroundColor(Color("blueColor"))
            Divider()
            Text(description)
                .textCase(.uppercase)
                .font(.system(size: 16, weight: .medium, design: .default))
            
        }
    }
}
