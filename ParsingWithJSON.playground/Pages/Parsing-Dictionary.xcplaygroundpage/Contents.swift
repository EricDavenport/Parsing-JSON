import Foundation
// Parsaing Dictionary

let json = """
          {
  "results": [
               {
                "firstName": "John",
                "lastName": "Appleseed"
               },
               {
                "firstName": "Alex",
                "lastName": "Paul"
               },
               {
                "firstName": "Eric",
                "lastName": "D."
               }
             ]
          }
""".data(using: .utf8)!

// Create Model(s)

// Codable: Decodable & Encodable
// Decodable: converts jsondata
// Encodable: converts to json data e.g POSY to a web API

struct ResultsWrapper: Codable {
  let results: [Contact]
}

struct Contact: Codable {
  let firstName: String
  let lastName: String
}

//===============================================================
//        decode the JSON data to our Swift model
//===============================================================

do {
  let dictionary = try JSONDecoder().decode(ResultsWrapper.self, from: json)
  let contacts = dictionary.results // == [Contact]
  dump(contacts)
} catch {
  print("decoding error: \(error)")
}
