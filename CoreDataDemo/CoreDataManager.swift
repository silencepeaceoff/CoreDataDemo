//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Dmitrii Tikhomirov on 4/22/23.
//

import Foundation
import UIKit
import CoreData

//MARK: - CreateReadUpdateDelete
public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    //DataBasePath
    public func logCoreDataDBPath() {
        if let url = appDelegate.persistentContainer.persistentStoreCoordinator.persistentStores.first?.url {
            print("DB url - \(url)")
        }
    }
    
    //Create
    public func createPhoto(_ id: Int16, title: String?, url: String?) {
        guard let photoEntityDescription = NSEntityDescription.entity(forEntityName: "Photo", in: context) else { return }
        let photo = Photo(entity: photoEntityDescription, insertInto: context)
        photo.id = id
        photo.url = url
        photo.title = title
        
        appDelegate.saveContext()
    }
    
    //Read
    public func fetchPhoto() -> [Photo] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            return (try? context.fetch(fetchRequest) as? [Photo]) ?? []
        }
    }
    
    public func fetchPhoto(with id: Int16) -> Photo? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            let photos = try? context.fetch(fetchRequest) as? [Photo]
            return photos?.first { $0.id == id }
        }
    }
    
    //Update
    public func updatePhoto(with id: Int16, newUrl: String, newTitle: String? = nil) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            guard let photos = try? context.fetch(fetchRequest) as? [Photo],
                  let photo = photos.first(where: { $0.id == id })  else { return }
            
            photo.url = newUrl
            photo.title = newTitle
        }
        
        appDelegate.saveContext()
    }
    
    //Delete
    public func deleteAllPhotos() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            let photos = try? context.fetch(fetchRequest) as? [Photo]
            photos?.forEach { context.delete($0) }
        }
        
        appDelegate.saveContext()
    }
    
    public func deletePhoto(with id: Int16) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            guard let photos = try? context.fetch(fetchRequest) as? [Photo],
                  let photo = photos.first(where: { $0.id == id }) else { return }
            
            context.delete(photo)
        }
        
        appDelegate.saveContext()
    }
}
