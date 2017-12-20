//
//  MovieCell.swift
//  MovieList
//
//  Created by ITRMG on 2017-20-12.
//  Copyright © 2016 Vasthimal, Deepesh : @djrecker. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var favButtonSelected: UIButton!
    @IBAction func favBtnTapped(_ sender: AnyObject) {
        if sender.tag == favButtonSelected.tag {
            if favButtonSelected.isHidden == true {
                FavouriteProducts.sharedInstance.addFavourite(sender.tag)
                favButton.isHidden = true
                favButtonSelected.isHidden = false
            } else {
                FavouriteProducts.sharedInstance.removeFavourite(sender.tag)
                favButton.isHidden = false
                favButtonSelected.isHidden = true
            }
        }
    }
    func setTagForFavourite(_ productId: Int) {
        favButton.tag = Int(productId)
        favButtonSelected.tag = Int(productId)
    }
    func setFavouriteImage(_ products: [Movie], index: Int) {
        guard let productId = products[index].movieId else { return }
        setTagForFavourite(productId)
        if FavouriteProducts.sharedInstance.products.count == 0 {
            return
        }
        if FavouriteProducts.sharedInstance.products.contains(favButton.tag) {
            favButton.isHidden = true
            favButtonSelected.isHidden = false
        } else {
            favButton.isHidden = false
            favButtonSelected.isHidden = true
        }
    }
}
