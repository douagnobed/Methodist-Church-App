//
//  ContentView.swift
//  NativeMethodist
//
//  Created by Q002 on 03/02/2024.
//

import SwiftUI


extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}



struct HomeView: View {
    @State private var offset: CGFloat = .zero
    @State private var eventImagePosition = CGSize.zero
    @State private var isLoginDialogPresented = false
    @State private var isFindPresented = false
    @State private var isHymnalPresented = false
    @State private var isLiturgyPresented = false
    @State private var isShopPresented = false
    @State private var eventImage: Event? = nil
    @State private var newsList: News? = nil
    @State private var selectedEvent: Datum? = nil
    @State private var isRefreshing = false
    @Namespace var  eventNamespace
    @StateObject private var authVM = AuthViewModel()
    @StateObject private var newsVM = NewsViewModel()
    @StateObject private var hymnalVM = HymnalViewModel()
    
    
    
   
    
    
    var body: some View {
        NavigationStack(path: $authVM.path){
            ZStack{
                
                //Image Viewer
                ZStack {
                    Color.black.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea().opacity(selectedEvent == nil ? 0 : min(1, max(0, 0.9 - abs(Double(self.eventImagePosition.height)))) )
                        .onTapGesture {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                            selectedEvent = nil
                        }
                    }
                    if let selectedEvent{
                        AsyncImage(url: URL(string: selectedEvent.attributes.eventImage.data.attributes.formats.small.url)){
                            img in
                            img
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .matchedGeometryEffect(id: selectedEvent.id, in: eventNamespace, isSource: self.selectedEvent != nil)
                        }
                           placeholder:{
                        
                    }
                        
                            .zIndex(2)
                            .offset(eventImagePosition)
                            .gesture(
                                DragGesture().onChanged{ value in
                                self.eventImagePosition = value.translation
                            }.onEnded{ value in
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)){
                                    if 200 < abs(self.eventImagePosition.height){
                                        self.selectedEvent = nil
                                    }else{
                                        self.eventImagePosition = .zero
                                    }
                                }
                            }
                            )
                        
                    }
                }.zIndex(2)
                
                                if authVM.isLoginDialogPresented {
                    AuthDialog(isPresented: $authVM.isLoginDialogPresented)
                        .transition(.move(edge: .leading)).zIndex(1)
                }
                
                
                

