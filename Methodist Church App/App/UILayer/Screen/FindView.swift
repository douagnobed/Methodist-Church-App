//
//  FindView.swift
//  NativeMethodist
//
//  Created by Q002 on 04/02/2024.
//

import SwiftUI
import Lottie

struct FindView: View {
    @State private var isContactPresented = false
    @State private var isJournalPresented = false
    @State private var isMethodismPresented = false
    @StateObject var locationVM = LocationViewModel()
    var body: some View {
        NavigationStack {
            ZStack{
                
                VStack {
                    CustomAppbar(title: "Find")
                    
                    VStack{
                        
                        NavigationLink {
                            NearbyChurchView()
                        } label: {
                            
                            HStack {
                                Text("🔍 find church near you")
                                    .font(.system(size: 18, weight: .medium, design: .default))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.black)
                                    .frame(width: 20, height: 20)
                            }
                            .padding()
                            .cornerRadius(20)
                            .border(Color("blueColor"))

                           
                        }

                    }.padding().onTapGesture {
                       
                        let latitude = locationVM.region.center.latitude
                        print(latitude)
                    }
                    
                    
                    Spacer()
                    LottieView(filename: "area_map")
                                    .frame(width: 300, height: 300)
                    Spacer()
                    
                    HStack(spacing: 50){
                        NavbarButton(title: "Contact", icon: "book.fill", bgColor: Color("pinkColor"), onTap: {
                            withAnimation {
                                self.isContactPresented.toggle()
                            }
                        } ).fullScreenCover(isPresented: $isContactPresented){
                            ContactView()
                        }
                        NavbarButton(title: "Journal",icon: "text.badge.plus", bgColor: Color("orangeColor"), onTap: {
                            withAnimation {
                                self.isJournalPresented.toggle()
                            }
                        }).fullScreenCover(isPresented: $isJournalPresented){
                            NoteListView()
                        }
                        NavbarButton(title: "Methodism",icon: "meth_logo", bgColor: Color("orangeColor"), isImage: true, onTap: {
                            withAnimation {
                                self.isMethodismPresented.toggle()
                            }

                        }).fullScreenCover(isPresented: $isMethodismPresented){
                            MethodismView()
                        }
                        NavbarButton(title: "YDM", icon: "ydm", bgColor: Color("blueColor"), iconColor: .white, isImage: true, onTap: {
                            
                        })
                    }.padding(.horizontal)
                }
            }
        }
        
    }
    
}

struct FindView_Previews: PreviewProvider {
    static var previews: some View {
        FindView()
    }
}


struct LottieView: UIViewRepresentable {
    var filename: String
    var loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        let animationView = LottieAnimationView()
        let animation = LottieAnimation.named(filename)
        animationView.animation = animation
        animationView.loopMode = loopMode
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Update code if necessary
    }
}
