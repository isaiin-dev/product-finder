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
        tabBar.tintColor = .accentColor
        setupVCs()
        selectedIndex = 0
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(
                for: SimpleCollectionViewController(),
                title: "Product search",
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
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.accentColor]
        navController.navigationBar.tintColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .accentColor
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        rootViewController.navigationItem.title = title
        return navController
    }
}
