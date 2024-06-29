//
//  Extensions.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 29/06/2024.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIView {
    func addCornerRadius(radius : CGFloat = 8){
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func circle() {
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
    }
    
}
