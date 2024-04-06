//
//  AlertManager.swift
//  Kite messeging
//
//  Created by Admin on 20/03/24.
//

import UIKit

class AlertManager {
    
    // Shared instance for singleton pattern
    static let shared = AlertManager()
    
    // Private initializer to prevent external instantiation
    private init() {}
    
    // Show a basic alert with a title and message
    func showAlert(title: String?, message: String?, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    // Show an alert with a title, message, and custom action
    func showAlert(title: String?, message: String?, actionTitle: String, viewController: UIViewController, actionHandler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            actionHandler?()
        }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
