////
////  NetworkManager.swift
////  AnimalCrossing
////
////  Created by Anastasiya Kudasheva on 10.06.2021.
////
//
import Foundation

protocol INewsNetworkManager {
    func downloadData(link: AdditionalLink, eventHandler: @escaping ([EventsFromInternet]?) -> ())
}

class NetworkManager: INewsNetworkManager  {
    static let shared = NetworkManager()
    
    let baseUrlString = "https://api.nookipedia.com/"
    
    func downloadData(link: AdditionalLink, eventHandler: @escaping ([EventsFromInternet]?) -> ()) {
        guard let request = self.makeRequest(link: link) else { return }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                error == nil,
                let httpResponse = response as? HTTPURLResponse,
                let data = data
            else {
                eventHandler(nil)
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let events = try decoder.decode([EventsFromInternet].self, from: data)
                    eventHandler(events)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    private func makeRequest(link: AdditionalLink) -> URLRequest? {
        let urlString = self.baseUrlString + link.rawValue
        
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("4b7f967d-6e89-4362-928c-884182c96aaf", forHTTPHeaderField: "X-API-KEY")
        request.setValue("3.0.0", forHTTPHeaderField: "Accept-Version")
        return request
    }
}