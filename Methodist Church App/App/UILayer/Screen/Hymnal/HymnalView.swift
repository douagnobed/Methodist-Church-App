//
//  HymnalView.swift
//  NativeMethodist
//
//  Created by Q002 on 05/02/2024.
//

import SwiftUI
import CoreData


struct HymnalView: View {
     var englishHymnals: [EnglishHymnal] = []
   
   
    let englishOptions = ["MHB", "Creed", "Cant.", "Auth"]
    let fantseOptions = ["CAN", "Gyedzi", "Cant."]
    
    func filterEvents(events: [Hymnal], searchText: String) -> [Hymnal] {
        guard !searchText.isEmpty else { return events }
        
        return events.filter { $0.type.lowercased().contains(searchText.lowercased()) }
    }
       
       var filteredEvents: [Hymnal] {
           filterEvents(events: [], searchText: searchTerm)
       }
    
    @State private var selected = 1
    @State private var selectedOption: String? = "MHB"
    @State private var isSwitchOn = false
    @State private var searchTerm = ""
    @StateObject private var hymnalVM = HymnalViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext
    


    var body: some View {
        NavigationStack{
            GeometryReader { _ in
                ZStack{
                    if(hymnalVM.isLoading){
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    }
                    Image("hymn_bg")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Color(.black).opacity(0.55)
                    VStack {
                            VStack{
                                HStack(alignment: .center,spacing: 20) {
                                    ForEach(isSwitchOn  ? fantseOptions : englishOptions, id: \.self) { option in
                                        RadioButton(selectedOption: selectedOption ?? "", option: option, action: {
                                            self.selectedOption = option
                                        }, color: .white, font: .system(size: 16, weight: .bold, design: .default))
                                          }
                                }
                                .padding(.trailing)
                                        if(isSwitchOn){
                                            if(selectedOption!.lowercased() == "CAN".lowercased()){
                                                FantseHymnalListView()
                                            }
                                            else if(selectedOption!.lowercased() == "Gyedzi".lowercased()){
                                                FantseCreedListView()
                                            }else if(selectedOption!.lowercased() == "Cant.".lowercased()){
                                                FantseCantView()
                                            }
                                            
                                            
                                         
                                        }else{
                                            if(selectedOption!.lowercased() == "MHB".lowercased()){
                                                HymnalListView()
                                            }else if(selectedOption!.lowercased() == "Creed".lowercased()){
                                                CreedListView()
                                            }
                                            else if(selectedOption!.lowercased() == "Cant.".lowercased()){
                                                CantListView()
                                            }
                                            else if(selectedOption!.lowercased() == "Auth".lowercased()){
                                                AuthHymnalListView()
                                            }

                                        }
                                        
                                
                                    
                            }.padding(.top)
                      
                            
                        }
                }
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .navigationBarBackground(Color("blueColor"))
                    .navigationBarItems(leading: Text("💖 Favorite").foregroundColor(.white), trailing: Toggle(isOn: $isSwitchOn, label: {
                    }).onChange(of: isSwitchOn, perform: { newValue in
                        if(newValue){
                            selectedOption = "CAN"
                        }else{
                            selectedOption = "MHB"
                        }
                    })
                    .toggleStyle(Material2ToggleStyle()))
                       
            }
        }
        }
}

struct HymnalView_Previews: PreviewProvider {
    static var previews: some View {
        HymnalView()
    }
}



struct SearchBar: View {
    @Binding var searchText: String
    @FocusState var hasFocus:Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $searchText)
                .padding(.vertical, 10).background(.white.opacity(0.4)).cornerRadius(10).padding(.horizontal)
            HStack {
                Image(systemName: "magnifyingglass").padding(.leading)
                Text("Search with lyrics or number...").foregroundColor(.white)
            }.padding(.leading)
        }
         
    }
}


struct Material2ToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            withAnimation {
                configuration.isOn.toggle()
            }
        }) {
            HStack {
                configuration.label
                Spacer()
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 50, height: 30)
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                    .overlay(
                        Circle()
                            .frame(width: 26, height: 26)
                            .foregroundColor(.white)
                            .padding(configuration.isOn ? .trailing : .leading, 4)
                            .offset(x: configuration.isOn ? 12 : -12)
                    )
                    .cornerRadius(15)
            }
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
}





