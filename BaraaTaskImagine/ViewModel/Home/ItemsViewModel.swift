//
//  ItemsViewModel.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 28/06/2024.
//

import Foundation

typealias voidClosure = (() -> Void)

class ItemsViewModel {
    //MARK: - Properties & variables
    var itemsLoaded: voidClosure?
    var items: ItemsModel? {
        didSet {
            itemsLoaded?()
        }
    }
    private var offset = 0
    private let limit = 20
    private var isLoading = false
    private var searchQuery : String?
    
    //MARK: - Methods
    func resetOffset() {
        offset = 0
        searchQuery = nil
    }
    
    //MARK: - api calling
    func getItemsList() {
        guard !isLoading else { return }
        isLoading = true
        
        NetworkManager.getItemsRequest(offset: offset, limit: limit) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let data):
                if self.offset == 0 {
                    self.items = data
                } else {
                    self.items?.data.append(contentsOf: data.data)
                }
                self.offset += self.limit
            case .failure(let error):
                print("Error = \(error)")
            }
        }
    }
    
    func searchItems(query: String){
        guard !isLoading else {return}
        isLoading = true
        searchQuery = query
        offset = 0
        
        NetworkManager.searchItemsRequest(query: query,offset: offset, limit: limit) { [weak self] result in
            
            guard let self = self else{return}
            
            isLoading = false
            switch result{
            case .success(let data):
                self.items = data
                self.offset += self.limit
            case .failure(let error):
                print("Error = \(error)")
                
            }
        }
        
    }
    
    
}//end ItemsViewModel

    
