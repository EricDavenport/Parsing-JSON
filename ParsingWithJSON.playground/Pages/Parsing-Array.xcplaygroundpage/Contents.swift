import Foundation

// Parsing Array

// JSON Data
let json = """
[
    {
        "title": "New York",
        "location_type": "City",
        "woeid": 2459115,
        "latt_long": "40.71455,-74.007118"
    },
    {
        "title": "North Carolina",
        "location_type": "City",
        "woeid": 2839401,
        "latt_long": "35.7596,-79.0193"
    }
]
""".data(using: .utf8)!

// Create model(s)

struct City: Codable {
  let title: String
  let locationType: String
  let woeid: Int
  let coordinate: String
  
  // reminder - once property names are changed - using codingKeys
  //      they must match identically to the type case
  //      THIS IS SWIFTYYYYYYY!!!!!
  //  ⬇️ properties ⬇️
  // let latt_long: String
  // let location_type: String
  
  private enum CodingKeys: String, CodingKey {
    case title, woeid
    case locationType = "location_type"
    case coordinate = "latt_long"
  }
}



//=============================================================================
//       decode JSONObjects in swift
//=============================================================================


do {
  let weatherArray = try JSONDecoder().decode([City].self, from: json)
  dump(weatherArray)
} catch {
  print("decoding error: \(error)")
}
