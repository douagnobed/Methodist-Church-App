//
//  HymnalPanelView.swift
//  NativeMethodist
//
//  Created by Q002 on 06/02/2024.
//

import SwiftUI




struct HymnalPanelView: View {
    @StateObject private var hymnalVM = HymnalViewModel()
    var hymn:EnglishHymnal
    var body: some View {
        ZStack{
            Image("hymn_bg")
                .renderingMode(.original)
                
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            Color.black.opacity(0.4)
            VStack(spacing: .zero) {
                ZStack{
                    ScrollView(){
                        VStack{
                            HStack(alignment: .top){                                VStack(spacing: 20){
                                    ForEach(Globals.lineSplitter(text: hymn.lyrics ?? ""), id: \.self){ chapter in
                                        Text("\(chapter)")
                                            .font(.system(size: 30, weight: .regular, design: .default))
                                            .foregroundColor(.white)
                                    }
                                }.padding(12)
                                
                            }
                        }.padding(13)
                        VStack{
                           
                        }
                    }
                }
            }
        }
        .navigationBarBackground(Color("blueColor"))
            .navigationBarItems(leading: Text("💖").foregroundColor(.white), trailing: Button(action: {
                hymnalVM.playHymns(hymnId: Int(hymn.id))
            }, label: {
                Image(systemName: "play.circle").foregroundColor(.white)
            })).alert(item: $hymnalVM.alertItem) { item in
                Alert(title: Text(item.title), message: Text(item.message),  dismissButton: item.button)
            }
      
    }

}

func dHymnal()-> EnglishHymnal{
    var engHymn = EnglishHymnal()
  
        engHymn.id =  1
        engHymn.type =  "mhb"
        engHymn.title = "mhb 1"
        engHymn.lyrics =
            "O FOR a thousand tongues to sing My great Redeemer’s praise , The glories of my God and King , The triumphs of His grace!!.\r My gracious Master and my God , Assist me to proclaim , To spread through all the earth abroad The honours of Thy name. \rJesus! The name that charms our fears , That bids our sorrows cease; ’Tis music in the sinner’s ears , 'Tis life , and health , and peace. \rHe speaks , and , listening to His voice , New life the dead receive , The mournful , broken hearts rejoice , The humble poor believe. \rHe breaks the power of cancelled sin , He sets the prisoner free; His blood can make the foulest clean , His blood availed for me. \rSee all your sins on Jesus laid: The Lamb of God was slain , His soul was once an offering made For every soul of man."
       return engHymn
}

struct HymnalPanelView_Previews: PreviewProvider {
    static var previews: some View {
        HymnalPanelView(hymn: dHymnal())
    }
}
