//
//  MovieDetailsTableViewController.swift
//  MovieList
//
//  Created by ITRMG on 2017-20-12.
//  Copyright © 2017 Vasthimal, Deepesh : @djrecker. All rights reserved.
//

import UIKit

class MovieDetailsTableViewController: UITableViewController {
    var movieDetails: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movieID = self.movieDetails?.movieId {
            MovieDetailsDataManager.sharedObject.requestMovieDetails(movieId: movieID)
        }
        NotificationCenter.default.addObserver(self, selector:
            #selector(movieDetailsRefreshed(_:)), name: NSNotification.Name(rawValue:
                MovieService.MovieDetailsRefreshedNotification), object: nil)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell", for: indexPath)
            as? MovieDetailsTableViewCell, let movieDetails = movieDetails {
            cell.setContents(movieDetails: movieDetails)
            return cell
        }
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    @objc func movieDetailsRefreshed(_ notification: Notification) {
        MovieDetailsDataManager.sharedObject.populateData()
        if let movieDetailsList = MovieDetailsDataManager.sharedObject.cachedData() {
            self.movieDetails = movieDetailsList
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
