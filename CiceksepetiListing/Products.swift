// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

class Products: Codable {
    var name: String?
    var image: String?
    var price: Price?
    
//    init() {
//
//    }

    init(name:String, image:String, price:Price) {
        self.name = name
        self.image = image
        self.price = price
    }
    
}

class Price: Codable {
    var total: Double?
}
