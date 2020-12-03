//
//  CatItem.swift
//  Cats
//
//  Created by Irfan Khatik on 03/12/20.
//

import CoreData

@objc(CatItem)
final class CatItem: NSManagedObject, Identifiable {
    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var desc: String?
    @NSManaged var url: String?
    @NSManaged var origin: String?
    @NSManaged var image: Data?
}
