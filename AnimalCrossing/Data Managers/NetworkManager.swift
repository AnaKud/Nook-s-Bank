////
////  NetworkManager.swift
////  AnimalCrossing
////
////  Created by Anastasiya Kudasheva on 10.06.2021.
////
//
import Foundation

protocol INewsNetworkManager {
    func downloadNews(link: AdditionalLink, newsHandler: @escaping ([NewsResponse]?) -> ())
}

class NetworkManager: INewsNetworkManager  {
    static let shared = NetworkManager()
    
    let baseNookipediaUrlString = "https://api.nookipedia.com/"
    
    func downloadNews(link: AdditionalLink, newsHandler: @escaping ([NewsResponse]?) -> ()) {
        guard let request = self.makeNewsRequest(link: link) else { return }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                error == nil,
                let httpResponse = response as? HTTPURLResponse,
                let data = data
            else {
                newsHandler(nil)
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let news = try decoder.decode([NewsResponse].self, from: data)
                    newsHandler(news)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    private func makeNewsRequest(link: AdditionalLink) -> URLRequest? {
        let urlString = self.baseNookipediaUrlString + link.rawValue
        
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("4b7f967d-6e89-4362-928c-884182c96aaf", forHTTPHeaderField: "X-API-KEY")
        request.setValue("3.0.0", forHTTPHeaderField: "Accept-Version")
        return request
    }
}

///https://animal-crossing-api.glitch.me/ac-turnip.com

protocol IProphetPricesNetworkManager {
    func downloadTurnip(forTurnipPrices prices: ProphetPrices.Turnip.Request, turnipHandler: @escaping (TurnipResponse) -> ())
}

extension NetworkManager: IProphetPricesNetworkManager {
    func downloadTurnip(forTurnipPrices prices: ProphetPrices.Turnip.Request, turnipHandler: @escaping (TurnipResponse) -> ()) {
        let urlString = self.makeBaseTurnipUrl(forTurnipPrices: prices)
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                error == nil,
                let httpResponse = response as? HTTPURLResponse,
                let data = data
            else { return }
            
            if httpResponse.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let turnipData = try decoder.decode(TurnipResponse.self, from: data)
                    turnipHandler(turnipData)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    
    private func makeBaseTurnipUrl(forTurnipPrices prices: ProphetPrices.Turnip.Request) -> String {
        var baseTurnipUrl = "https://api.ac-turnip.com/data/?f=\(prices.buyPrice)"
        let pricesArray = prices.pricesArray()
      
        for price in pricesArray {
                baseTurnipUrl += "-\(price ?? 0)"
        }
        return baseTurnipUrl
    }
    
}

