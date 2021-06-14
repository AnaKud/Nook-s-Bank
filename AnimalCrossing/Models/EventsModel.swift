//
//  EventsModel.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 11.06.2021.
//

import Foundation

class EventsFromInternet: Codable {
    var date: String
    var event: String
    var url: String
    init(date: String, event: String, url: String) {
        self.date = date
        self.event = event
        self.url = url
    }
}

//enum EventType: String {
//    case birthday
//    case event
//    case shopping
//}

class EventsViewModel {
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
    
    init(fromInternet model: EventsFromInternet) {
        self.date = model.date
        self.event = model.event
        self.url = model.url
        self.type = returnType(data: event)
    }
    
    init(fromCoreData model: EventsCoreData) {
        self.date = model.date
        self.event = model.event
        self.url = model.url
        self.type = model.type
    }
    init?(fromNews model: News) {
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

class EventsCoreData {
    var date: String
    var event: String
    var url: String
    var type: String
    init(fromViewModel model: EventsViewModel) {
        self.date = model.date
        self.event = model.event
        self.url = model.url
        self.type = model.type
    }
}

class EventsFireBase {
    var date: String
    var event: String
    
    var url: String
    init(date: String, event: String, url: String) {
        self.date = date
        self.event = event
        self.url = url
    }
}