struct HymnalListView: View {
        @State private var searchTerm = ""
    @StateObject var  hymnalVM = HymnalViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: EnglishHymnal.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \EnglishHymnal.id, ascending: true)],
        animation: .default)
    private var items: FetchedResults<EnglishHymnal>

    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchTerm).padding(.horizontal).padding(.horizontal)
            List {
                ForEach(items) { item in
                    NavigationLink {
                        HymnalPanelView(hymn: item)
                    } label: {
                        HymnalFromDBListTile(hymnal: item)
                    }
                }
                
            }
//            ScrollView(showsIndicators: false) {
//                VStack(alignment: .leading, spacing: 20){
//                    ForEach(0..<hymnalVM.englishHymnals.count){ hymn in
//                        NavigationLink {
//                            HymnalPanelView(hymn: hymnalVM.englishHymnals[hymn])
//                        } label: {
//                            HymnalFromDBListTile(hymnal: hymnalVM.englishHymnals[hymn])
//                        }
//
//
//
//                    }
//                }.padding()
//            }.padding()
        }
    }
}

struct CantListView: View {
        @State private var searchTerm = ""
    var body: some View {
        VStack {
            SearchBar(searchText: $searchTerm).padding(.horizontal).padding(.horizontal)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20){
                    ForEach(0..<cantHymnal.count){ hymn in
                        HymnalListTile(hymnal: cantHymnal[hymn])
                        
                    }
                }.padding()
            }.padding()
        }
    }
}


struct FantseCantView: View {
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20){
                    ForEach(0..<fantseCanticles.count){ hymn in
                        HymnalListTile(hymnal: fantseCanticles[hymn])
                        
                    }
                }.padding()
            }.padding()
        }
    }
}


struct FantseCreedListView: View {
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20){
                    ForEach(0..<fantseCreed.count){ hymn in
                        HymnalListTile(hymnal: fantseCreed[hymn])
                        
                    }
                }.padding()
            }.padding()
        }
    }
}


struct CreedListView: View {
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20){
                    ForEach(0..<creedHymnal.count){ hymn in
                        HymnalListTile(hymnal: creedHymnal[hymn])
                        
                    }
                }.padding()
            }.padding()
        }
    }
}

struct AuthHymnalListView: View {
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0){
                    ForEach(0..<anthHymns.count){ hymn in
                        ExpansionTile<Text?>(
                            title: anthHymns[hymn].title,
                            textColor: .white,
                            trailingIcon: "chevron.right",
                            trailingIconColor: .white,
                            backgroundColor: Color.clear,
                            trailingIconOnExpanded: nil,
                            borderWidth: 3,
                            borderColor: .white
                        ).padding()
                        
                    }
                }.padding()
            }.padding()
        }
    }
}


struct FantseHymnalListView: View {
        @State private var searchTerm = ""
    @StateObject var  hymnalVM = HymnalViewModel()
    var body: some View {
        VStack {
            SearchBar(searchText: $searchTerm).padding(.horizontal).padding(.horizontal)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20){
                    ForEach(0..<hymnalVM.fantseHymnals.count){ hymn in
                        HymnalListTile(hymnal: hymnalVM.fantseHymnals[hymn])
                        
                    }
                }.padding()
            }.padding()
        }
    }
}

struct HymnalListTile: View {
    var hymnal:Hymnal
    var body: some View {
        HStack(alignment: .center, spacing: 10){
            Image("meth_logo")
                .resizable()
                .renderingMode(.original)
                .clipShape(Circle())
                .frame(width: 60, height: 60)
            VStack(alignment: .leading, spacing: 5){
                Text(hymnal.title ?? "").textCase(.uppercase)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Text(hymnal.lyrics ?? "")
                
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.white)
                
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }.padding(.horizontal)
    }
}


struct HymnalFromDBListTile: View {
    var hymnal:EnglishHymnal
    var body: some View {
        HStack(alignment: .center, spacing: 10){
            Image("meth_logo")
                .resizable()
                .renderingMode(.original)
                .clipShape(Circle())
                .frame(width: 60, height: 60)
            VStack(alignment: .leading, spacing: 5){
                Text(hymnal.title ?? "").textCase(.uppercase)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Text(hymnal.lyrics ?? "")
                
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.white)
                
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }.padding(.horizontal)
    }
}
