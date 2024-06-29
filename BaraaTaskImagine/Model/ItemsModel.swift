//
//  ItemsModel.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 28/06/2024.
//

import Foundation

struct ItemsModel : Codable{
    let data : [DataModel]
}

struct DataModel : Codable{
    let gif : GifModel
}

struct GifModel : Codable{
    let title : String
    let slug : String
    let alt_text : String
    let images : ImagesModel
}

struct ImagesModel : Codable{
    let original : OriginalModel
}

struct OriginalModel : Codable{
    let url : String
}
