//
//  CoreDataManager.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import Foundation
import CoreData

protocol IPresenterForCoreDataError {
    func presentError(error: FailureCases)
}

protocol ILoginCoreDataManager {
   
}

class CoreDataManager {
        var errorPresenter: IPresenterForCoreDataError?
        
        private enum Constant {
            static let containerName = "AnimalCrossing"
            
        }
        
        lazy var container: NSPersistentContainer = {
            let container = NSPersistentContainer(name: Constant.containerName)
            container.loadPersistentStores(completionHandler: { (_, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        
        lazy var context: NSManagedObjectContext = container.viewContext

    
        func saveContext () {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    
}

extension CoreDataManager: ILoginCoreDataManager {
    
    
    
}

