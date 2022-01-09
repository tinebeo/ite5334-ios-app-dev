//
//  CoreDataService.swift
//  animeschedule
//
//  Created by Christine Ebeo on 2021-12-30.
//

import Foundation
import CoreData

class CoreDataService {
    static var shared = CoreDataService()
    
    var searchFetchedResultController : NSFetchedResultsController<FavouritesScheduleInfo>?
    
    // All favourited shows
    lazy var fetchedResultController: NSFetchedResultsController<FavouritesScheduleInfo> = {
        let fetchRequest : NSFetchRequest<FavouritesScheduleInfo> = FavouritesScheduleInfo.fetchRequest()
        
        var sortDescription = NSSortDescriptor(key:"title",ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescription]
    
        // select * from FavouritesScheduleInfo order by title asc
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil,cacheName: nil)
        
        return frc
    }()
    
    // Add favourite
    func addFavourite(malId: Int32, imageUrl: String, title: String)  {
        let newFave = FavouritesScheduleInfo(context: persistentContainer.viewContext)
        newFave.mal_id = malId
        newFave.image_url = imageUrl
        newFave.title = title
        saveContext()
    }
    
    // Get favourite
    func getFavourite(malId: Int32) {
        do {
            searchFetchedResultController = {
                let fetchRequest : NSFetchRequest<FavouritesScheduleInfo> =  FavouritesScheduleInfo.fetchRequest()
            
                var sortDescription = NSSortDescriptor(key:"title",ascending: true)
                
                fetchRequest.sortDescriptors = [sortDescription]
                
                // select * from FavouritesScheduleInfo where task contains 'value'
                let p : NSPredicate = NSPredicate(format: "mal_id == %i ", malId)
                fetchRequest.predicate = p
            
                let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            
                return frc
            }()
            
            try searchFetchedResultController!.performFetch()
            
        } catch {
            print(error)
        }
    }
    
    // Deletes a favourite
    func deleteFavourite(fsi: FavouritesScheduleInfo)  {
        
        persistentContainer.viewContext.delete(fsi)
        saveContext()
        
      //fetchedResultController.managedObjectContext.delete(taskToDelete)

        
        
    }
    
    // From AppDelegate, similar to lecture it was moved here
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "animeschedule")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
