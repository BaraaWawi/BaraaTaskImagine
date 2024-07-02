////
////  FavoritesManager.swift
////  BaraaTaskImagine
////
////  Created by Baraa Wawi on 29/06/2024.
////
//
//import Foundation
//
//class FavoritesManager {
//    private let favoritesKey = "favorites"
//
//    static let shared = FavoritesManager()
//
//    private init() {}
//
//    func saveToFavorites(item: DataModel) {
//        var favorites = getFavorites()
//        favorites.append(item)
////        UserDefaults.standard.setValue(favorites, forKey: favoritesKey)
//        if let data = try? JSONEncoder().encode(favorites) {
//            UserDefaults.standard.set(data, forKey: favoritesKey)
//        }
//    }
//
//    func getFavorites() -> [DataModel] {
//        if let data = UserDefaults.standard.data(forKey: favoritesKey),
//           let favorites = try? JSONDecoder().decode([DataModel].self, from: data) {
//            return favorites
//        }
//        return []
//    }
//
//    func removeFromFavorites(item: DataModel) {
//        var favorites = getFavorites()
//        favorites.removeAll { $0.id == item.id }
//        if let data = try? JSONEncoder().encode(favorites) {
//            UserDefaults.standard.set(data, forKey: favoritesKey)
//        }
//    }
//
//    func  isFavorite(item: DataModel) -> Bool {
//        let favorites = getFavorites()
//        return favorites.contains { $0.id == item.id }
//    }
//}
