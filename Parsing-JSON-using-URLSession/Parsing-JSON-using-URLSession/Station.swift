//
//  Station.swift
//  Parsing-JSON-using-URLSession
//
//  Created by Eric Davenport on 8/4/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation

// review Float vs. Double, a Double holds more floating point valies than a float

// Top Level
struct ResultsWrapper: Decodable {
  let data: StationsWrapper
}

struct StationsWrapper: Decodable {
  let stations: [Station]
}

struct Station: Decodable, Hashable {
  let name: String
  let stationType: String
  let latitude: Double
  let longitude: Double
  let capacity: Int
  
  private enum CodingKeys: String, CodingKey {
    case name, capacity
    case stationType = "station_type"
    case latitude = "lat"
    case longitude = "lon"
    
  }
}
