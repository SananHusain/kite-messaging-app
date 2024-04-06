//
//  TabBarVC.swift
//  Kite messeging
//
//  Created by Admin on 18/03/24.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
           super.viewDidLoad()
           
           // Increase font size of tab bar titles
           let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
           UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
           
           // Add custom indicator view
           let indicatorWidth = tabBar.frame.width / CGFloat(viewControllers?.count ?? 1)
           let indicatorHeight: CGFloat = 4
           let indicatorView = UIView(frame: CGRect(x: 0, y: tabBar.frame.height - indicatorHeight, width: indicatorWidth, height: indicatorHeight))
           indicatorView.backgroundColor = .green
           tabBar.addSubview(indicatorView)
           
           // Initially position indicator view below the first tab
           indicatorView.frame.origin.x = 0
           
           // Offset the indicator view to position it slightly above the text
           let yOffset: CGFloat = -35
           indicatorView.frame.origin.y += yOffset
           
           // Listen for tab changes
           delegate = self
       }
   }

   extension TabBarVC : UITabBarControllerDelegate {
       
       func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
           // Move indicator view to the selected tab
           let index = tabBarController.selectedIndex
           let indicatorWidth = tabBar.frame.width / CGFloat(tabBarController.viewControllers?.count ?? 1)
           UIView.animate(withDuration: 0.3) {
               tabBarController.tabBar.subviews.last?.frame.origin.x = indicatorWidth * CGFloat(index)
           }
       }
   }
