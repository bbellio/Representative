//
//  RepresentativeController.swift
//  Representative
//
//  Created by Bethany Wride on 10/2/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation

class RepresentativeController {
    // URL
    static let baseURL = URL(string: "http://whoismyrepresentative.com/getall_reps_bystate.php?")
    
    static func searchRepresentatives(by state: String, completion: @escaping ([Representative]) -> Void) {
        guard let unwrappedURL = baseURL else { return }
        let stateQuery = URLQueryItem(name: "state", value: state.lowercased())
        let jsonQuery = URLQueryItem(name: "output", value: "json")
        var urlComponents = URLComponents(url: unwrappedURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [stateQuery, jsonQuery]
        guard let finalURL = urlComponents?.url else { return }
        
        // DatatTask
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return
            }
            
            guard let data = data,
                let reworkedDataString = String(data: data, encoding: .ascii),
                let finalData = reworkedDataString.data(using: .utf8)
                else {
                print("No data")
                completion([])
                return
            }
            
            do {
                let resultsDictionary = try JSONDecoder().decode([String: [Representative]].self, from: finalData)
                let representativeArray = resultsDictionary["results"]
                completion(representativeArray ?? [])
            } catch {
                print("Error in decoding function : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return
            }
        }.resume() // End of data task
    } // End of function
} // End of class
