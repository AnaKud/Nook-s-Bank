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
    func addTurnip(turnip: TurnipPrices)
    func updateTurnip(turnip: TurnipPrices)
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
            print(data.count)
            return convertToNewsFromCoreData(news: data)
        } catch let error {
            self.errorPresenter?.presentError(error: .fetchError)
            print(error.localizedDescription)
        }
        return [NewsViewModel]()
    }
    
    func addNews(news: NewsViewModel) {
        container.performBackgroundTask { context in
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
    
    func addTurnip(turnip: TurnipPrices) {
        let turnipContext = Turnip(context: context)
        turnipContext.sundayDate = turnip.sundayDate
        turnipContext.buyPrice = Int32(turnip.buyPrice)
        turnipContext.turnipCount = Int32(turnip.turnipCount ?? 0)
        turnipContext.mondayMorning = Int32(turnip.mondayMorning ?? 0)
        turnipContext.mondayEvening = Int32(turnip.mondayEvening ?? 0)
        turnipContext.tuesdayMorning = Int32(turnip.tuesdayMorning ?? 0)
        turnipContext.tuesdayEvening = Int32(turnip.tuesdayEvening ?? 0)
        turnipContext.wednesdayMorning = Int32(turnip.wednesdayMorning ?? 0)
        turnipContext.wednesdayEvening = Int32(turnip.wednesdayEvening ?? 0)
        turnipContext.thursdayMorning = Int32(turnip.thursdayMorning ?? 0)
        turnipContext.thursdayEvening = Int32(turnip.thursdayEvening ?? 0)
        turnipContext.fridayMorning = Int32(turnip.fridayMorning ?? 0)
        turnipContext.fridayEvening = Int32(turnip.fridayEvening ?? 0)
        turnipContext.saturdayMorning = Int32(turnip.saturdayMorning ?? 0)
        turnipContext.saturdayEvening = Int32(turnip.saturdayEvening ?? 0)
        do {
            try context.save()
        } catch let error {
            self.errorPresenter?.presentError(error: .saveError)
            print(error.localizedDescription)
        }
    }
    
    func updateTurnip(turnip: TurnipPrices) {
        let fetchRequest: NSFetchRequest<Turnip> = Turnip.fetchRequest()
        if let object = try? context.fetch(fetchRequest).first {
            object.sundayDate = turnip.sundayDate
            object.buyPrice = Int32(turnip.buyPrice)
            object.turnipCount = Int32(turnip.turnipCount ?? 0)
            object.mondayMorning = Int32(turnip.mondayMorning ?? 0)
            object.mondayEvening = Int32(turnip.mondayEvening ?? 0)
            object.tuesdayMorning = Int32(turnip.tuesdayMorning ?? 0)
            object.tuesdayEvening = Int32(turnip.tuesdayEvening ?? 0)
            object.wednesdayMorning = Int32(turnip.wednesdayMorning ?? 0)
            object.wednesdayEvening = Int32(turnip.wednesdayEvening ?? 0)
            object.thursdayMorning = Int32(turnip.thursdayMorning ?? 0)
            object.thursdayEvening = Int32(turnip.thursdayEvening ?? 0)
            object.fridayMorning = Int32(turnip.fridayMorning ?? 0)
            object.fridayEvening = Int32(turnip.fridayEvening ?? 0)
            object.saturdayMorning = Int32(turnip.saturdayMorning ?? 0)
            object.saturdayEvening = Int32(turnip.saturdayEvening ?? 0)
        }
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
