//
//  MovieListTests.swift
//  MovieListTests
//
//  Created by ITRMG on 2017-20-12.
//  Copyright © 2017 djrecker. All rights reserved.
//

import XCTest
@testable import MovieList

class MovieListTests: XCTestCase {
    var movieList = [Movie]()
    override func setUp() {
        super.setUp()
        AppConstants.isSTUBBED = true //Load Stubbed JSON data for unit test.
        MovieListDataManager.sharedObject.populateData()
    }
    func testMovieListLoaded() {
        MovieService.json = nil
        MovieListDataManager.sharedObject.requestMovieList()
        XCTAssertNil(MovieService.json, "MovieService.json is not nil")
    }
    //below is required for testing different data.
    //swiftlint:disable function_body_length
    func testParseData() {
        if let cachedData = MovieListDataManager.sharedObject.cachedListData() {
            self.movieList = cachedData
        }
        XCTAssertNotNil(MovieListDataManager.sharedObject.cachedListData(), "Cached Data is nil")
        XCTAssertEqual(self.movieList.count, 20, "movieList Count does not match")
        for (movieIndex, aMovie) in self.movieList.enumerated() {
            switch movieIndex {
            case 0:
                XCTAssertEqual(aMovie.movieName, "Coco", "Movie Name does not match")
                XCTAssertEqual(aMovie.voteAverage, 7.5, "Movie Rating does not match")
                XCTAssertEqual(aMovie.imageURL,
                               "https://image.tmdb.org/t/p/w500/eKi8dIrr8voobbaGzDpe8w0PVbC.jpg",
                               "Movie Image URL does not match")
                XCTAssertEqual(aMovie.movieId, 354912, "Movie MovieId does not match")
            case 1:
                XCTAssertEqual(aMovie.movieName, "Justice League", "Movie Name does not match")
                XCTAssertEqual(aMovie.voteAverage, 6.5999999999999996, "Movie Rating does not match")
                XCTAssertEqual(aMovie.imageURL,
                               "https://image.tmdb.org/t/p/w500/9rtrRGeRnL0JKtu9IMBWsmlmmZz.jpg",
                               "Movie Image URL does not match")
                XCTAssertEqual(aMovie.movieId, 141052, "Movie MovieId does not match")
            case 2:
                XCTAssertEqual(aMovie.movieName, "Star Wars: The Last Jedi", "Movie Name does not match")
                XCTAssertEqual(aMovie.voteAverage, 7.5, "Movie Rating does not match")
                XCTAssertEqual(aMovie.imageURL,
                               "https://image.tmdb.org/t/p/w500/xGWVjewoXnJhvxKW619cMzppJDQ.jpg",
                               "Movie Image URL does not match")
                XCTAssertEqual(aMovie.movieId, 181808, "Movie MovieId does not match")
            case 3:
                XCTAssertEqual(aMovie.movieName, "Daddy's Home 2", "Movie Name does not match")
                XCTAssertEqual(aMovie.voteAverage, 5.7000000000000002, "Movie Rating does not match")
                XCTAssertEqual(aMovie.imageURL,
                               "https://image.tmdb.org/t/p/w500/rF2IoKL0IFmumEXQFUuB8LajTYP.jpg",
                               "Movie Image URL does not match")
                XCTAssertEqual(aMovie.movieId, 419680, "Movie MovieId does not match")
            case 4:
                XCTAssertEqual(aMovie.movieName, "Murder on the Orient Express", "Movie Name does not match")
                XCTAssertEqual(aMovie.voteAverage, 6.7999999999999998, "Movie Rating does not match")
                XCTAssertEqual(aMovie.imageURL,
                               "https://image.tmdb.org/t/p/w500/iBlfxlw8qwtUS0R8YjIU7JtM6LM.jpg",
                               "Movie Image URL does not match")
                XCTAssertEqual(aMovie.movieId, 392044, "Movie MovieId does not match")
            default:
                print("do nothing")
            }
        }
    }
    func testfindJSON() {
        XCTAssertNotNil(PathUtilities.findJSON("movies"))
    }
}
