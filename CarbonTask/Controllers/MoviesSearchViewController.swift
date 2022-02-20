//
//  MoviesSearchViewController.swift
//  CarbonTask
//
//  Created by Decagon on 19/02/2022.
//

import UIKit

class MoviesSearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var movies = [Search]()
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    override func viewDidLoad() {
        setupViews()
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.moviewCollectionViewIdentifier)
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.centerXInSuperview()
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 0, bottom: 0, right: 0))
        
        setupSearchbar()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "Search"
        tabBarItem.title = "Search"
        collectionView.backgroundColor = AppColorsConstants.primaryColor
    }
    
    fileprivate func setupSearchbar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = movies.count != 0
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.moviewCollectionViewIdentifier, for: indexPath) as! MoviesCollectionViewCell
        let movie = movies[indexPath.item]
        cell.movieResult = movie
        return cell
    }
    
    // CollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: 200)
    }
}

extension MoviesSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ApiManager().fetchSearchMovie(searchTerm: searchText) { [weak self] (movies, error) in
            
            if let error = error {
                print("Oops! error, fetching movies \(error.localizedDescription)")
            }
            
            self?.movies = movies?.search ?? []
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        print(searchText)
    }
    
}
