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
    func itemForCell(index: Int) -> NewsViewModel
    func cellPressed(index: Int)
}

class NewsPresenter: INewsPresenter {
    
    var networkManager: INewsNetworkManager
    var coreData: INewsCoreDataManager
    var router: INewsRouter
    private var view: INewsViewController?
    
    var newsFromInternet = [NewsResponse]()
    var newsViewModel = [NewsViewModel]()
    var newsFromCoreData = [NewsViewModel]()
    
    init(networkManager: INewsNetworkManager, coreData: INewsCoreDataManager, router: INewsRouter) {
        self.networkManager = networkManager
        self.coreData = coreData
        self.router = router
        self.newsFromCoreData = self.coreData.loadNews()
    }
    
    func makeRequest() {
        self.view?.displayActivity()
        self.networkManager.downloadNews(link: .events) { data in
            if let events = data {
                self.newsFromInternet = events
                self.cleanCoreData()
                self.newsViewModel = self.convertFromInternetToVM(eventsFromInternet: events)
                self.view?.displayTable()
                self.refreshView()
                
            } else {
                self.newsViewModel = self.sortEventsFromCoreDataByDay(events: self.newsFromCoreData)
            }
            self.view?.displayTable()
            self.refreshView()
        }
    }
    
    func loadView(view: INewsViewController) {
        self.view = view
    }
    
    func cellCount() -> Int {
        return self.newsViewModel.count
    }
    
    func itemForCell(index: Int) -> NewsViewModel {
        return newsViewModel[index]
    }
    
    func cellPressed(index: Int) {
        let event = self.itemForCell(index: index)
        let url = event.url
        self.router.routeToWebView(withUrl: url)
    }

    private func saveToCoreData(event: NewsViewModel) {
        DispatchQueue.main.sync {
            self.coreData.addNews(news: event)
        }
    }
    
    private func cleanCoreData() {
        DispatchQueue.main.sync {
            self.coreData.deleteAllNews()
        }
    }

    private func refreshView() {
        self.view?.refreshView()
    }
}

fileprivate extension NewsPresenter {
    private func sortEventsFromInternetByDay(events: [NewsResponse]) -> [NewsResponse] {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: today)
        print(todayString)
        let subArray = events.drop { event in
            event.date != todayString
        }
        return Array(subArray)
    }
    
    private func sortEventsFromCoreDataByDay(events: [NewsViewModel]) -> [NewsViewModel] {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy" //"yyyy-MM-dd" //
        let todayString = dateFormatter.string(from: today)
        print(todayString)
        let subArray = events.drop { event in
            event.date != todayString
        }
        return Array(subArray)
    }
    
    private func convertFromInternetToVM(eventsFromInternet: [NewsResponse]) -> [NewsViewModel] {
        var newsVM = [NewsViewModel]()
        let subArray = self.sortEventsFromInternetByDay(events: eventsFromInternet)
        for item in subArray {
            let newItemVM = NewsViewModel(fromInternet: item)
            newsVM.append(newItemVM)
            self.saveToCoreData (event: newItemVM)
        }
        return newsVM
    }
}

