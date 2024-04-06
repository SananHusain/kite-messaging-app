

import UIKit

class NavigationHelper {
    static func popBack(_ numberOfViewControllers: Int, from navigationController: UINavigationController) {
        let viewControllers = navigationController.viewControllers
        guard viewControllers.count >= numberOfViewControllers else {
            print("Error: Insufficient view controllers to pop.")
            return
        }
        
        let indexToPopTo = max(0, viewControllers.count - numberOfViewControllers)
        navigationController.popToViewController(viewControllers[indexToPopTo], animated: true)
    }
    
    
    
}
