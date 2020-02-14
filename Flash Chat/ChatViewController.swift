
import UIKit
import Firebase

class ChatViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
 
    
    
    // Declare instance variables here

    var messagearray :[Message] = [Message]()
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //TODO: Set yourself as the delegate of the text field here:

        messageTextfield.delegate = self
        
        //TODO: Set the tapGesture here:
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapgesture)
        

        //TODO: Register your MessageCell.xib file here:

        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configuretableview()
        
        retrieveMessage()
    }

    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    
    
    //TODO: Declare cellForRowAtIndexPath here:
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
    
        cell.messageBody.text = messagearray[indexPath.row].messagebody
        cell.senderUsername.text = messagearray[indexPath.row].sender
        return cell
    }
    
    //TODO: Declare numberOfRowsInSection here:
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagearray.count
    }
    

   
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped()
    {
        messageTextfield.endEditing(true)
    }
    
    
    //TODO: Declare configureTableView here:
func configuretableview()
{
    messageTableView.rowHeight = UITableView.automaticDimension
    messageTableView.estimatedRowHeight = 220.0
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    

    
    //TODO: Declare textFieldDidBeginEditing here:
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
        
    }
    
    //TODO: Declare textFieldDidEndEditing here:
    
 func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
                   self.heightConstraint.constant = 50
                   self.view.layoutIfNeeded()
               }
    }
    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        
        //TODO: Send the message to Firebase and save it in our database
        
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false;
        sendButton.isEnabled = false;
        let messagesdb = Database.database().reference().child("Messages")
        let messagedictionary = ["Sender": Auth.auth().currentUser!.email,"MessageBody": messageTextfield.text!]
        messagesdb.childByAutoId().setValue(messagedictionary)
        {
            (error,reference) in
            
            if error != nil{
                print(error!)
            }
            else
            {
                print("message saved successfully")
               
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }
        
        
    }
    
    //TODO: Create the retrieveMessages method here:
    
    func retrieveMessage()
    {
        let messagedb = Database.database().reference().child("Messages")
        messagedb.observe(.childAdded, with: { (snapshot) in
            let snapshotvalue =   snapshot.value as! Dictionary<String,String>
                let text = snapshotvalue["MessageBody"]!
            let sender = snapshotvalue["Sender"]!
        let message = Message()
            message.messagebody = text
            message.sender = sender
            self.messagearray.append(message)
            self.configuretableview()
            self.messageTableView.reloadData()
        }
        )
    }

    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        do
        {
            
        try Auth.auth().signOut()
        
        navigationController!.popToRootViewController(animated: true)
        
        }
        catch{
            print("error: there was a problem logging out")
        }
    }
    


}
