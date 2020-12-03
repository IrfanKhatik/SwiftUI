//
//  DatabaseManager.swift
//  Cats
//
//  Created by Irfan Khatik on 02/12/20.
//

import Foundation
import CoreData
import SwiftUI

struct DatabaseManager {
    static let shared = DatabaseManager()
    
    private var viewContext = PersistenceController.shared.container.viewContext
    
    private init() {
    }
    
    // Store all cat items fetched from network
    func addCatListItems(_ items: [CatListItem]) {
        // Clear all item before storing new
        deleteAllCatItems()
        
        let _:[CatItem] = items.compactMap { (cat) -> CatItem in
            let catitem = CatItem(context: self.viewContext)
            catitem.name    = cat.name
            catitem.id      = cat.id
            catitem.desc    = cat.description
            catitem.origin  = cat.origin
            
            return catitem
        }
        
        saveContext()
    }
    
    // Fetch all stored cat items
    func fetchAllCatItems()->[CatItem] {
        var result = [CatItem]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CatItem")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CatItem.name, ascending: true)]
        do {
            if let all = try viewContext.fetch(request) as? [CatItem] {
                result = all
            }
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }
    
    // Delete all stored cat items
    func deleteAllCatItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CatItem")
        do {
            if let all = try viewContext.fetch(request) as? [CatItem] {
                for catItem in all {
                    viewContext.delete(catItem)
                }
            }
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        saveContext()
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
