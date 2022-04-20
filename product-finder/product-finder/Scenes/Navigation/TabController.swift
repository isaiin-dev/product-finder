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
        view.backgroundColor = .white
        tabBar.barStyle = .black
        tabBar.isTranslucent = true
        tabBar.barTintColor = .white
        tabBar.tintColor = .purpureus
        setupVCs()
        selectedIndex = 0
    }
    
    func setupVCs() {
        let favoritesViewController = SimpleCollectionViewController()
        favoritesViewController.style = .Favorites
        
        let lasSearchViewController = SimpleCollectionViewController()
        lasSearchViewController.style = .LastResults
        
        viewControllers = [
            createNavController(
                for: SimpleCollectionViewController(),
                title: Constants.Content.Scenes.searchTitle,
                image: Constants.Content.Scenes.searchIcon),
            createNavController(
                for: lasSearchViewController,
                title: Constants.Content.Scenes.lastSearchTitle,
                image: Constants.Content.Scenes.lastSearchIcon),
            createNavController(
                for: favoritesViewController,
                title: Constants.Content.Scenes.favoritesTitle,
                image: Constants.Content.Scenes.favoritesIcon)
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purpureus]
        navController.navigationBar.tintColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .purpureus
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.barStyle = .black
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        rootViewController.navigationItem.title = title
        return navController
    }
}

extension UITabBarController {
    private static var _bottomSheetComputedProperty = [String:BottomSheet]()
        
    var bottomSheet: BottomSheet? {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UITabBarController._bottomSheetComputedProperty[tmpAddress]
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UITabBarController._bottomSheetComputedProperty[tmpAddress] = newValue
        }
    }
}
