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
    func loadTurnip() -> TurnipPrices?
    func addOrUpdateTurnip(turnip: TurnipPrices)
    func deleteTurnip()
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
}

extension CoreDataManager: ITurnipCoreDataManager {
    func loadTurnip() -> TurnipPrices? {
        let fetchRequest: NSFetchRequest<Turnip> = Turnip.fetchRequest()
        do {
            let dataArray = try context.fetch(fetchRequest)
            guard let data = dataArray.first else { return nil }
            return TurnipPrices(fromCoreData: data)
        } catch let error {
            self.errorPresenter?.presentError(error: .fetchError)
            print(error.localizedDescription)
        }
        return nil
    }
    
    func addOrUpdateTurnip(turnip: TurnipPrices) {
        let turnipContext = Turnip(context: context)
        turnipContext.sundayDate = turnip.sundayDate
        turnipContext.buyPrice = Int32(turnip.buyPrice)
        turnipContext.turnipCount = Int32(turnip.turnipCount ?? 0)
        turnipContext.mondayMorning = Int32(turnip.mondayMorning)
        turnipContext.mondayEvening = Int32(turnip.mondayEvening)
        turnipContext.tuesdayMorning = Int32(turnip.tuesdayMorning)
        turnipContext.tuesdayEvening = Int32(turnip.tuesdayEvening)
        turnipContext.wednesdayMorning = Int32(turnip.wednesdayMorning)
        turnipContext.wednesdayEvening = Int32(turnip.wednesdayEvening)
        turnipContext.thursdayMorning = Int32(turnip.thursdayMorning)
        turnipContext.thursdayEvening = Int32(turnip.thursdayEvening)
        turnipContext.fridayMorning = Int32(turnip.fridayMorning)
        turnipContext.fridayEvening = Int32(turnip.fridayEvening)
        turnipContext.saturdayMorning = Int32(turnip.saturdayMorning)
        turnipContext.saturdayEvening = Int32(turnip.saturdayEvening)
        
        do {
            try context.save()
        } catch let error {
            self.errorPresenter?.presentError(error: .saveError)
            print(error.localizedDescription)
        }
    }
    
    func deleteTurnip() {
        let fetchRequest: NSFetchRequest<Turnip> = Turnip.fetchRequest()
        if let object = try? context.fetch(fetchRequest).first { context.delete(object) }
        do {
            try context.save()
        } catch let error {
            self.errorPresenter?.presentError(error: .deleteAllError)
            print(error.localizedDescription)
        }
    }
}

fileprivate extension CoreDataManager {
    private func convertToNewsFromCoreData(news: [News]) -> [NewsViewModel] {
        return news.compactMap { event in
            NewsViewModel(fromCoreData: event)
        }
    }
    
  
}
