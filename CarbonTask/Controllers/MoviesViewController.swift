//
//  MoviesViewController.swift
//  CarbonTask
//
//  Created by Decagon on 18/02/2022.
//

import UIKit

class MoviesViewController: UIViewController {

    private var movies = [Search]()
    
   
    
    private let moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = AppColorsConstants.primaryColor
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ApiManager().fetchFilms { [weak self] (movies, error) in
            if let error = error {
                print("Fetching data had an error \(error.localizedDescription)")
            }
            
            self?.movies = movies?.search ?? []
            DispatchQueue.main.async {
                self?.moviesCollectionView.reloadData()
            }
            print(self?.movies ?? "")
        }
        
        setupViews()
    }
    
    
    
    func setupViews() {
        navigationItem.title = "All Movies"
        view.addSubview(moviesCollectionView)
        moviesCollectionView.frame = view.bounds
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        moviesCollectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.moviewCollectionViewIdentifier)
    }
    
    

}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

