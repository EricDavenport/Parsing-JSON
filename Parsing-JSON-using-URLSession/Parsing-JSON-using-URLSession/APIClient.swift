//
//  APIClient.swift
//  Parsing-JSON-using-URLSession
//
//  Created by Eric Davenport on 8/4/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation
import Combine

// TODO: convert to a generic APIClient<Station>()
// conform APIClient to Decodable

enum APIError: Error {
  case badURL(String)  // first case is badURL - capture string with it
  case networkError(Error)
  case decodingError(Error)
}

class APIClient {
  
  // the fetchData() method does an asynchronus network call
  //      this means the method returns (BEFORE) the request is complete
  
  // when dealing with asynchronus calls we use a closire,
  //      other mechanisms you can use include: delegation, NotificationCenter,
  //      newer to iOS developers as of iOS 13 (Combine)
  
  // closures capture values, it's a reference type
  
  func fetchData(completion: @escaping (Result<[Station], APIError>) -> () ) {
    let endpoint =  "https://gbfs.citibikenyc.com/gbfs/en/station_information.json"
    
    // case if someone searches with a space character
    //  "prospect park".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    
    // 1. we need URL to create our Network Request
    guard let url = URL(string: endpoint) else {
      // return is not enough - this where you create enum to catch different cases of errors
      completion(.failure(.badURL(endpoint)))
      return
    }
    
    // 2. create a Get request, pther request examples, POST, DELETE, PATCH, PUT
    let request = URLRequest(url: url)
    
    // request.httpMethod = "GET"
    // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // 3. use URLSession to make Network Request
    // URLession is a singleton
    // this is sufficient to use for making most request
    // using URLSession without the shared instance gives you access to adding necessary configuration
    //      to your task
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        completion(.failure(.networkError(error)))
      }
      
      if let data = data {
        // 4. decode the JSON to our swift model
        do {
          let results = try JSONDecoder().decode(ResultsWrapper.self, from: data)
          completion(.success(results.data.stations))
        } catch {
          completion(.failure(.decodingError(error)))
          
        }
      }
    }
    dataTask.resume()
  }
  
  // combine api fetchData
  // Combine works with ppublishers and subscribers
  // publishers are values emitted over time
  // subscribers recieve values and can perform on those values
  // some operations that can be performed are map, filter, sort....
  
  // MARK: COMBINE
//  func fetchDataUsingCombine() throws -> AnyPublisher<[Station], APIError> {
//    let endpoint =  "https://gbfs.citibikenyc.com/gbfs/en/station_information.json"
//    guard let url = URL(string: endpoint) else {
//      throw APIError.badURL(endpoint)
//    }
//    do {
//    URLSession.shared.dataTaskPublisher(for: url)
//      .map(\.data)  // data, response, error
//      .decode(type: ResultsWrapper.self, decoder: JSONDecoder())  //  ResultsWrspper
//      .map { $0.data.stations }
//    .eraseToAnyPublisher()
//    } catch {
//
//    }
//  }
  
  
}