                VStack {
                    HStack{
                        
//                        Button {
//                                                       withAnimation {
//                                                           self.isLoginDialogPresented.toggle()
//                                                       }
//                                                   } label: {
//                                                       Text("Login")
//                                                           .font(.system(size: 16, weight: .medium, design: .default))
//                                                   }
                        
//                        NavigationLink {
//                            DashboardView()
//                        } label: {
//                            Text("🏡 MY SOCIETY")
//                                .font(.system(size: 14, weight: .bold, design: .default)).foregroundColor(.black).navigationBarBackButtonHidden(true)
//                        }
                       
                        NavigationLink {
                            DashboardView().navigationBarBackButtonHidden(true)
                        } label: {
                            Text("🏡 MY SOCIETY")
                                .font(.system(size: 14, weight: .bold, design: .default)).foregroundColor(.black).navigationBarBackButtonHidden(true)
                        }
                      
                        Spacer()
                        AppbarActionIcon(image: "youtube", onTap: {
                            if let url = URL(string: "http://www.youtube.com/live/DEPpO9M8wf4") {
                                UIApplication.shared.open(url)
                            }
                        })
                        VerticalDivider().frame(height: 10)
                        AppbarActionIcon(image: "facebook", onTap: {
                            if let url = URL(string: "http://www.facebook.com/MethodistChurchGH") {
                                UIApplication.shared.open(url)
                            }
                        })
                        VerticalDivider().frame(height: 10)
                        AppbarActionIcon(image: "twitter", onTap: {
                            if let url = URL(string: "http://www.twitter.com/methodist_ghana/") {
                                UIApplication.shared.open(url)
                            }
                        })
                        VerticalDivider().frame(height: 10)
                        AppbarActionIcon(image: "instagram", onTap: {
                            if let url = URL(string: "http://www.instagram.com/methodistchurchghana/") {
                                UIApplication.shared.open(url)
                            }
                        })
                    }.padding(.vertical, 10)
                    
                    ScrollView( showsIndicators: false){
                        VStack(spacing: 20){
                            TopBg(newsList: $newsList)
                            TodayBibleReadingCard()
                            VStack(alignment: .leading){
                                Text("Event")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 18, weight: .medium, design: .default))
                                
                                ScrollView(.horizontal,  showsIndicators: false){
                                    HStack(spacing: 20){
                                        if(eventImage != nil)
                                        {
                                            let result = eventImage!.data.sorted{$0.id > $1.id}
                                            ForEach(0..<result.count)
                                            {index in
                                                AsyncImage(url: URL(string: result[index].attributes.eventImage.data.attributes.formats.small.url)!) { image in
                                                           image
                                                               .renderingMode(.original)
                                                               .resizable()
                                                               .aspectRatio(contentMode: .fill)
                                                       } placeholder: {
                                                           Image(systemName: "photo.fill") .renderingMode(.original)
                                                               .resizable()
                                                               .aspectRatio(contentMode: .fill)
                                                               .matchedGeometryEffect(id: result[index].id, in: eventNamespace, isSource: self.selectedEvent == nil)

                                                           
                                                       }.frame(width: 240, height: 240)
                                                    .cornerRadius(20)
                                                    .onTapGesture {
                                                        eventImagePosition = .zero
                                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)){
                                                            selectedEvent = result[index]
                                                        }
                                                        
                                                    }
                                            }
                                        }
                                        else{
                                            
                                            ForEach(0..<10){
                                                _ in
                                                EventPreloader()
                                            }
                                        }
                                    }
                                    
                                }
                            }.padding(.vertical , 30)
                            
                            
                            VStack(alignment: .leading){
                                Text("Evangelism Tools")
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 18, weight: .medium, design: .default))
                                
                                ScrollView(.horizontal,  showsIndicators: false){
                                    HStack(spacing: 20){
                                        ForEach(evangelisms)
                                        {evangelism in
                                            EvangelismToolCard(evangelism: evangelism, onTap: {
                                                
                                            })
                                        }
                                    }
                                    
                                }
                            }.padding(.vertical , 30)
                            
                            
                        }
                    }
                    
                    
                    
                    Spacer()
                    
                    HStack(spacing: 50){
                        NavbarButton(title: "Find", icon: "house.fill", bgColor: Color("lightBlue"), onTap: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation {
                                    self.isFindPresented.toggle()
                                }
                            }
                        } ).fullScreenCover(isPresented: $isFindPresented) {
                            FindView()
                        }
                        NavbarButton(title: "Hymnal",icon: "music.note.list", bgColor: .white, onTap: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation {
                                    self.isHymnalPresented.toggle()
                                }
                            }
                            
                        } ).fullScreenCover(isPresented: $isHymnalPresented) {
                            HymnalView()
                                .offset(x: offset)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            offset = max(min(value.translation.width, 0), -UIScreen.main.bounds.width)
                                        }
                                        .onEnded { value in
                                            if value.translation.width > 100 {
                                                isHymnalPresented = false
                                            } else {
                                                withAnimation {
                                                    offset = .zero
                                                }
                                            }
                                        }
                                )
                        }
                        NavbarButton(title: "Liturgy",icon: "folder.fill", bgColor: Color("orangeColor"), onTap: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation {
                                    self.isLiturgyPresented.toggle()
                                }
                            }
                            
                        } ).fullScreenCover(isPresented: $isLiturgyPresented) {
                            LiturgyView()
                        }
                        NavbarButton(title: "Shop", icon: "cart.fill", bgColor: Color("blueColor"), iconColor: .white, onTap: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation {
                                    self.isShopPresented.toggle()
                                }
                            }
                            
                        } ).fullScreenCover(isPresented: $isShopPresented) {
                            ShopView()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .onAppear{
                isLoginDialogPresented = authVM.isLoginDialogPresented
                authVM.authenticateUser()
                print(authVM.isLoginDialogPresented)
                fetchNew()
                fetchEvent()
            }
            
            
        }.refreshable {
            await refreshData() // Call refreshData function
        }
        .navigationDestination(for: String.self) { view in
            if view == "Dashboard" {
                DashboardView()
            }
        }
        
        
        
    }
    
    func fetchNew(){
        NetworkManager<News>().getData(endpoint: Endpoint.news) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let news):
                    self.newsList = news
                case .failure(let error):
                    print("error ======> \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchEvent(){
        NetworkManager<Event>().getData(endpoint: Endpoint.event) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let event):
                    self.eventImage = event
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func refreshData() async {
            guard !isRefreshing else { return }
            isRefreshing = true

            // Simulate data loading delay
            await Task.sleep(1 * 1_000_000_000) // Sleep for 1 second

            // Fetch new data (replace this with your actual data fetching logic)
            fetchEvent()
            fetchNew()

            isRefreshing = false
        }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

