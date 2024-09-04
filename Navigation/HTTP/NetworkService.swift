//
//  NetworkService.swift
//  Navigation
//
//  Created by Сергей Минеев on 8/27/24.
//

import Foundation

struct NetworkService {
    
    
    static func request(url: URL) {
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
    
    
    static func urlSessionAsync(stringURL: String) async {
        do {
            guard let url = URL(string: stringURL) else { return }
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("RESPONSE STATUS: \(httpResponse.statusCode)")
                print("RESPONSE DATA: \(String(decoding: data, as: UTF8.self))")
                print("RESPONSE HEADER: \(httpResponse.allHeaderFields)")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    static func requestTodo(from url: URL, completion: @escaping (Todo?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                // Декодируем данные в структуру Todo
                let todo = try JSONDecoder().decode(Todo.self, from: data)
                completion(todo)
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    static func requestPlanet(from url: URL, completion: @escaping (Planet?) -> Void) {
          let task = URLSession.shared.dataTask(with: url) { data, response, error in
              if let error = error {
                  print("Error: \(error.localizedDescription)")
                  completion(nil)
                  return
              }

              guard let data = data else {
                  print("No data received")
                  completion(nil)
                  return
              }

              do {
                  // Декодируем данные в структуру Planet
                  let planet = try JSONDecoder().decode(Planet.self, from: data)
                  completion(planet)
              } catch {
                  print("Failed to decode JSON: \(error.localizedDescription)")
                  completion(nil)
              }
          }
          task.resume()
      }
    static func requestResident(from url: URL, completion: @escaping (Resident?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                let resident = try JSONDecoder().decode(Resident.self, from: data)
                completion(resident)
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
  }
enum AppConfiguration: String, CaseIterable {
    case people = "https://swapi.dev/api/people"
    case starships = "https://swapi.dev/api/starships"
    case planets = "https://swapi.dev/api/planets"

    var url: URL {
        URL(string: self.rawValue)!
    }
}

