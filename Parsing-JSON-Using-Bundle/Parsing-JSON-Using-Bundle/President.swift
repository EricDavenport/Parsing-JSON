//
//  President.swift
//  Parsing-JSON-Using-Bundle
//
//  Created by Eric Davenport on 8/3/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation

struct President: Decodable {  // Decodable for JSONDecoder
  
  let number: Int
  let name: String   // President.president - wouldn't work  "president"
  let birthYear: Int
  let deathYear: Int
  let tookOffice: String
  let leftOffice: String
  let party: String
  
  private enum CodingKeys: String, CodingKey {
    case number, party
    case name = "president"
    case birthYear = "birth_year"
    case deathYear = "death_year"
    case tookOffice = "took_office"
    case leftOffice = "left_office"
  }
}
