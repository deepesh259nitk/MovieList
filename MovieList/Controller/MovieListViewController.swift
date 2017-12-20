//
//  ViewController.swift
//  MovieList
//
//  Created by ITRMG on 2017-20-12.
//  Copyright © 2016 Vasthimal, Deepesh : @djrecker. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var movieDetailsView: UIView!
    @IBOutlet weak var movieDetailsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var movieDetailsDescription: UILabel!
    @IBOutlet weak var movieDetailsRating: UILabel!
    @IBOutlet weak var movieDetailsTitle: UILabel!
    @IBOutlet weak var movieDetailsImage: UIImageView!
    fileprivate let identifier = "CellIdentifier"
    fileprivate var moviesList = [Movie]()
    var movieID: Int?
    var collectionId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        //setUpView()
        setObservers()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieId = self.moviesList[indexPath.row].movieId,
            let vc = storyboard.instantiateViewController(withIdentifier: "MoviesList") as? MovieListViewController {
            MovieDetailsDataManager.sharedObject.requestMovieDetails(movieId: movieId)
            vc.movieID = movieId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func getIndexPathForSelectedCell() -> IndexPath? {
        if let items = collectionView.indexPathsForSelectedItems {
           return items[0]
        }
        return IndexPath()
    }
    func setUpView() {
        if let movieID = self.movieID {
            movieDetailsView.isHidden = false
            movieDetailsViewHeightConstraint.constant = 180
            MovieDetailsDataManager.sharedObject.requestMovieDetails(movieId: movieID)
        } else {
            movieDetailsView.isHidden = true
            movieDetailsViewHeightConstraint.constant = 0
            MovieListDataManager.sharedObject.requestMovieList()
        }
    }
    func setObservers() {
        NotificationCenter.default.addObserver(self, selector:
            #selector(movieListRefreshed(_:)), name: NSNotification.Name(rawValue:
                MovieService.MovieListRefreshedNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(movieDetailsRefreshed(_:)), name: NSNotification.Name(rawValue:
                MovieService.MovieDetailsRefreshedNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(movieCollectionRefreshed(_:)), name: NSNotification.Name(rawValue:
                MovieService.MovieCollectionRefreshedNotification), object: nil)
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath) -> UICollectionViewCell {
        let dummyCell = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                            for: indexPath) as? MovieCell else { return dummyCell }
        let product = self.moviesList[indexPath.row]
        cell.movieName.text = product.movieName
        if let voteAverage = product.voteAverage {
            cell.rating.text = "Rating: \(voteAverage)"
        }
        if let imageUrl = product.imageURL {
            cell.imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "loading"))
        }
        cell.setFavouriteImage(self.moviesList, index: indexPath.row)
        return cell
    }
    private func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell: UICollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath)!
        cell.backgroundColor = UIColor.magenta
    }
    @objc func movieListRefreshed(_ notification: Notification) {
        MovieListDataManager.sharedObject.populateData()
        if let movieList = MovieListDataManager.sharedObject.cachedListData() {
            self.moviesList = movieList
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    @objc func movieDetailsRefreshed(_ notification: Notification) {
        MovieDetailsDataManager.sharedObject.populateData()
        DispatchQueue.main.async {
            if let movieDetails = MovieDetailsDataManager.sharedObject.cachedData(),
                let collectionId = MovieDetailsDataManager.sharedObject.movieDetailsCache?.collection {
                self.movieDetailsView.isHidden = false
                self.movieDetailsViewHeightConstraint.constant = 180
                self.setMovieDetailsLabels(movieDetails: movieDetails)
                self.collectionId = collectionId
                MovieListDataManager.sharedObject.requestCollectionForCollectionId(collectionId: collectionId)
            }
            self.movieDetailsView.setNeedsLayout()
            self.collectionView.reloadData()
        }
    }
    @objc func movieCollectionRefreshed(_ notification: Notification) {
        MovieListDataManager.sharedObject.populateCollectionData()
        DispatchQueue.main.async {
            if let collectionData = MovieListDataManager.sharedObject.cachedCollectionData() {
                self.moviesList = collectionData
            }
            self.collectionView.reloadData()
        }
    }
    func setMovieDetailsLabels(movieDetails: Movie) {
        self.movieDetailsTitle.text = movieDetails.movieName
        if let imageUrl = movieDetails.imageURL,
            let description = movieDetails.description, let rating = movieDetails.voteAverage {
            self.movieDetailsImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "loading"))
            self.movieDetailsDescription.text = description
            self.movieDetailsRating.text = "Rating: \(String(describing: rating))"
        }
    }
}
