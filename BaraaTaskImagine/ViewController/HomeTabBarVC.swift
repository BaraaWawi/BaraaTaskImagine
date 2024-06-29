//
//  HomeTabBarVC.swift
//  BaraaTaskImagine
//
//  Created by Baraa Wawi on 28/06/2024.
//

import UIKit

class HomeTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    

    
    //Configure Tab bars
    private func setupTabBar(){
        //Home Tab Bar
        let homeController = StoryboardName.mainSb.storyBoard.instantiateViewController(withIdentifier: "HomeVC")
        
        let homeNav = createNav(with: "Home", withImage: UIImage(systemName: "house.fill"), vc: homeController)
        
        let favController = StoryboardName.mainSb.storyBoard.instantiateViewController(withIdentifier: "FavouritsVC")
        
        let favNav = createNav(with: "Favourits", withImage: UIImage(systemName: "star.circle.fill"), vc: favController)
        //Favourits Tab Bar
        setViewControllers([homeNav,favNav], animated: true)
    }

    //Create Navigation
    private func createNav(with title : String , withImage image : UIImage?, vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title
        
        return nav
    }
    

}

