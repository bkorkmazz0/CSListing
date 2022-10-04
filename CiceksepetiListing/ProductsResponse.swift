//
//  ProductsResponse.swift
//  CiceksepetiListing
//
//  Created by Berkan Korkmaz on 13.09.2022.
//

import Foundation

class GeneralResponse:Codable {
    var result:ResultsResponse?
}

class ResultsResponse:Codable {
    var products:[Products]?
    var productCount:Int?
}
