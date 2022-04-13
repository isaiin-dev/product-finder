//
//  UIImageView.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 13/04/22.
//

import UIKit
import ShimmerSwift

extension UIImageView {
    func load(url: URL, id: String, shimmeringView: ShimmeringView?) {
        MovieImageCDManager.shared.getImage(by: id) { image in
            if let savedImage = image {
                if let shimmeringView = shimmeringView {
                    shimmeringView.isShimmering = false
                }
                self.image = savedImage
            } else {
                DispatchQueue.global(qos: .background).async {
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                if let shimmeringView = shimmeringView {
                                    shimmeringView.isShimmering = false
                                }
                                self.image = image
                                MovieImageCDManager.shared.saveImage(id: id, image: image)
                            }
                        }
                    }
                }
            }
        }
    }
}
