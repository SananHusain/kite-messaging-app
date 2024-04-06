//
//  CallHomeVC.swift
//  Kite messeging
//
//  Created by Admin on 19/03/24.
//

import UIKit

struct CallData {
    let UImage: UIImage? // corrected from 'image' to 'userImage'
    let UName: String
    let CTime: String
    let CIcon: UIImage?
    let CDirection : UIImage?
    // Add more properties as needed
}
class CallHomeVC: UIViewController {
 

    @IBOutlet weak var callTableView: UITableView!
    
    @IBAction func menuBtnHit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PersonalMenuVC") as! PersonalMenuVC
        let navigationController_temp = UINavigationController(rootViewController: vc)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
    }
    
    
    
    let callDataArray: [CallData] = [
        CallData(UImage: UIImage(named: "user1"), UName: "John Doe", CTime: "10:00 AM", CIcon: UIImage(named: "Acall"), CDirection: UIImage(named: "missedcall")),
        CallData(UImage: UIImage(named: "user2"), UName: "Jane Smith", CTime: "11:30 AM", CIcon: UIImage(named: "Acall"), CDirection: UIImage(named: "outgoing")),
        CallData(UImage: UIImage(named: "user3"), UName: "Alice Johnson", CTime: "12:15 PM", CIcon: UIImage(named: "Vcall"), CDirection: UIImage(named: "missedcall")),
        CallData(UImage: UIImage(named: "user5"), UName: "Emma Wilson", CTime: "2:30 PM", CIcon: UIImage(named: "Vcall"), CDirection: UIImage(named: "outgoing")),
        CallData(UImage: UIImage(named: "user6"), UName: "Michael Taylor", CTime: "3:45 PM", CIcon: UIImage(named: "Acall"), CDirection: UIImage(named: "missedcall")),
        CallData(UImage: UIImage(named: "user1"), UName: "Oliver Garcia", CTime: "5:10 PM", CIcon: UIImage(named: "Acall"), CDirection: UIImage(named: "outgoing")),
        CallData(UImage: UIImage(named: "user6"), UName: "Michael Taylor", CTime: "3:45 PM", CIcon: UIImage(named: "Acall"), CDirection: UIImage(named: "missedcall")),
        CallData(UImage: UIImage(named: "user6"), UName: "Michael Taylor", CTime: "3:45 PM", CIcon: UIImage(named: "Acall"), CDirection: UIImage(named: "missedcall"))
        // Add more users as needed
    ]

    
    
    override func viewDidLoad() {
          super.viewDidLoad()
          
          // Register the XIB file for the custom cell
          let nib = UINib(nibName: "CallListCell", bundle: nil)
          callTableView.register(nib, forCellReuseIdentifier: "CallListCell")
          
          // Set the table view's data source and delegate
          callTableView.dataSource = self
          callTableView.delegate = self
        
      }
}

extension CallHomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CallListCell", for: indexPath) as! CallListCell
        
        let callData = callDataArray[indexPath.row]
        cell.delegate = self
        // Configure the cell with call data
        cell.userImage.image = callData.UImage
        cell.userName.text = callData.UName
        cell.callTime.text = callData.CTime
        cell.callIcon.setBackgroundImage(callData.CIcon, for: .normal)
        cell.callArrow.image = callData.CDirection // Set call direction
        
        return cell
    }
 

}
extension CallHomeVC: CallListCellDelegate {
    func didTapCallIcon(in cell: CallListCell) {
        guard let indexPath = callTableView.indexPath(for: cell) else { return }
        let selectedCallData = callDataArray[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CallScreenVC") as! CallScreenVC
        vc.selectedCallData = selectedCallData // Pass the selected call data
        vc.hidesBottomBarWhenPushed = true // Hide the tab bar for this view controller
        navigationController?.pushViewController(vc, animated: true)
    }
}


