//
//  ChatListVC.swift
//  Kite messeging
//
//  Created by Admin on 19/03/24.
//

import UIKit

// Struct to represent a user
struct User {
    let image: UIImage?
    let name: String
    let message: String
    let time: String
    let messageCount: Int
    let phoneNumber : String
    let email : String
}

class ChatListVC: UIViewController{
   
    
    @IBAction func menuBtnHit(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PersonalMenuVC") as! PersonalMenuVC
        let navigationController_temp = UINavigationController(rootViewController: vc)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
    }
    
    @IBOutlet weak var chatTableView: UITableView!
    
    // Static data for users
    let users: [User] = [
        User(image: UIImage(named: "user1"), name: "Almayra Zamzamy", message: "We solicit your gracious presence at...!", time: "10:00 AM", messageCount: 2, phoneNumber: "1234567890", email: "almayra@example.com"),
        User(image: UIImage(named: "user2"), name: "Erlan Sadewa", message: "Hi there!", time: "11:30 AM", messageCount: 0, phoneNumber: "9876543210", email: "erlan@example.com"),
        User(image: UIImage(named: "user3"), name: "John Doe", message: "How are you?", time: "12:45 PM", messageCount: 5, phoneNumber: "5551234567", email: "john@example.com"),
        User(image: UIImage(named: "user4"), name: "Jane Smith", message: "What's up?", time: "1:30 PM", messageCount: 1, phoneNumber: "9995551234", email: "jane@example.com"),
        User(image: UIImage(named: "user5"), name: "Sarah Johnson", message: "Nice to meet you!", time: "2:15 PM", messageCount: 3, phoneNumber: "1112223333", email: "sarah@example.com"),
        User(image: UIImage(named: "user6"), name: "Michael Brown", message: "Good morning!", time: "3:00 PM", messageCount: 0, phoneNumber: "4445556666", email: "michael@example.com"),
        User(image: UIImage(named: "user7"), name: "Emily Wilson", message: "Let's catch up later.", time: "4:20 PM", messageCount: 2, phoneNumber: "7778889999", email: "emily@example.com"),
        User(image: UIImage(named: "user8"), name: "Jack Anderson", message: "Don't forget about our meeting!", time: "5:00 PM", messageCount: 4, phoneNumber: "3334445555", email: "jack@example.com"),
        User(image: UIImage(named: "user9"), name: "Rachel Taylor", message: "See you soon!", time: "6:30 PM", messageCount: 0, phoneNumber: "2223334444", email: "rachel@example.com")
    ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the XIB file for the custom cell
              let nib = UINib(nibName: "ChatListHomeVCCell", bundle: nil)
              chatTableView.register(nib, forCellReuseIdentifier: "ChatListHomeVCCell")

              // Set the table view's data source and delegate
              chatTableView.dataSource = self
              chatTableView.delegate = self
        
    }
    


}
extension ChatListVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return users.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListHomeVCCell", for: indexPath) as! ChatListHomeVCCell
           
           // Configure cell using static user data
           let user = users[indexPath.row]
           cell.userImage.image = user.image
           cell.userName.text = user.name
           cell.userMsg.text = user.message
           cell.time.text = user.time
           cell.msgBadge.isHidden = (user.messageCount == 0)
           cell.msgBadge.text = "\(user.messageCount)"
           
           return cell
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedUser = users[indexPath.row]
            navigateToChatScreen(with: selectedUser)
        }
        
    func navigateToChatScreen(with user: User) {
            guard let chatScreenVC = storyboard?.instantiateViewController(withIdentifier: "ChatScreenVC") as? ChatScreenVC else { return }
            chatScreenVC.user = user
            chatScreenVC.hidesBottomBarWhenPushed = true // Hide tab bar
            navigationController?.pushViewController(chatScreenVC, animated: true)
        }
}
