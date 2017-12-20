//
//  Product.swift
//  MovieList
//
//  Created by ITRMG on 2017-20-12.
//  Copyright © 2016 Vasthimal, Deepesh : @djrecker. All rights reserved.
//

import Foundation

let imageUrl = "https://image.tmdb.org/t/p/w500%@"
let movieListResults = "results"
let movieCollectionPartsId = "parts"
let collectionKey = "belongs_to_collection"
let movieNameKey = "original_title"
let movieIDKey = "id"
let collectionIdKey = "id"
let posterPathKey = "poster_path"
let voteAverageKey = "vote_average"
let descriptionKey = "overview"

struct Movie {
    var movieName: String
    var movieId: Int?
    var imageURL: String?
    var posterPath: String?
    var voteAverage: Double?
    var description: String?
    var collection: Int = 0
    init(json: [String: Any], collectionId: Int?) {
        self.movieName = json[movieNameKey] as? String ?? ""
        if let collectionId = collectionId {
            self.collection = collectionId
        }
        if let movieId = json[movieIDKey] as? Int, let posterPath = json[posterPathKey] as? String,
            let voteAverage = json[voteAverageKey] as? Double,
            let description = json[descriptionKey] as? String {
            self.movieId = movieId
            self.imageURL = String(format: imageUrl, posterPath)
            self.voteAverage = voteAverage
            self.description = description
        }
    }
}
