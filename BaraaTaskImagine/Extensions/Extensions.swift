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

    func circle() {
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
    }
    
}

extension UITableView {
    
    func setNoNoDataMessage(_ label: String) {
        
        let noNoDataLabel = UILabel()
        noNoDataLabel.text = label
        noNoDataLabel.textColor = .gray
        noNoDataLabel.textAlignment = .center
        
        let labelContainer = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: self.bounds.size.width,
                                                  height: self.bounds.size.height))
        labelContainer.addSubview(noNoDataLabel)
        
        noNoDataLabel.translatesAutoresizingMaskIntoConstraints = false
        noNoDataLabel.centerXAnchor.constraint(equalTo: labelContainer.centerXAnchor).isActive = true
        noNoDataLabel.centerYAnchor.constraint(equalTo: labelContainer.centerYAnchor).isActive = true
        
        self.backgroundView = labelContainer
        self.separatorStyle = .none
    }
    
    @objc func removeNoNoDataMessage() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }

}

extension Notification.Name{
    static let shouldUpdateItems = Notification.Name("updateItems")
}

