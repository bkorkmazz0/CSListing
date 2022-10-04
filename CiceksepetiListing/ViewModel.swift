//
//  ViewModel.swift
//  CiceksepetiListing
//
//  Created by Berkan Korkmaz on 12.09.2022.
//

import Foundation

protocol ICiceksepetiViewModel {
    func fetchItems()

    var ciceksepetiItems: [Result] { get set }
    var ciceksepetiService: ICiceksepetiService { get }

    var ciceksepetiOutput: CiceksepetiOutPut? { get }

    func setDelegate(output: CiceksepetiOutPut)
}


final class CiceksepetiViewModel: ICiceksepetiViewModel {

    
    var ciceksepetiOutput: CiceksepetiOutPut?
    
    func setDelegate(output: CiceksepetiOutPut) {
        ciceksepetiItems = [Result];output
    }
    

    var ciceksepetiItems: [Result] = []
    private var isLoading = false
    let ciceksepetiService: ICiceksepetiService


    init() {
        ciceksepetiService = CiceksepetiService()
    }

    func fetchItems() {
        ciceksepetiService.fetchAllDatas { [weak self] (response) in
            self?.ciceksepetiItems = response ?? []
            self?.ciceksepetiOutput?.saveDatas(values: self?.ciceksepetiItems ?? [])
        }
    }

}