enum AuthDialogType{
    case login
    case churchCode
    case forgotPassword
}

struct AuthDialog: View {
    @Binding var isPresented: Bool
    @StateObject var authVM = AuthViewModel()
    @StateObject var churchVM = ChurchViewModel()
    @State private var activeDialog:AuthDialogType = .login
    var body: some View {
        NavigationStack {
            ZStack {
               
                Color.black.opacity(isPresented ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            self.isPresented = false
                        }
                    }
                if(activeDialog == .login){
                    LoginDialog(isPresented: $isPresented, authVM: authVM, activeDialog: $activeDialog)
                }
                else if activeDialog == .churchCode{
                    ChurchCodeDialog(isPresented: $isPresented)
                }
                else if activeDialog == .forgotPassword{
                    PhoneNumberDialog(isPresented: $isPresented, authVM: authVM)
                }
                
            }
            
        }
        .alert(item: $authVM.alertItem) { item in
            Alert(title: Text(item.title), message: Text(item.message),  dismissButton: item.button)
        }.onDisappear{
            if (!authVM.isTokenExpired()){
//                NavigationLink( DashboardView())
                NavigationLink("") {
                    DashboardView()
                }
            }
        }
    }
}







struct AppbarActionIcon: View {
    var image: String
    var onTap: () -> ()
    var body: some View {
        Image(image)
            .resizable()
            .renderingMode(.original)
            .scaledToFit()
            .frame(width: 18, height: 18)
            .padding(.horizontal, 5).onTapGesture {
                self.onTap()
            }
            
    }
}

struct TopBg: View {
    
  @Binding   var newsList: News?
    
    @State private var selectedImageIndex: Int = 0
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    let autoSlide:Bool = false

