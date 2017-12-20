//
//  MovieService.swift
//  MovieList
//
//  Created by ITRMG on 2017-20-12.
//  Copyright © 2016 Vasthimal, Deepesh : @djrecker. All rights reserved.
//

import Foundation

class MovieService {
    static var json: JSONDict?
    static var collectionJson: JSONDict?
    static let MovieListRefreshedNotification = "MovieListRefreshed"
    static let MovieDetailsRefreshedNotification = "MovieDetailsRefreshed"
    static let MovieCollectionRefreshedNotification = "MovieCollectionRefreshed"
    static let ApiKey = "b2afc15aace1dce3f6c97fd8e4cfd736"
    static let nowPlayingUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(ApiKey)&language=en-US&page=1"
    static let movieDetailsUrl = "https://api.themoviedb.org/3/movie/%d?api_key=\(ApiKey)&language=en-US"
    static let movieCollectionUrl = "https://api.themoviedb.org/3/collection/%d?api_key=\(ApiKey)&language=en-US"
    var movies = [Movie]()
    func run(_ completion: ((JSONDict) -> Void)!, urlString: String) {
        let session = URLSession.shared
        guard let urlString = URL(string: urlString) else { return }
        let task = session.dataTask(with: urlString,
                                        completionHandler: { (data, _, _)
                                            -> Void in do {
                                                guard let data = data else { return }
                                                let JSON = try JSONSerialization.jsonObject(with:
                                                    data, options: JSONSerialization.ReadingOptions(rawValue: 0))
                                                guard let JSONDictionary: JSONDict = JSON as? JSONDict else {
                                                    print("Not a Dictionary")
                                                    return
                                                }
                                                completion(JSONDictionary)
                                            } catch let JSONError as NSError {
                                                print("\(JSONError)")
                                            }
            })
            task.resume()
    }
    func parseMovieListData(_ jsonData: JSONDict) -> [Movie]? {
        if let debugData = jsonData[movieListResults] as? NSArray {
            for item in debugData {
                guard let movieListJsonDict = item as? JSONDict else { return [Movie]() }
                let movie = Movie(json: movieListJsonDict, collectionId: nil)
                movies.append(movie)
            }
        }
        return movies
    }
    func parseCollectionData(_ jsonData: JSONDict) -> [Movie]? {
        if let debugData = jsonData[movieCollectionPartsId] as? NSArray {
            for item in debugData {
                guard let movieJsonDict = item as? JSONDict else { return [Movie]() }
                if movieJsonDict[movieIDKey] as? Int != MovieDetailsDataManager.sharedObject.cachedData()?.movieId {
                    let movie = Movie(json: movieJsonDict, collectionId: nil)
                    movies.append(movie)
                }
            }
        }
        return movies
    }
    func parseMovieDetails(_ jsonData: JSONDict) -> [Movie]? {
        if let debugData = jsonData[collectionKey] as? NSArray {
            for item in debugData {
                guard let movieDetailsJsonDict = item as? JSONDict else { return [Movie]() }
                let movie = Movie(json: movieDetailsJsonDict, collectionId: nil)
                movies.append(movie)
            }
        }
        return movies
    }
}
