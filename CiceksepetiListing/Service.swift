//
//  Service.swift
//  CiceksepetiListing
//
//  Created by Berkan Korkmaz on 12.09.2022.
//

import Foundation
import Alamofire

protocol ICiceksepetiService {
    func fetchAllDatas(response: @escaping (Result?) -> Void)
}


struct CiceksepetiService: ICiceksepetiService {
    
    let BASE_URL = "https://api.ciceksepeti.com/v2/listing/ch/products?page=1&url=teraryum"
    
    func fetchAllDatas(response: @escaping (Result?) -> Void) {
        AF.request(BASE_URL).response { response in
            debugPrint(response)

        }
    }

}
