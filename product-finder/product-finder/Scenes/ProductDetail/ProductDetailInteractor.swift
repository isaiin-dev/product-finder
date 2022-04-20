//
//  ProductDetailInteractor.swift
//  product-finder
//
//  Created Isaiin Dev on 16/04/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  The interactor is responsible for managing data from the model layer 
//  (note that Model is not part of the VIPER architecture, feel free to 
//  implement it or not, but for sure it will make our app more concise).
//
//  This file was generated by the IsaiinDev's iOS Templates so
//  you can apply clean architecture to your iOS projects.
//

import Foundation

protocol ProductDetailBusinessLogic {

}

// MARK: - Back comunication to Presenter
protocol ProductDetailBusinessLogicDelegate: InteractorToPresenter {
 
}

class ProductDetailInteractor: Interactor, ProductDetailBusinessLogic {
    // MARK: - Properties

    lazy var presenter: ProductDetailBusinessLogicDelegate = {
		return self._toPresenter as! ProductDetailBusinessLogicDelegate
	}()

    let worker = ProductDetailWorker()

    // MARK: - BussinesLogic Implementation

}
