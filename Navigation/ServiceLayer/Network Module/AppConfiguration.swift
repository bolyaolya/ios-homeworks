//
//  AppConfiguration.swift
//  Navigation
//
//  Created by Ольга Бойко on 02.06.2023.
//

import Foundation

enum AppConfiguration : String, CaseIterable {
    case first = "https://jsonplaceholder.typicode.com/todos/1"
    case second = "https://swapi.dev/api/planets/1"
}

struct SomeData {
    var data : String = ""
}

var titleText : String = ""
var orbitalPeriod : String = ""

var residents : [String] = []
var residentsNames : [String] = []

struct Planet : Codable {
    var name : String
    var rotationPeriod : String
    var orbitalPeriod : String
    var diameter : String
    var climate : String
    var gravity : String
    var terrain : String
    var surfaceWater : String
    var population : String
    var residents : [String]
    var films : [String]
    var created : String
    var edited : String
    var url : String
}

struct PlanetNetworkManager {
    
    static func request() {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let unwrappedData = data {
                    
                    do {
                        let serializedDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        
                        if let dict = serializedDictionary as? [String: Any] {
                            if let title = dict["title"] as? String {
                                titleText = title
                                print(title)
                            }
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }
        
        //Second request
        if let url = URL(string: "https://swapi.dev/api/planets/1") {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                
                if let unwrappedData = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let planet = try decoder.decode(Planet.self, from: unwrappedData)
                        orbitalPeriod = planet.orbitalPeriod
                        print(planet.orbitalPeriod)
                        
                    } catch let error {
                        print(error)
                    }
                }
            })
            task.resume()
        }
    }
}
