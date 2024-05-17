//
//  NoteModel.swift
//  Methodist Church App
//
//  Created by Q002 on 10/03/2024.
//

import Foundation
import CoreData
import SwiftUI

final class NoteViewModel: ObservableObject{
    @Published var  alertItem:AlertItem?
    @Published var noteList:[Note] = []
    @Published var isLoading = false
    let container: NSPersistentContainer
    init(inMemory: Bool = false){
        container = NSPersistentContainer(name: "Methodist_Church_App")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                self.alertItem = AlertItem(id: 1, title: "Error", message: "Failed to  initialize local db", button: .default(Text("Ok")))
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        fetchNotes()
        
    }
    
    func fetchNotes(){
        self.isLoading = true
        let request = NSFetchRequest<Note>(entityName: "Note")
        do{
            noteList = try! container.viewContext.fetch(request)
            print("NoteList =====> \(noteList)")
        }catch let error{
            self.alertItem = AlertItem(id: 1, title: "Error", message: "Failed with error \(error)", button: .default(Text("Ok")))
        }
        self.isLoading = false
    }
    
    func addNote(title: String, priority: String, content: String){
        
        var newNote = Note(context: container.viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.content = content
        newNote.priority = priority
        newNote.createdAt = Date()
        newNote.updateAt = Date()
        
        saveData()
        
    }
    
    func saveData(){
        do{
           try container.viewContext.save()
            fetchNotes()
        }catch let error{
            self.alertItem = AlertItem(id: 1, title: "Error", message: "Failed with error \(error)", button: .default(Text("Ok")))
        }
    }
}
