//
//  NetworkManager.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 28/06/2024.
//

import Foundation

enum NetworkError : Error{
    case urlError
    case canNotParseData
}

class NetworkManager{
    static func getItemsRequest(offset: Int, limit: Int, completionHandler: @escaping (_ result: Result<ItemsModel, NetworkError>) -> Void) {
        let urlString = "\(NetworkConstants.trending)\(NetworkConstants.apiKey)&offset=\(offset)&limit=\(limit)"
        
        guard let url = URL(string: urlString) else{
            
            completionHandler(.failure(.urlError))
            return
        }
        print("URL = \(urlString)")
        URLSession.shared.dataTask(with: url){response , urlResponse,error in
            if error == nil , let response = response , let resultData = try? JSONDecoder().decode(ItemsModel.self, from: response){
                
                completionHandler(.success(resultData))
                
            }else{
                
                completionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
    }//end getItemsRequest
    
    static func searchItemsRequest(query: String,offset: Int ,limit: Int, completionHandler : @escaping (_ result: Result<ItemsModel,NetworkError>) -> Void){
        let urlString = "\(NetworkConstants.search)\(NetworkConstants.apiKey)&q=\(query)&offset=\(offset)&limit=\(limit)"
        
        guard let url = URL(string: urlString)else{
            completionHandler(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url){response ,urlResponse,error in
            if error == nil , let response = response , let resultData = try? JSONDecoder().decode(ItemsModel.self, from: response){
                completionHandler(.success(resultData))
            }else{
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
        
    }//end searchItemsRequest
    
}//end NetworkManager
