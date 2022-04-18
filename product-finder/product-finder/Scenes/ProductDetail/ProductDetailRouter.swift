//
//  ProductDetailRouter.swift
//  product-finder
//
//  Created Isaiin Dev on 16/04/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This layer is responsible for handling navigation logic: Pushing, 
//  Popping, Presenting UIViewControllers.
//
//  This file was generated by the IsaiinDev's iOS Templates so
//  you can apply clean architecture to your iOS projects.
//

import UIKit

protocol ProductDetailRoutingLogic {
  func routeToSomewhere()
}

class ProductDetailRouter: Router, ProductDetailRoutingLogic {
  lazy var view: ProductDetailViewController = {
      return self._view as! ProductDetailViewController
  }()

  func routeToSomewhere() {
        
  }
}
