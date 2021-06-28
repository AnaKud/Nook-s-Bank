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

protocol INewsCoreDataManager {
    func loadNews()-> [NewsViewModel]
    func addNews(news: NewsViewModel)
    func deleteAllNews()
    func initErrorPresenterForNews(errorPresenter: IPresenterForCoreDataError)
}

protocol ITurnipCoreDataManager {
   
}

class CoreDataManager {
    static let shared = CoreDataManager()
    
    var errorPresenter: IPresenterForCoreDataError?
    
    private enum Constant {
        static let containerName = "AnimalCrossing"
        static let news = "News"
        static let turnip = "Turnip"
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

extension CoreDataManager: INewsCoreDataManager {
    func loadNews() -> [NewsViewModel] {
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        do {
            let data = try context.fetch(fetchRequest)
            return convertToNewsFromCoreData(news: data)
        } catch let error {
            self.errorPresenter?.presentError(error: .fetchError)
            print(error.localizedDescription)
        }
        return [NewsViewModel]()
    }
    
    func addNews(news: NewsViewModel) {
        let newsContext = News(context: context)
        newsContext.date = news.date
        newsContext.event = news.event
        newsContext.url = news.url
        newsContext.type = news.type
        do {
            try context.save()
        } catch let error {
            self.errorPresenter?.presentError(error: .saveError)
            print(error.localizedDescription)
        }
    }
    
    func deleteAllNews() {
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        do {
            try context.save()
        } catch let error {
            self.errorPresenter?.presentError(error: .deleteAllError)
            print(error.localizedDescription)
        }
    }
    
    func initErrorPresenterForNews(errorPresenter: IPresenterForCoreDataError) {
        self.errorPresenter = errorPresenter
    }
    
    private func convertToNewsFromCoreData(news: [News]) -> [NewsViewModel] {
        var result = [NewsViewModel]()
        for event in news {
            if let newEvent = NewsViewModel(fromNews: event) {
                result.append(newEvent)
            }
        }
        return result
    }
}

extension CoreDataManager: ITurnipCoreDataManager {
    
}