    var body: some View {
        VStack {
            ZStack{
                Image("login_background")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width-20, height: 380)
                    .cornerRadius(40)
                
                Color.black.opacity(0.4)
                VStack(alignment: .leading){
                    Spacer()
                    
                    ZStack(alignment: .leading){
                       
                            Text("Today's news | February 3, 2023")
                                .font(.system(size: 14, weight: .medium, design: .default))
                                .foregroundColor(.white).padding(.horizontal)
                        Color.white.opacity(0.2).cornerRadius(10)
                      

                           
                            
                    }.frame(width: 250, height: 40)
                        .padding(12)
                    if(newsList != nil){
                        
                        ZStack {
                            // Step 5: Create TabView for Carousel
                            TabView(selection: $selectedImageIndex) {
                                // Step 6: Iterate Through Images
                                ForEach(0..<newsList!.data.count, id: \.self) { index in
                                   
                                    VStack(alignment: .leading){
                                        Text(newsList!.data[index].attributes.title.removeHTMLTags())
                                                                   .font(.system(size: 20, weight: .bold, design: .default))
                                                                   .foregroundColor(.white).padding(8)
                                    
                                        Text(newsList!.data[index].attributes.content.removeHTMLTags())
                                                                   .font(.system(size: 16, weight: .bold, design: .default))
                                                                   .foregroundColor(.white)
                                    }.frame(width: UIScreen.main.bounds.width-40, height: 160, alignment: .leading
                                           )
                                }
                            }// Step 10: Set Carousel Height
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Step 11: Customize TabView Style
                            

                            // Step 12: Navigation Dots
//                            HStack {
//                                ForEach(0..<newsList!.data.count, id: \.self) { index in
//                                    // Step 13: Create Navigation Dots
//                                    Capsule()
//                                        .fill(Color.white.opacity(selectedImageIndex == index ? 1 : 0.33))
//                                        .frame(width: 35, height: 8)
//                                        .onTapGesture {
//                                            // Step 14: Handle Navigation Dot Taps
//                                            selectedImageIndex = index
//                                        }
//                                }
//                                .offset(y: 130) // Step 15: Adjust Dots Position
//                            }
                        }
                        .onReceive(timer) { _ in
                            // Step 16: Auto-Scrolling Logic
                            if(autoSlide)
                            {
                                withAnimation(.default) {
                                    selectedImageIndex = (selectedImageIndex + 1) % newsList!.data.count
                                }
                            }
                        }
                    }
                    else{
                        VStack(alignment: .leading){
                            VStack(alignment: .leading){
                                Shimmer().cornerRadius(15).frame( width: 310,height: 30)
                                Shimmer().cornerRadius(15).frame(width: 260,height: 30)
                                Shimmer().cornerRadius(15).frame(width: 210,height: 30)
                            }
                            Spacer()
                        }
                    }
                    
                  
                    if(newsList != nil){
                        NavigationLink {
                            NewsView().navigationBarBackButtonHidden(true)
                        } label: {
                            Text("read all 📰").foregroundColor(.white).padding(.vertical, 20)
                        }
                    }
                    

                   
                    
                   
                    
                }.padding()
            }.frame(width: UIScreen.main.bounds.width-20, height: 380)
                .cornerRadius(35)
            .shadow(radius: 20)
        }
        
    }
}




struct TodayBibleReadingCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Today's Bible Reading")
                .font(.system(size: 16, weight: .medium, design: .default))
            Text("CONSEQUENCES OF HUMANKIND'S REJECTION OF THE KNOWLEDGE OF GOD")
                .font(.system(size: 16, weight: .bold, design: .default))
                .foregroundColor(Color("blueColor"))
            Text("John 3:16-21")
                .font(.system(size: 16, weight: .medium, design: .default))
            Text("Humankind has rejected the light")
                .font(.system(size: 16, weight: .medium, design: .default))
        }.padding(20)
            .background(.white).frame(width: UIScreen.main.bounds.width-20).shadow(radius: 10, x: -10.0, y: 10.0)
            .cornerRadius(20)
    }
}


struct EvangelismToolCard: View {
    var evangelism: Evangelism
    let onTap: ()->()
    var body: some View {
        NavigationLink {
            if(evangelism.content != nil){
                EvangelismView(evangelism: evangelism)
            }
        } label: {
            VStack(alignment: .leading){
                
                VStack(alignment: .leading){
                    Image(evangelism.imageUrl)
                        .resizable()
                        .renderingMode(.original)
                    VStack(alignment: .leading, spacing: 5){
                        Text(evangelism.title)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14, weight: .medium, design: .default))
                        Text(evangelism.subTitle)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 12, weight: .medium, design: .default))
                    }.padding(.horizontal, 10)
                }.frame(width: 240, height: 190)
                    .background(.white)
                    .cornerRadius(10)
                .shadow(radius: 2, x: 0, y:1)
                
            }.padding(.bottom, 20).onTapGesture {
                    self.onTap()
                }
        }

    }
}






