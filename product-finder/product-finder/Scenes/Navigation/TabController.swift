//
//  TabController.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 12/04/22.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBar.barStyle = .black
        tabBar.isTranslucent = true
        tabBar.tintColor = .white
        setupVCs()
        selectedIndex = 1
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(
                for: UIViewController(),
                title: "Search",
                image: UIImage(systemName: "magnifyingglass.circle")!),
            createNavController(
                for: UIViewController(),
                title: "Home",
                image: UIImage(systemName: "house.circle")!),
            createNavController(
                for: UIViewController(),
                title: "Favorites",
                image: UIImage(systemName: "heart.circle")!)
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        //navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.tintColor = .white
        rootViewController.navigationItem.title = title
        return navController
    }
}
