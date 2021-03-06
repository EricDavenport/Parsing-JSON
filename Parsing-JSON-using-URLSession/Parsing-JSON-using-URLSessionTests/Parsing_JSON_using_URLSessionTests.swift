//
//  Parsing_JSON_using_URLSessionTests.swift
//  Parsing-JSON-using-URLSessionTests
//
//  Created by Eric Davenport on 8/4/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import XCTest
@testable import Parsing_JSON_using_URLSession

class Parsing_JSON_using_URLSessionTests: XCTestCase {

  func testModel() {
    // arrange
    let jsoonData = """
    {
      "data": {
        "stations": [{
            "rental_url": "http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=72",
            "station_type": "classic",
            "station_id": "72",
            "eightd_has_key_dispenser": false,
            "lat": 40.76727216,
            "eightd_station_services": [],
            "legacy_id": "72",
            "region_id": "71",
            "name": "W 52 St & 11 Ave",
            "has_kiosk": true,
            "short_name": "6926.01",
            "electric_bike_surcharge_waiver": false,
            "lon": -73.99392888,
            "capacity": 55,
            "external_id": "66db237e-0aca-11e7-82f6-3863bb44ef7c",
            "rental_methods": [
              "CREDITCARD",
              "KEY"
            ]
          },
          {
            "rental_url": "http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=79",
            "station_type": "classic",
            "station_id": "79",
            "eightd_has_key_dispenser": false,
            "lat": 40.71911552,
            "eightd_station_services": [],
            "legacy_id": "79",
            "region_id": "71",
            "name": "Franklin St & W Broadway",
            "has_kiosk": true,
            "short_name": "5430.08",
            "electric_bike_surcharge_waiver": false,
            "lon": -74.00666661,
            "capacity": 33,
            "external_id": "66db269c-0aca-11e7-82f6-3863bb44ef7c",
            "rental_methods": [
              "CREDITCARD",
              "KEY"
            ]
          }
        ]
      }
    }
    """.data(using: .utf8)!
    
    let expectedCapacity = 55
    
    do {
      let results = try JSONDecoder().decode(ResultsWrapper.self, from: jsoonData)
      let stations = results.data.stations  // [Station]
      let firstStation = stations[0]
      // assrt
      XCTAssertEqual(expectedCapacity, firstStation.capacity)   // 55 == 55
    } catch {
      XCTFail("decoding error: \(error)")
    }
  }

}
