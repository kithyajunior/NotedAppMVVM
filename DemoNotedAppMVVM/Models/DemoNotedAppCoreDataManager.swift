//
//  DemoNotedAppCoreDataManager.swift
//  DemoNotedAppMVVM
//
//  Created by ACLEDA on 25/9/25.
//


import CoreData

class DemoNotedAppCoreDataManager {
    
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "DemoNotedAppContainer")
    }

    func loadNotedCoreData(completion: @escaping (Bool) -> Void) {
        container.loadPersistentStores { description, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("loading noted core data error: \(error.localizedDescription)")
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
}
