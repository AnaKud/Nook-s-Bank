//
//  NewsModel.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 11.06.2021.
//

import Foundation

class NewsResponse: Codable {
    var date: String
    var event: String
    var url: String
    init(date: String, event: String, url: String) {
        self.date = date
        self.event = event
        self.url = url
    }
}

class NewsViewModel {
    var date: String
    var event: String
    var url: String
    var type: String
    init(date: String, event: String, url: String) {
        self.date = date
        self.event = event
        self.url = url
        self.type = returnType(data: event)
    }
    
    init(fromInternet model: NewsResponse) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let internetDate = dateFormatter.date(from: model.date)
        dateFormatter.dateFormat = "dd MMM yyyy"
        self.date = dateFormatter.string(from: internetDate ?? Date())
        self.event = model.event
        self.url = model.url
        self.type = returnType(data: event)
    }
    
//    init(fromCoreData model: NewsCoreData) {
//        self.date = model.date
//        self.event = model.event
//        self.url = model.url
//        self.type = model.type
//    }
    init?(fromCoreData model: News) {
        guard let modelDate = model.date,
              let modelEvent = model.event,
              let modelUrl = model.url,
              let modelType =  model.type
        else { return nil }
        self.date = modelDate
        self.event = modelEvent
        self.url = modelUrl
        self.type = modelType
    }
}

fileprivate func returnType(data: String) -> String {
    if data.contains("Shopping") {
        return "Shopping"
    } else if data.contains("birthday") {
        return "Birthday"
    }
    return "Event"
}

class NewsFireBase {
    var date: String
    var event: String
    
    var url: String
    init(date: String, event: String, url: String) {
        self.date = date
        self.event = event
        self.url = url
    }
}
