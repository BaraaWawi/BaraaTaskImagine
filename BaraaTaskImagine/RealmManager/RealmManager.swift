//
//  RealmManager.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 29/06/2024.
//

import Foundation
import RealmSwift

class ItemListRM : Object{
    @objc dynamic var id : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var type : String = ""
    @objc dynamic var slug : String = ""
    @objc dynamic var alt_text : String = ""
    @objc dynamic var url : String = ""
    
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    convenience init(item: DataModel) {
        self.init()
        self.id = item.id
        self.title = item.title
        self.slug = item.slug
        self.type = item.type
        self.alt_text = item.alt_text
        self.url = item.images.original.url
    }
    
    func toItem() -> DataModel {
        return DataModel(id: id, title: title, type: type, slug: slug, alt_text: alt_text, images: ImagesModel(original: OriginalModel(url: url)))
        
        
        
    }
    
}
