//
//  MovieDetailsTableViewCell.swift
//  MovieList
//
//  Created by ITRMG on 2017-20-12.
//  Copyright © 2017 Vasthimal, Deepesh : @djrecker. All rights reserved.
//

import UIKit

class MovieDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieDescription: UILabel!
    func setContents(movieDetails: Movie) {
        movieName.text = movieDetails.movieName
        rating.text = "Rating: \(String(describing: movieDetails.voteAverage))"
        movieDescription.text = movieDetails.description
        if let imageUrl = movieDetails.imageURL {
            movieImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "loading"))
        }
    }

}
