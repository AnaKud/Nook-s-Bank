//
//  NewsPresenter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 11.06.2021.
//

import Foundation

protocol INewsPresenter {
    func makeRequest()
    func loadView(view: INewsViewController)
    func cellCount() -> Int
    func itemForCell(index: Int) -> EventsViewModel
}

class NewsPresenter: INewsPresenter {
    var networkManager: INewsNetworkManager
    var coreData: INewsCoreDataManager
    private var view: INewsViewController?
    
    var eventFromInternet = [EventsFromInternet]()
    var eventViewModel = [EventsViewModel]()
    var eventsFromCoreData = [EventsViewModel]()
    
    init(networkManager: INewsNetworkManager, coreData: INewsCoreDataManager) {
        self.networkManager = networkManager
        self.coreData = coreData
        self.eventsFromCoreData = self.coreData.loadNews()
    }
    
    func makeRequest() {
        self.view?.displayActivity()
        self.networkManager.downloadData(link: .events) { data in
            if let events = data {
                self.eventFromInternet = events
                self.cleanCoreData()
                self.eventViewModel = self.convertFromInternetToVM(eventsFromInternet: events)
                self.view?.displayTable()
                self.refreshView()
                
            } else {
                self.eventViewModel = self.sortEventsFromCoreDataByDay(events: self.eventsFromCoreData)
            }
            self.view?.displayTable()
            self.refreshView()
        }
    }
    
    func loadView(view: INewsViewController) {
        self.view = view
    }
    
    func cellCount() -> Int {
        return self.eventViewModel.count
    }
    
    func itemForCell(index: Int) -> EventsViewModel {
        return eventViewModel[index]
    }
    
    private func convertFromInternetToVM(eventsFromInternet: [EventsFromInternet]) -> [EventsViewModel] {
        var eventsVM = [EventsViewModel]()
        let subArray = self.sortEventsFromInternetByDay(events: eventsFromInternet)
        for item in subArray {
            let newEventVM = EventsViewModel(fromInternet: item)
            eventsVM.append(newEventVM)
            self.saveToCoreData (event: newEventVM)
        }
        return eventsVM
    }
    
    private func saveToCoreData(event: EventsViewModel) {
        DispatchQueue.main.sync {
            self.coreData.addNews(news: event)
        }
    }
    
    private func cleanCoreData() {
        DispatchQueue.main.sync {
            self.coreData.deleteAllNews()
        }
    }
    
    private func sortEventsFromInternetByDay(events: [EventsFromInternet]) -> [EventsFromInternet] {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        let todayString = dateFormatter.string(from: today)
        print(todayString)
        let subArray = events.drop { event in
            event.date != todayString
        }
        return Array(subArray)
    }
    
    private func sortEventsFromCoreDataByDay(events: [EventsViewModel]) -> [EventsViewModel] {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        let todayString = dateFormatter.string(from: today)
        print(todayString)
        let subArray = events.drop { event in
            event.date != todayString
        }
        return Array(subArray)
    }
    
    private func refreshView() {
        self.view?.refreshView()
    }
    
}
