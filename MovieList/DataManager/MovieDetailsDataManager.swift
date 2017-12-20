//
//  MovieDetailsDataManager.swift
//  MovieList
//
//  Created by ITRMG on 2017-20-12.
//  Copyright © 2017 Vasthimal, Deepesh : @djrecker. All rights reserved.
//

import Foundation

class MovieDetailsDataManager {
    private var debugFileName = "movieDetails"
    static let sharedObject = MovieDetailsDataManager()
    static var json: JSONDict?
    var movieDetailsCache: Movie?
    func requestMovieDetails(movieId: Int) {
        let api = MovieService()
        api.run({ (data) in
            MovieDetailsDataManager.json = data
            NotificationCenter.default.post(name:
                Notification.Name(rawValue:
                    MovieService.MovieDetailsRefreshedNotification), object: nil)
        }, urlString: String(format: MovieService.movieDetailsUrl, movieId))
    }
    func populateData() {
        if AppConstants.isSTUBBED {
            if let stubbedData = self.debugSettings() {
                self.movieDetailsCache = self.parseMovieDetails(stubbedData)
            }
        } else {
            if let jsonData = MovieDetailsDataManager.json {
                self.movieDetailsCache = self.parseMovieDetails(jsonData)
            }
        }
    }
    func cachedData() -> Movie? {
        if let movieDetailsCache = movieDetailsCache {
            return movieDetailsCache
        }
        return nil
    }
    func debugSettings() -> JSONDict? {
        if let dict = PathUtilities.findJSON(debugFileName) {
            return dict
        }
        return nil
    }
    func isCollectionIdEmpty() -> Bool {
        return movieDetailsCache?.collection == nil
    }
    func parseMovieDetails(_ jsonData: JSONDict) -> Movie? {
        let collectionJson = jsonData[collectionKey]
        if let collectionJson = collectionJson,
            let collectionID = collectionJson[collectionIdKey] as? Int {
            return Movie(json: jsonData, collectionId: collectionID)
        }
        return Movie(json: jsonData, collectionId: nil)
    }
}
