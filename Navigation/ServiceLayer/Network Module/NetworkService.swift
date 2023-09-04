//
//  NetworkService.swift
//  Navigation
//
//  Created by Ольга Бойко on 02.06.2023.
//

import Foundation

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        let urlSession = URLSession(configuration: .default)
        
        if let url = URL(string: configuration.rawValue) {
            let dataTask = urlSession.dataTask(with: url) { data, response, error in
                if let getData = data {
                    print(String(data: getData, encoding: .utf8)!)
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print("We got a response!")
                    print("All Header Fields : \(httpResponse.allHeaderFields)")
                    print("Status code : \(httpResponse.statusCode)")
                }
                if let error = error {
                    print("We got an error: \(error)")
                }
            }
            dataTask.resume()
            
            //Code=-1009 "The Internet connection appears to be offline."
        }
    }
}
