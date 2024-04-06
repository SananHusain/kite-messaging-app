//
//  ChattingVC.swift
//  Kite messeging
//
//  Created by Admin on 01/04/24.
//
struct Message {
    let msg : String
}

import UIKit

let messages : [Message] = [
    Message(msg: "Hello Dear Friend"),
    Message(msg: "How are you???"),
    Message(msg: "Hello My Friends, How are you all? I hope you all are doing well. Hello My Friends, How are you all? I hope you all are doing well"),
    Message(msg: "dsiughiognbdougen i0j ioer hiugoh giubn fijg hergubfhebgjdsnsjgnbodn ioh oi dfn jgfjeg jegip guegdfu fuia bguidfbaei gniueuf beibiugbibgigbigb")
]

class ChattingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messageDetails  = MessagesDetails()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageDetails.senderMsg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableCellSender", for: indexPath) as! ChatTableCellSender
        
        let message = messageDetails.senderMsg[indexPath.row]
        cell.msgLbl.text = message
        cell.timeLbl.text = getTimeString()
        return cell
     }
    
    func getTimeString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
        
    }
    

    @IBOutlet weak var chattingTableView: UITableView!
    @IBOutlet weak var msgField: UITextField!
    
    @IBAction func sendMessage(_ sender: UIButton) {
        guard let text = msgField.text, !text.isEmpty else{
            return
        }
        
        messageDetails.senderMsg.append(text)
        
        msgField.text = ""
        chattingTableView.reloadData()
        let indexPath = IndexPath(row: messageDetails.senderMsg.count - 1, section: 0)
        chattingTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
        // Register the XIB file for the custom cell
              let nib = UINib(nibName: "ChatTableCellSender", bundle: nil)
        chattingTableView.register(nib, forCellReuseIdentifier: "ChatTableCellSender")
    }
    
}
