//
//  FavouriteProducts.swift
//  MovieList
//
//  Created by ITRMG on 2017-20-12.
//  Copyright © 2016 Vasthimal, Deepesh : @djrecker. All rights reserved.
//

import Foundation

class FavouriteProducts {
    static var sharedInstance = FavouriteProducts(favProducts: [])
    var products: [Int]
    init(favProducts: [Int]) {
        self.products = favProducts
    }
    func addFavourite(_ pid: Int) {
        products.append(pid)
    }
    func removeFavourite(_ itemToRemove: Int) {
        while products.contains(itemToRemove) {
            if let itemToRemoveIndex = products.index(of: itemToRemove) {
                products.remove(at: itemToRemoveIndex)
            }
        }
    }
}
