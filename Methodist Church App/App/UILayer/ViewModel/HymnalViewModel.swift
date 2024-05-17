//
//  HymnalViewModel.swift
//  MethodistMobile
//
//  Created by Q002 on 28/02/2024.
//

import Foundation
import SwiftUI
import AVFoundation
import CoreData


final class HymnalViewModel:ObservableObject{
    @Published var englishHymnals: [EnglishHymnal] = []
    @Published var fantseHymnals: [Hymnal] = []
    @Published var isLoading:Bool = false
    private var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    private let fileExtension = "mp3"
    @Published var alertItem:AlertItem?
    let container: NSPersistentContainer
    @FetchRequest(entity: EnglishHymnal.entity(), sortDescriptors: []) var items: FetchedResults<EnglishHymnal>
        @State private var itemsInMemory: [EnglishHymnal] = []
    
    
    
    init(){
       
        container = NSPersistentContainer(name: "Methodist_Church_App")
        container.loadPersistentStores { (description, error) in
            if error != nil {
                self.alertItem = AlertItem(id: 1, title: "Error", message: "Failed to  initialize local db", button: .default(Text("Ok")))
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        loadItemsIntoMemory()
        
    }
    
    func loadItemsIntoMemory() {
            itemsInMemory = Array(items)
        }
    
    func insertDefaultDataIfNeeded(){
        self.isLoading = true
            do {
              
                        
                if itemsInMemory.count == 0 {
                            // No data exists, insert default data
                            self.insertDefaultData()
                        }
                self.fetchEnglishHymnals()
                    } catch {
                        self.alertItem = AlertItem(id: 1, title: "Error", message: "Error checking for existing data: \(error.localizedDescription)", button: .default(Text("Ok")))
                       
                    }
        
        self.isLoading = false
    }
    
    
    
    private func insertDefaultData() {
        DispatchQueue.main.async {
            // Insert your default data here
            let context = self.container.viewContext
            
            // Example of inserting a default item
         
         hymnalList.map { hymn in
             let newItem = EnglishHymnal(context: context)
             newItem.id = Int64(hymn.id)
             newItem.title = hymn.title
             newItem.lyrics = hymn.lyrics
             newItem.type = hymn.type
         }
        
            // Set other properties
            
            // Save changes to Core Data
            do {
                try context.save()
            } catch {
                print("Error saving default data: \(error.localizedDescription)")
            }
        }
       }
    
    
    
    
    func fetchEnglishHymnals(){
        self.isLoading = true
        let request = NSFetchRequest<EnglishHymnal>(entityName: "EnglishHymnal")
        do{
            englishHymnals = try! container.viewContext.fetch(request)
//            print("EnglishHymnal =====> \(englishHymnals)")
        }catch let error{
            self.alertItem = AlertItem(id: 1, title: "Error", message: "Failed with error \(error)", button: .default(Text("Ok")))
        }
        self.isLoading = false
    }

    
   
    func loadHymmals(){
//        englishHymnals = hymnalList
        fantseHymnals = fantsHymns
    }
    
    func hymnUrl(hymnId:Int)-> String{
        return "hymns/_\(hymnId)"
    }
    
    func isAudioHymnExist(hymnId:Int) -> Bool{
        var link:String = self.hymnUrl(hymnId: hymnId)
        return (Bundle.main.url(forResource:link, withExtension: fileExtension) != nil && Bundle.main.url(forResource:link, withExtension: fileExtension)!.isFileURL == true)
    }
    
    func playHymns(hymnId:Int)-> Void{
        
        guard let soundFile = NSDataAsset(name: "_\(hymnId)") else{
            self.alertItem = AlertItem(id: 1, title: "Error", message: "hymnal number \(hymnId) file does not exist", button: .default(Text("Ok")))
            return
        }
        
    
            do {
                self.audioPlayer = try AVAudioPlayer(data: soundFile.data)
//                self.audioPlayer.prepareToPlay()
                self.audioPlayer.play()
            }catch {
                alertItem = AlertItem(id: 1, title: "Error", message: "hymnal number \(error.localizedDescription) file does not exist", button: .default(Text("Ok")))
                print("Eror")
            }  
    }
    
    func stopHymns()-> Void{
        self.audioPlayer.stop()
    }
    
    func isPlaying()->Bool{
       return self.audioPlayer.isPlaying
    }
}
