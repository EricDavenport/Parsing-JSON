//
//  Bundle+ParsingJSON.swift
//  Parsing-JSON-Using-Bundle
//
//  Created by Eric Davenport on 8/3/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import Foundation

enum BundleError: Error {
  // create errors as they appear
  case invalidResource(String)
  case noContents(String)
  case decodingError(Error)
}

extension Bundle {
  // extension on Bundle class
  
  // 1. Get the (path) of th efile to be read using Bundle class => String
  // 2. Using the oath read it's data contents => Data?
  
  // Bundle.main is a singleton
  
  // parseJSON will be a throwing function
  // to use throwing function you have to use try? od do{}catch{} or try!
  func parseJSON(with name: String) throws -> [President] {
    
    guard let path = Bundle.main.path(forResource: name, ofType: ".json") else {
      throw BundleError.invalidResource(name)
    }
    
    guard let data = FileManager.default.contents(atPath: path) else {
      throw BundleError.noContents(path)
    }
    
    // needed to return array of presidents
    var presidents: [President]
    
    do {
      presidents = try JSONDecoder().decode([President].self, from: data)
    } catch {
      throw BundleError.decodingError(error)
    }
    
    return presidents
  }
  
}