struct PhoneNumberDialog: View {
    @Binding var isPresented: Bool
    @StateObject var authVM = AuthViewModel()
    var body: some View {
        VStack {
            LottieView(filename: "forgot_pwd")
                .frame(width: 90, height: 90).padding(.vertical)
            CustomInputField(
                placeholder: "Enter phone number", text: $authVM.memberCode).padding(.horizontal)
            
            //                    TextField("Member code", text: $authVM.memberCode).frame(maxWidth: .infinity).padding()
            //                    TextField("Password", text: $authVM.password).frame(maxWidth: .infinity).padding()
            
            
            if authVM.isLoading {
                ProgressView("Verifying church code...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }else{
                Button("RESET") {
                    
                    authVM.submitForm()
                    
                }
                .padding()
                
            }
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
        .opacity(isPresented ? 1 : 0)
        .offset(x: isPresented ? 0 : -300, y: isPresented ? 0 : -300)
    }
}




struct ChurchCodeDialog: View {
    @Binding var isPresented: Bool
    @StateObject var authVM = AuthViewModel()
    @StateObject var churchVM = ChurchViewModel()
    @State private var churchCode:String = ""
    var body: some View {
        VStack {
            LottieView(filename: "entry_code")
                .frame(width: 90, height: 90).padding(.vertical)
            CustomInputField(
                placeholder: "Church Code", text: $churchCode).padding(.horizontal)
            
            //                    TextField("Member code", text: $authVM.memberCode).frame(maxWidth: .infinity).padding()
            //                    TextField("Password", text: $authVM.password).frame(maxWidth: .infinity).padding()
            
            
            if authVM.isLoading || churchVM.isLoading {
                ProgressView("Verifying church code...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }else{
                Button("VERIFY") {
                    
                    let  result:Church? =      churchVM.getChurchByCode(churchCode: churchCode)
                    
                    if(result != nil){
                        print(result?.societyName)
                    }
                    
                }
                .padding()
                
            }
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
        .opacity(isPresented ? 1 : 0)
        .offset(x: isPresented ? 0 : -300, y: isPresented ? 0 : -300)
        
        
    }
}



struct LoginDialog: View {
    @Binding var isPresented: Bool
    @StateObject var authVM = AuthViewModel()
    @Binding var activeDialog:AuthDialogType
    var body: some View {
        VStack {
            VStack {
                HStack{
                    Text("Log in as member")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .padding()
                    Spacer()
                }
                CustomInputField(prefixIcon: "person.fill",
                                 suffixIcon: !authVM.memberCode.isEmpty ? "xmark.circle.fill" : nil,
                                 placeholder: "Member code", isDisabled: authVM.isLoading, text: $authVM.memberCode).padding()
                CustomInputField(prefixIcon: "lock.fill",
                                 suffixIcon: "eye.fill", placeholder: "Passcode", isPasswordField: true, isDisabled: authVM.isLoading, text: $authVM.password).padding()
                HStack{
                    Spacer()
                    Text("forgot password?").font(.caption).foregroundColor(.gray).padding(.trailing).onTapGesture {
                        if(!authVM.isLoading){
                            withAnimation {
                                activeDialog = .forgotPassword
                            }
                        }
                        
                    }
                }
                
                if authVM.isLoading {
                    ProgressView("Logging in...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }else{
                    Button
                    
                    {
                        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
                        authVM.submitForm()
                        
                    } label: {
                        Text("LOGIN")
                            .font(.system(size: 16, weight: .medium, design: .default))
                            .foregroundColor(.black)
                            .frame(width: 150)
                            .padding()
                               
                            .background(Color("bgColor"))
                            
                            .cornerRadius(30).shadow(radius: 3, y: 2)
                    }.padding(.vertical, 10)
                    
                    
                    
                    
                }
                
                Button {
                    if(!authVM.isLoading){
                        withAnimation {
                            activeDialog = .churchCode
                        }
                    }
                    
                } label: {
                    Text("Don't have a member code?")
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .foregroundColor(Color("blueColor")).padding(.vertical, 20)
                }
                
                
            }.padding(.vertical)
           
        } .frame(maxWidth: .infinity, minHeight: 60)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding()
            
            .opacity(isPresented ? 1 : 0)
        .offset(x: isPresented ? 0 : -300, y: isPresented ? 0 : -300)
    }
}
