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
    let baseUrlString = "https://api.nookipedia.com/"
    
   
//}
// X-API-KEY  4b7f967d-6e89-4362-928c-884182c96aaf
// - url: 'https://api.nookipedia.com/'
//extension NetworkManager: {

    
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
                    print(error)
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
    
//    
//    static func fetchData(url: String, completion: @escaping (_ courses: [Course])->()) {
//        
//        guard let url = URL(string: url) else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, _, _) in
//            
//            guard let data = data else { return }
//            
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let courses = try decoder.decode([Course].self, from: data)
//                completion(courses)
//            } catch let error {
//                print("Error serialization json", error)
//            }
//            
//        }.resume()
//    }
 
}
