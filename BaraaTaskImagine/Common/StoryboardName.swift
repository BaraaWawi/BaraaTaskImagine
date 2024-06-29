//
//  StoryboardName.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 28/06/2024.
//

import UIKit

enum StoryboardName: String {
    case mainSb = "Main"
    
    var storyBoard: UIStoryboard {
        switch self{
        case .mainSb:
            return UIStoryboard(name: self.rawValue, bundle: nil)
        }
    }
}
