//
//  TermsAndConditions.swift
//  Kite messeging
//
//  Created by Admin on 16/03/24.
//

import UIKit
import WebKit
class TermsAndConditions: UIViewController, UIWebViewDelegate {
   
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var checkBox: UIButton!
    
    @IBAction func backBtnHit(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func submitHit(_ sender: UIButton) {
        if isChecked {
               // Checkbox is checked, navigate to another page
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "NumberVC") as! NumberVC
               self.navigationController?.pushViewController(vc, animated: true)
           } else {
               // Checkbox is not checked, show an alert
               let alertController = UIAlertController(title: "Alert", message: "Please accept the terms and conditions to continue.", preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               alertController.addAction(okAction)
               self.present(alertController, animated: true, completion: nil)
           }
    }
    
    
    var isChecked: Bool = false {
        didSet {
                    let systemImageName = isChecked ? "checkmark.square" : "square"
                    let configuration = UIImage.SymbolConfiguration(pointSize: 24)
                    let image = UIImage(systemName: systemImageName, withConfiguration: configuration)
            checkBox.setImage(image, for: .normal)
                }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let htmlFileURL = Bundle.main.url(forResource: "terms-and-conditions", withExtension: "html") {
                   // Load the HTML content into the UIWebView
            webView.load(URLRequest(url: htmlFileURL))
               } else {
                   print("HTML file not found.")
               }
        
        isChecked = false
               updateCheckboxState()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkboxButtonTapped))
        checkBox.addGestureRecognizer(tapGesture)

    }
    @objc func checkboxButtonTapped() {
           // Toggle checkbox state when tapped
           isChecked.toggle()
           updateCheckboxState()
           
           // Handle checkbox tap event here
           if isChecked {
               
           } else {
               // Checkbox is unchecked
               print("Checkbox is unchecked")
               // Prevent user from moving to the next page
           }
       }
    func updateCheckboxState() {
        let imageName = isChecked ? "checkmark.square" : "square"
        checkBox.setImage(UIImage(systemName: imageName), for: .normal)

       }
}

