//
//  MoviesCollectionViewCell.swift
//  CarbonTask
//
//  Created by Decagon on 18/02/2022.
//

import UIKit
import SDWebImage

class MoviesCollectionViewCell: UICollectionViewCell {
    
    static let moviewCollectionViewIdentifier = "MoviesCollectionViewCell";
    
    var movieResult: Search? {
        didSet {
            titleLabel.text = movieResult?.title
            yearOfProduction.text = movieResult?.year
            
            if let url =  movieResult?.poster {
                let moviePosterURL = URL(string: url)
                moviePosterImage.sd_setImage(with: moviePosterURL)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = UIColor(displayP3Red: 0.004, green: 0.098, blue: 0.07, alpha: 1)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let moviePosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 115).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let name = UILabel()
        name.text = "Movie Title"
        name.adjustsFontSizeToFitWidth = true
        name.textColor = .white
        return name
    }()
    
    let yearOfProduction : UILabel = {
        let name = UILabel()
        name.text = "2000"
        name.adjustsFontSizeToFitWidth = true
        name.textColor = .white
        return name
    }()
    
    let director : UILabel = {
        let name = UILabel()
        name.text = "Mr Director"
        name.adjustsFontSizeToFitWidth = true
        name.textColor = .white
        return name
    }()
    
    private func setupViews() {
        
        let movieMetaDataStackView = VerticalStackView(arrangedSubviews: [titleLabel, director, yearOfProduction])
        movieMetaDataStackView.distribution = .fillEqually
        
        
        let stackView = UIStackView(arrangedSubviews: [
            moviePosterImage,
            movieMetaDataStackView
        ])
        stackView.spacing = 10
        
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
}
