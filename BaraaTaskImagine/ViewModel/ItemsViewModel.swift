//
//  ItemsViewModel.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 28/06/2024.
//

import Foundation

typealias voidClosure = (() -> Void)

class ItemsViewModel{
    
    var itemsLoaded: voidClosure?
    var items : ItemsModel?

    func getItemsList(){
        NetworkManager.getItemsRequest { [weak self] result in
            guard let self = self else{return}
            switch result{
                
            case .success(let data):
//                print("This is the data = \(data)")
                items = data
                itemsLoaded?()
            case .failure(let error ):
                print("This is the error = \(error)")
            }
        }
    }
}
