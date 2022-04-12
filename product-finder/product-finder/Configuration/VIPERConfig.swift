//
//  VIPERConfig.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 12/04/22.
//

import UIKit

open class VIPERLayer {}

public protocol View: AnyObject {}
public protocol InteractorToPresenter: AnyObject {}

open class Presenter: VIPERLayer {
    public weak var _view: View?
    public var _interactor: Interactor?
    public var _router: Router?
    
    public override init() {
        super.init()
    }
}

open class Interactor: VIPERLayer {
    public weak var _toPresenter: InteractorToPresenter?
    
    public override init() {
        super.init()
    }
}

open class Router: VIPERLayer {
    public weak var _view: UIViewController?
    
    public override init() {
        super.init()
    }
}

extension UIViewController: View {
    fileprivate static var computedProperty = [String: VIPERLayer]()
    
    var _presenter: Presenter {
        get {
            let address = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIViewController.computedProperty[address] as! Presenter
        }
        
        set(newValue) {
            let address = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIViewController.computedProperty[address] = newValue
        }
    }
    
    func setup(presenter: Presenter? = nil, interactor: Interactor? = nil, router: Router? = nil) {
        if let p = presenter, let i = interactor, let r = router {
            p._view = self
            i._toPresenter = (p as! InteractorToPresenter)
            p._interactor = i
            r._view = self
            p._router = r
            self._presenter = p
        }
    }
}
