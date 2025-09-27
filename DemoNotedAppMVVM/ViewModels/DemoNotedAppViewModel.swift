//
//  DemoNotedAppViewModel.swift
//  DemoNotedAppMVVM
//
//  Created by Meang Atithkithya on 25/9/25.
//

import Foundation
import CoreData

class DemoNotedAppViewModel: ObservableObject {

    let manager: DemoNotedAppCoreDataManager
    @Published var notes: [DemoNotedAppEntity] = []
    @Published var isDataLoaded = false

    init(manager: DemoNotedAppCoreDataManager) {
        self.manager = manager
        loadData()
    }
    
    func loadData() {
        manager.loadNotedCoreData { [weak self] success in
            DispatchQueue.main.async {
                self?.isDataLoaded = success
                if success {
                    self?.fetchNotes()
                }
            }
        }
    }

    func fetchNotes(with searchText: String = "")  {
        let request: NSFetchRequest<DemoNotedAppEntity> = DemoNotedAppEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createDate", ascending: false)]
        
        if !searchText.isEmpty {
            request.predicate = NSPredicate(format: "title CONTAINS %@", searchText)
        }

        do {
            notes = try manager.container.viewContext.fetch(request)
        } catch {
            print("Error fetching notes: \(error)")
        }
    }

    func createNote() -> DemoNotedAppEntity {
        let newNote = DemoNotedAppEntity(context: manager.container.viewContext)
        newNote.id = UUID()
        newNote.createDate = Date()
        saveContext()
        fetchNotes()
        
        return newNote
    }

    func deleteNote(_ note: DemoNotedAppEntity) {
        manager.container.viewContext.delete(note)
        saveContext()
        fetchNotes()
    }

    func updateNote(_ note: DemoNotedAppEntity, title: String, content: String) {
        note.title = title
        note.content = content
        saveContext()
        fetchNotes()
    }
    
    func searchNotes(with searchText: String) {
        fetchNotes(with: searchText)
    }

    private func saveContext() {
        do {
            try manager.container.viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

