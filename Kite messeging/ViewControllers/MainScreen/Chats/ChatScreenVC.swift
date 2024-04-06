//
//  ChatScreenVC.swift
//  Kite messeging
//
//  Created by Admin on 21/03/24.
//

import UIKit

class ChatScreenVC: UIViewController, UITableViewDelegate{
    
    
    
    var user: User?
    var messageDetails  = MessagesDetails()
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userSeen: UILabel!
        
    @IBOutlet weak var msgField: UITextField!
    
    @IBAction func sendButton(_ sender: UIButton) {
        guard let text = msgField.text, !text.isEmpty else {
              return
          }
          
          // Add the sender's message to the list of messages
          messageDetails.senderMsg.append(text)
          
          // Clear the text field
          msgField.text = ""
          
          // Reload the table view to display the new message
          chattingTableView.reloadData()
          
          // Scroll to the bottom of the table view to show the latest message
          scrollToBottom()
          
//          // Simulate the receiver sending a message after a delay
//          DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//              self.receiveMessage()
//          }
      }

    // Function to simulate receiving a message
    func receiveMessage() {
        let receivedMessage = "Hello, this is a reply!"
        
        // Add the received message to the list of messages
        messageDetails.senderMsg.append(receivedMessage)
        
        // Reload the table view to display the new message
        chattingTableView.reloadData()
        
        // Scroll to the bottom of the table view to show the latest message
        scrollToBottom()
    }

    // Helper function to scroll to the bottom of the table view
    // Function to scroll to the bottom of the table view
    func scrollToBottom() {
        guard !messageDetails.senderMsg.isEmpty else {
            return
        }
        
        let indexPath = IndexPath(row: messageDetails.senderMsg.count - 1, section: 0)
        chattingTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    
    
    @IBOutlet weak var chattingTableView: UITableView!
    
    @IBAction func backHit(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menuBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatMenuListVC") as! ChatMenuListVC
        vc.user = self.user // Pass the user object to ChatMenuListVC
        let navigationController_temp = UINavigationController(rootViewController: vc)
        navigationController_temp.navigationBar.isHidden = true
        navigationController_temp.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(navigationController_temp, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Update UI with user information
        if let user = user {
            userImage.image = user.image
            userName.text = user.name
            
            chattingTableView.delegate = self
            chattingTableView.dataSource = self
            // Register the XIB file for the custom cells
               let senderNib = UINib(nibName: "ChatTableCellSender", bundle: nil)
               chattingTableView.register(senderNib, forCellReuseIdentifier: "ChatTableCellSender")
               
               let receiverNib = UINib(nibName: "ChatTableCellReceiver", bundle: nil)
               chattingTableView.register(receiverNib, forCellReuseIdentifier: "ChatTableCellReceiver")
               
        }
        
    }
}
extension ChatScreenVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Assuming both sender and receiver arrays have the same count
        return messageDetails.senderMsg.count + 1 // Add 1 for the receiver cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < messageDetails.senderMsg.count {
            // Configure sender cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableCellSender", for: indexPath) as! ChatTableCellSender
            let message = messageDetails.senderMsg[indexPath.row]
            cell.msgLbl.text = message
            cell.timeLbl.text = getTimeString()
            return cell
        } else {
            if let lastReceiverMessage = messageDetails.receiverMsg?.last {
                // Configure receiver cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableCellReceiver", for: indexPath) as! ChatTableCellReceiver
                cell.chatLbl.text = String(lastReceiverMessage)
                cell.timeLbl.text = getTimeString()
                return cell
            } else {
                // If there are no receiver messages, return a blank cell
                return UITableViewCell()
            }
        }
    }


    func getTimeString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
        
    }
}


  

