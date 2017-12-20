//
//  MovieListDataManager.swift
//  MovieList
//
//  Created by ITRMG on 2017-20-12.
//  Copyright © 2016 Vasthimal, Deepesh : @djrecker. All rights reserved.
//

import Foundation

class MovieListDataManager {
    private var debugMoviesList = "movies"
    private var debugCollectionData = "collection"
    static let sharedObject = MovieListDataManager()
    var movieListCache: [Movie]?
    var collectionListCache: [Movie]?
    func requestMovieList() {
        let api = MovieService()
        api.run({ (data) in
            MovieService.json = data
            NotificationCenter.default.post(name:
                Notification.Name(rawValue:
                    MovieService.MovieListRefreshedNotification), object: nil)
        }, urlString: MovieService.nowPlayingUrl)
        if MovieService.json != nil {
            self.populateData()
        }
    }
    func requestCollectionForCollectionId(collectionId: Int) {
        let api = MovieService()
        api.run({ (data) in
            MovieService.collectionJson = data
            NotificationCenter.default.post(name:
                Notification.Name(rawValue:
                    MovieService.MovieCollectionRefreshedNotification), object: nil)
        }, urlString: String(format: MovieService.movieCollectionUrl, collectionId))
        if MovieService.collectionJson != nil {
            self.populateCollectionData()
        }
    }
    func populateData() {
        let api = MovieService()
        if AppConstants.isSTUBBED {
            if let stubbedData = self.debugData(fileName: debugMoviesList) {
                self.movieListCache = api.parseMovieListData(stubbedData)
            }
        } else {
            if let jsonData = MovieService.json {
                self.movieListCache = api.parseMovieListData(jsonData)
            }
        }
    }
    func populateCollectionData() {
        let api = MovieService()
        if AppConstants.isSTUBBED {
            if let stubbedData = self.debugData(fileName: debugCollectionData) {
                self.collectionListCache = api.parseCollectionData(stubbedData)
            }
        } else {
            if let jsonData = MovieService.collectionJson {
                self.collectionListCache = api.parseCollectionData(jsonData)
            }
        }
    }
    func cachedListData() -> [Movie]? {
        if let movieListCache = movieListCache {
            return movieListCache
        }
        return nil
    }
    func cachedCollectionData() -> [Movie]? {
        if let collectionListCache = collectionListCache {
            return collectionListCache
        }
        return nil
    }
    func debugData(fileName: String) -> JSONDict? {
        if let dict = PathUtilities.findJSON(fileName) {
            return dict
        }
        return nil
    }
}
