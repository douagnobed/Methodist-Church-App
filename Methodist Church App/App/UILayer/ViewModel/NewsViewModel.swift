//
//  NewsViewModel.swift
//  MethodistMobile
//
//  Created by Q002 on 23/02/2024.
//

import Foundation
import SwiftUI


final class NewsViewModel:ObservableObject{
    @Published var newsList: News?
    @Published var isLoading:Bool = false
    @Published var alertItem:AlertItem?
    private var newsStore = NetworkManager<News>()
    
    func read() -> Void{
        isLoading = true
        newsStore.getData(endpoint: Endpoint.news) { result in
            switch result {
               case .success(let dataResponse):
                print("News: \(String(describing: dataResponse))")
                self.isLoading = false
                self.newsList = dataResponse!
                print(dataResponse)
                print(self.newsList)
               case .failure(let error):
                print(error)
                self.isLoading = false
                self.alertItem = AlertItem(
                        id: 1,
                        title: "Server Error", message: error.localizedDescription, button: .default(Text("ok")))
                   print("Failed to retrieve Organization: \(error)")
               
               }
            
        }
        
     }
     
}
