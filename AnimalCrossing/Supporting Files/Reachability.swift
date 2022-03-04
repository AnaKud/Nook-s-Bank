// Reachability.swift
// Created by Anastasiya Kudasheva on 04.01.2022.

import Foundation

public class Reachability {
	func isConnectedToNetwork(completion: @escaping (Bool) -> Void) {
		self.googleReachability(completion: completion)
	}
}

private extension Reachability {
	func googleReachability(completion: @escaping (Bool) -> Void) {
		guard let url = URL(string: "https://google.com/") else { return completion(false) }
			  let request = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: request) { _, response, error in
			if error == nil,
			   let httpResponse = response as? HTTPURLResponse,
			   httpResponse.statusCode == 200 {
				completion(true)
			} else {
				completion(false)
			}
		}
		task.resume()
	}
}
