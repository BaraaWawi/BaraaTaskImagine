//
//  FavoritsManagerDB.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 29/06/2024.
//

import Foundation
import RealmSwift

class FavoritesManagerDB {
    static let shared = FavoritesManagerDB()
    private let realm = try! Realm()

    private init() {}

    func saveToFavorites(item: DataModel) {
        let itemObject = ItemListRM(item: item)
        try! realm.write {
            realm.add(itemObject, update: .modified)
        }
    }

    func getFavorites() -> [DataModel] {
        let itemObjects = realm.objects(ItemListRM.self)
        return itemObjects.map { $0.toItem() }
    }

    func removeFromFavorites(item: DataModel) {
        if let itemObject = realm.object(ofType: ItemListRM.self, forPrimaryKey: item.id) {
            try! realm.write {
                realm.delete(itemObject)
            }
        }
    }

    func isFavorite(item: DataModel) -> Bool {
        return realm.object(ofType: ItemListRM.self, forPrimaryKey: item.id) != nil
    }
}
