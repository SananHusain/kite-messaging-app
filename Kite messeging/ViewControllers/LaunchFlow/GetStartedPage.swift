//
//  GetStartedPage.swift
//  Kite messeging
//
//  Created by Admin on 16/03/24.
//

import UIKit

class GetStartedPage: UIViewController {

    @IBOutlet weak var getStarted: UIButton!
    
    
    @IBAction func getStartedHit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NumberVC") as! NumberVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStarted.layer.cornerRadius = 10
       
    }
    
}
