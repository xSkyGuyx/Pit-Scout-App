//
//  TodoTableViewController.swift
//  Todo
//
//  Created by Brian Advent on 08.12.17.
//  Copyright © 2017 Brian Advent. All rights reserved.
//

import UIKit
import MultipeerConnectivity
var rowPressed = 0
var robotWeightArray = Array(repeating: "", count: teamNumbersArray.count)
var robotWidthArray = Array(repeating: "", count: teamNumbersArray.count)
var robotLengthArray = Array(repeating: "", count: teamNumbersArray.count)
var dtMotorCountArray = Array(repeating: "", count: teamNumbersArray.count)
var dtMotorTypeArray = Array(repeating: "", count: teamNumbersArray.count)
var wheelDiameterArray = Array(repeating: "", count: teamNumbersArray.count)
var wheelTypeArray = Array(repeating: "", count: teamNumbersArray.count)
var driveTypeArray = Array(repeating: "", count: teamNumbersArray.count)
var programmingLanguageArray = Array(repeating: "", count: teamNumbersArray.count)
var peerID: MCPeerID!
var mcSession: MCSession!
var mcAdvertiserAssistant: MCAdvertiserAssistant!
var messageToSend: String!
class TodoTableViewController: UITableViewController, TodoCellDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate, HomeModelProtocol {
    var feedItems: NSArray = NSArray()

    func itemsDownloaded(items: NSArray) {
        feedItems = items
        print("re\(feedItems)")
    }
    


    var todoItems:[TodoItem]!
    

    override func viewDidLoad() {
                super.viewDidLoad()
                let homeModel = HomeModel()
                homeModel.delegate = self
                homeModel.downloadItems()
                // Do any additional setup after loading the view.
                print("viewDidLoad: \(self)")
        //        print(teamNums)
                var count = 0
                print("Did Load: \(teamNumbersArray)")
                loadData()
                print("data loaded")
                peerID = MCPeerID(displayName: UIDevice.current.name)
                mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
                mcSession.delegate = self
                print("Team Num Array: \(teamNumbersArray)")
        
        
    }
    
    func loadData(){
        todoItems = [TodoItem]()
//        todoItems = DataManager.loadAll(TodoItem.self).sorted(by: {$0.createdAt < $1.createdAt})
        self.tableView.reloadData()
    }
    
    @IBAction func deleteAllPressed(_ sender: Any) {
        todoItems.removeAll()
        self.tableView.reloadData()

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("row: \(indexPath.row)")
        rowPressed = indexPath.row
    }
    
    @IBAction func addTodo(_ sender: Any) {
                
                title="6969"
                print("addTodo")
                var count = 0
                print(teamNumbersArray)
                while(count < teamNumbersArray.count){
                    title = teamNumbersArray[count]
                    let newTodo = TodoItem(title: title!, completed: false, createdAt: Date(), itemIdentifier: UUID())
                    newTodo.saveItem()
                    self.todoItems.append(newTodo)
                    
                    let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0), section: 0)
                    
                    self.tableView.insertRows(at: [indexPath], with: .automatic)
                    count += 1
                }
        //        print("reeeee \(teamNumbersArray)")
        //        while count < teamNumbersArray.count{
        //            title = teamNumbersArray[count]
        //            addTodo(Any.self)
        //            count += 1
        //        }
        //
        //        let addAlert = UIAlertController(title: "New Todo", message: "Enter a title", preferredStyle: .alert)
        //        addAlert.addTextField { (textfield:UITextField) in
        //            textfield.placeholder = "ToDo Item Title"
        //        }
                
        //        addAlert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (action:UIAlertAction) in
        //            guard let title = addAlert.textFields?.first?.text else {return}
                
                let newTodo = TodoItem(title: title!, completed: false, createdAt: Date(), itemIdentifier: UUID())
                    newTodo.saveItem()
                    self.todoItems.append(newTodo)
                    
                    let indexPath = IndexPath(row: self.tableView.numberOfRows(inSection: 0), section: 0)
                    
                    self.tableView.insertRows(at: [indexPath], with: .automatic)
                
                
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(todoItems == nil){
            return 1
        }
        return todoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TodoTableViewCell

        let todoItem = todoItems[indexPath.row]
        cell.todoLabel.text = todoItem.title
        cell.delegte = self
        
        if todoItem.completed {
            cell.todoLabel.attributedText = strikeThroughText(todoItem.title)
        }

        return cell
    }
    
    func didRequestDelete(_ cell: TodoTableViewCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            todoItems[indexPath.row].deleteItem()
            todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    func didRequestComplete(_ cell: TodoTableViewCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            var todoItem = todoItems[indexPath.row]
//            todoItem.markAsCompleted()
            cell.todoLabel.attributedText = strikeThroughText(todoItem.title)
        }
    }
    
    func didRequestShare(_ cell: TodoTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            var todoItem = todoItems[indexPath.row]
//            todoItem.markAsCompleted()
            cell.todoLabel.attributedText = NSMutableAttributedString(string: todoItem.title)
        }
//        if let indexPath = tableView.indexPath(for: cell) {
//            let todoItem = todoItems[indexPath.row]
//            sendTodo(todoItem)
//        }
    }
    
    func sendTodo (_ todoItem:TodoItem) {
        print("Kill me")
        if robotLengthArray[rowPressed].data(using: .utf8) != nil && robotWidthArray[rowPressed].data(using: .utf8) != nil && robotWeightArray[rowPressed].data(using: .utf8) != nil &&  dtMotorCountArray[rowPressed].data(using: .utf8) != nil && dtMotorTypeArray[rowPressed].data(using: .utf8) != nil && wheelDiameterArray[rowPressed].data(using: .utf8) != nil
                   && wheelTypeArray[rowPressed].data(using: .utf8) != nil &&  programmingLanguageArray[rowPressed].data(using: .utf8) != nil{
                   var robotData = robotWeightArray[rowPressed].data(using: .utf8)!
                   robotData = robotData + robotWidthArray[rowPressed].data(using: .utf8)!
                   robotData = robotData +  robotLengthArray[rowPressed].data(using: .utf8)!
                   robotData = robotData + dtMotorCountArray[rowPressed].data(using: .utf8)!
                   robotData = robotData + dtMotorTypeArray[rowPressed].data(using: .utf8)!
                   robotData = robotData + wheelDiameterArray[rowPressed].data(using: .utf8)!
                   robotData = robotData + wheelTypeArray[rowPressed].data(using: .utf8)!
                   robotData = robotData + driveTypeArray[rowPressed].data(using: .utf8)!
                   robotData = robotData + programmingLanguageArray[rowPressed].data(using: .utf8)!
            if mcSession.connectedPeers.count > 0 {
                       
                       
                           do {
                               try mcSession.send(robotData, toPeers: mcSession.connectedPeers, with: .reliable)
                           }catch{
                               fatalError("Could not send todo item")
                           }
                       
                   }else{
                       print("you are not connected to another device")
                   }
                   
                   }
       
    }
    

    func strikeThroughText (_ text:String) -> NSAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        
        return attributeString
    }
    
   
    // MARK: - Multipeer Connectivity
    
    
    @IBAction func showConnectivityActions(_ sender: Any) {
       
            let mcBrowser = MCBrowserViewController(serviceType: "ioscreator-chat", session: mcSession)
            mcBrowser.delegate = self
            self.present(mcBrowser, animated: true, completion: nil)

    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("revieced that shit")
        
       
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
   
}
