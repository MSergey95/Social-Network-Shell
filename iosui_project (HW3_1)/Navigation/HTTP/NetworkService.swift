//
//  NetworkService.swift
//  Navigation
//
//  Created by Сергей Минеев on 8/27/24.
//

import Foundation


struct NetworkService {

    static func request(for configuration: AppConfiguration) {
        // Получаем URL из конфигурации с помощью switch
        let url: URL
        switch configuration {
        case .planets(let planetURL):
            url = planetURL
        case .vehicles(let vehicleURL):
            url = vehicleURL
        case .starships(let starshipURL):
            url = starshipURL
        }

        // Теперь можно использовать URL для выполнения запроса
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
                print("Headers: \(response.allHeaderFields)")
            }

            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response data: \(String(describing: responseString))")
            }
        }
        task.resume()
    }
}
enum AppConfiguration {
    case planets(URL)
    case vehicles(URL)
    case starships(URL)
}
let planetsURL = URL(string: "https://swapi.dev/api/planets/")!
let vehiclesURL = URL(string: "https://swapi.dev/api/vehicles/")!
let starshipsURL = URL(string: "https://swapi.dev/api/starships/")!

let appConfiguration: AppConfiguration = .planets(planetsURL)
