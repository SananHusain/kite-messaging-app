//
//  SettingVC.swift
//  Kite messeging
//
//  Created by Admin on 20/03/24.
//

import UIKit

class SettingVC: UIViewController {


    
    @IBOutlet weak var settingTableView: UITableView!
    
    @IBAction func backHit(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.dataSource = self
        settingTableView.delegate = self
       
    }
}
extension SettingVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 // Assuming you have 2 rows in your table view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableCell", for: indexPath) as! SettingTableCell
        
        switch indexPath.row {
        case 0:
        // Configure cell for the first row
        cell.icon.image = UIImage(named: "passwordLock") // Set the icon image
        cell.name.text = "Security (Passcode)" // Set the name
        // Configure the switch based on your requirements
        cell.switch.isOn = MyDetails.shared.passcodeEnabled // Example: Set the switch to the state stored in your model
        // Add a target to the switch to detect changes in its state
        cell.switch.addTarget(self, action: #selector(passcodeSwitchValueChanged(_:)), for: .valueChanged)
        case 1:
            // Configure cell for the second row
            cell.icon.image = UIImage(named: "Ai Assistant") // Set the icon image
            cell.name.text = "AI assistance" // Set the name
            // Configure the switch based on your requirements
            cell.switch.isOn = false // Example: Set the switch to OFF
        default:
            break
        }
        
        return cell
    }
    @objc func passcodeSwitchValueChanged(_ sender: UISwitch) {
            if sender.isOn {
                // If the passcode switch is turned on, navigate to the passcode setup page
                let passcodeVC = storyboard?.instantiateViewController(withIdentifier: "PassCodeVC") as! PassCodeVC
                navigationController?.pushViewController(passcodeVC, animated: true)
            }
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60 // Set the desired row height here
        }
}
