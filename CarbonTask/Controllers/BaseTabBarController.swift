//
//  BaseTabBarController.swift
//  CarbonTask
//
//  Created by Decagon on 19/02/2022.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        let moviesViewController = MoviesViewController()
        let moviesSearchViewController = MoviesSearchViewController()
        
        tabBar.tintColor = AppColorsConstants.textColor
        tabBar.barTintColor = AppColorsConstants.primaryColor
        tabBar.backgroundColor = AppColorsConstants.primaryColor
        
        viewControllers = [
            createNavController(viewController: moviesViewController, title: "Home", imageName: "house"),
            createNavController(viewController: moviesSearchViewController, title: "Search", imageName: "magnifyingglass")
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.navigationBar.barTintColor = AppColorsConstants.primaryColor
        let attributes = [NSAttributedString.Key.foregroundColor:AppColorsConstants.textColor]
        navController.navigationBar.titleTextAttributes = attributes
        navController.tabBarItem.image = UIImage(systemName: imageName)
        return navController
    }
}
