//
//  FormViewController.swift
//  Todo
//
//  Created by Skyhlar Myers on 2/2/20.
//

import UIKit
import MultipeerConnectivity
var teamNumber = 0
var teamName = ""
var sentData: [String] = []
var storedMatches: [String] = []
class FormViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate {

    @IBOutlet weak var generateQRButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var robotWeightBox: UITextField!
    @IBOutlet weak var robotWidthBox: UITextField!
    @IBOutlet var robotLengthBox: UIView!
    @IBOutlet weak var robotLengthBoxes: UITextField!
    @IBOutlet weak var teamNumLabel: UILabel!
    @IBOutlet weak var numOfDTMotors: UITextField!
    @IBOutlet weak var wheelDiameterSelect: UISegmentedControl!
    @IBOutlet weak var dtMotorTypeSelect: UISegmentedControl!
    @IBOutlet weak var driveTypeSelect: UISegmentedControl!
    @IBOutlet weak var wheelTypeSelect: UISegmentedControl!
    @IBOutlet weak var programmingLanguageSelect: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
                     mcSession.delegate = self
        peerID = MCPeerID(displayName: "Pit Scout App")
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "ioscreator-chat", discoveryInfo: nil, session: mcSession)
                       mcAdvertiserAssistant.start()
        teamName = teamNamesArray[rowPressed]
        teamNumber = Int(teamNumbersArray[rowPressed])!
        teamNumLabel.text = "\(teamNumber) -- \(teamName)"
        doneButton.isEnabled = false
        doneButton.setTitleColor(UIColor.black, for: .disabled)
        robotWeightBox.text = robotWeightArray[rowPressed]
        robotLengthBoxes.text = robotLengthArray[rowPressed]
        robotWidthBox.text = robotWidthArray[rowPressed]
        numOfDTMotors.text = dtMotorCountArray[rowPressed]
        if(dtMotorTypeArray[rowPressed] == "CIM"){
            dtMotorTypeSelect.selectedSegmentIndex = 0
        }else if(dtMotorTypeArray[rowPressed] == "MiniCIM"){
            dtMotorTypeSelect.selectedSegmentIndex = 1
        }else if(dtMotorTypeArray[rowPressed] == "NEO"){
            dtMotorTypeSelect.selectedSegmentIndex = 2
        }else if(dtMotorTypeArray[rowPressed] == "Falcon"){
            dtMotorTypeSelect.selectedSegmentIndex = 3
        }else if(dtMotorTypeArray[rowPressed] == "Other"){
            dtMotorTypeSelect.selectedSegmentIndex = 4
        }
        if(wheelDiameterArray[rowPressed] == "4"){
            wheelDiameterSelect.selectedSegmentIndex = 0}
        else if(wheelDiameterArray[rowPressed] == "6"){
        wheelDiameterSelect.selectedSegmentIndex = 1}
        else if(wheelDiameterArray[rowPressed] == "8"){
        wheelDiameterSelect.selectedSegmentIndex = 2}
        else if(wheelDiameterArray[rowPressed] == "Other"){
        wheelDiameterSelect.selectedSegmentIndex = 3}
        if(wheelTypeArray[rowPressed] == "Traction"){
            wheelTypeSelect.selectedSegmentIndex = 0
        }else if(wheelTypeArray[rowPressed] == "Colson"){
            wheelTypeSelect.selectedSegmentIndex = 1
        }else if(wheelTypeArray[rowPressed] == "Pnuematic"){
            wheelTypeSelect.selectedSegmentIndex = 2
        }else if(wheelTypeArray[rowPressed] == "Omni"){
            wheelTypeSelect.selectedSegmentIndex = 3
        }else if(wheelTypeArray[rowPressed] == "Other"){
            wheelTypeSelect.selectedSegmentIndex = 4
        }
        if(driveTypeArray[rowPressed] == "Tank"){
            driveTypeSelect.selectedSegmentIndex = 0
        }else if(driveTypeArray[rowPressed] == "Swerve"){
            driveTypeSelect.selectedSegmentIndex = 1
        }else if(driveTypeArray[rowPressed] == "Mecanum"){
            driveTypeSelect.selectedSegmentIndex = 2
        }else if(driveTypeArray[rowPressed] == "Tank Treads"){
            driveTypeSelect.selectedSegmentIndex = 3
        }else if(driveTypeArray[rowPressed] == "Other"){
            driveTypeSelect.selectedSegmentIndex = 4
        }
        if( programmingLanguageArray[rowPressed] == "Java"){
        programmingLanguageSelect.selectedSegmentIndex = 0
        }else if( programmingLanguageArray[rowPressed] == "C++"){
        programmingLanguageSelect.selectedSegmentIndex = 1
        }else if( programmingLanguageArray[rowPressed] == "LabView"){
        programmingLanguageSelect.selectedSegmentIndex = 2
        }else if( programmingLanguageArray[rowPressed] == "Kotlin"){
        programmingLanguageSelect.selectedSegmentIndex = 3
        }
        if robotWeightBox.text != "" && robotWidthBox.text != "" && robotLengthBoxes.text != "" && numOfDTMotors.text != "" {
            doneButton.isEnabled = true
        }else{
            doneButton.isEnabled = false
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func robotWeightChanged(_ sender: UITextField) {
        if robotWeightBox.text != "" && robotWidthBox.text != "" && robotLengthBoxes.text != "" && numOfDTMotors.text != "" {
            doneButton.isEnabled = true
        }else{
            doneButton.isEnabled = false
        }
    }
    @IBAction func robotWidthChanged(_ sender: Any) {
        if robotWeightBox.text != "" && robotWidthBox.text != "" && robotLengthBoxes.text != "" && numOfDTMotors.text != "" {
            doneButton.isEnabled = true
        }else{
            doneButton.isEnabled = false
        }
    }
    
    @IBAction func robotLengthChanged(_ sender: Any) {
    if robotWeightBox.text != "" && robotWidthBox.text != "" && robotLengthBoxes.text != "" && numOfDTMotors.text != "" {
        doneButton.isEnabled = true
    }else{
        doneButton.isEnabled = false
        }
    }
    
    @IBAction func numOfDTMotorsChanged(_ sender: Any) {
        if robotWeightBox.text != "" && robotWidthBox.text != "" && robotLengthBoxes.text != "" && numOfDTMotors.text != "" {
            doneButton.isEnabled = true
        }else{
            doneButton.isEnabled = false
        }
    }
    @IBOutlet weak var controllerPressed: UINavigationItem!
    
    @IBAction func generateQRPressed(_ sender: Any) {
        if(robotWeightBox.text != ""){
            robotWeightArray[rowPressed] = robotWeightBox.text!
            }
            if(robotWidthBox.text != ""){
            robotWidthArray[rowPressed] = robotWidthBox.text!
            }
            if(robotLengthBoxes.text != ""){
            robotLengthArray[rowPressed] = robotLengthBoxes.text!
            }
            if(numOfDTMotors.text != ""){
            dtMotorCountArray[rowPressed] = numOfDTMotors.text!
            }
            if(dtMotorTypeSelect.selectedSegmentIndex == 0){
                dtMotorTypeArray[rowPressed] = "CIM"
            }else if(dtMotorTypeSelect.selectedSegmentIndex == 1){
                dtMotorTypeArray[rowPressed] = "MiniCIM"
            }else if(dtMotorTypeSelect.selectedSegmentIndex == 2){
                dtMotorTypeArray[rowPressed] = "NEO"
            }else if(dtMotorTypeSelect.selectedSegmentIndex == 3){
                dtMotorTypeArray[rowPressed] = "Falcon"
            }else if(dtMotorTypeSelect.selectedSegmentIndex == 4){
                dtMotorTypeArray[rowPressed] = "Other"
            }
            if(wheelDiameterSelect.selectedSegmentIndex == 0){
                wheelDiameterArray[rowPressed] = "4"
        }else if(wheelDiameterSelect.selectedSegmentIndex == 1){
                wheelDiameterArray[rowPressed] = "6"
            }else if(wheelDiameterSelect.selectedSegmentIndex == 2){
                wheelDiameterArray[rowPressed] = "8"
            }else if(wheelDiameterSelect.selectedSegmentIndex == 1){
                wheelDiameterArray[rowPressed] = "Other"
            }
            if(wheelTypeSelect.selectedSegmentIndex == 0){
                wheelTypeArray[rowPressed] = "Traction"
            }else if(wheelTypeSelect.selectedSegmentIndex == 1){
                wheelTypeArray[rowPressed] = "Colson"
            }else if(wheelTypeSelect.selectedSegmentIndex == 2){
                wheelTypeArray[rowPressed] = "Pnuematic"
            }else if(wheelTypeSelect.selectedSegmentIndex == 3){
                wheelTypeArray[rowPressed] = "Omni"
            }else if(wheelTypeSelect.selectedSegmentIndex == 4){
                wheelTypeArray[rowPressed] = "Other"
            }
            if(driveTypeSelect.selectedSegmentIndex == 0){
                driveTypeArray[rowPressed] = "Tank"
            }else if(driveTypeSelect.selectedSegmentIndex == 1){
                driveTypeArray[rowPressed] = "Swerve"
            }else if(driveTypeSelect.selectedSegmentIndex == 2){
                driveTypeArray[rowPressed] = "Mecanum"
            }else if(driveTypeSelect.selectedSegmentIndex == 3){
                driveTypeArray[rowPressed] = "Tank Treads"
            }else if(driveTypeSelect.selectedSegmentIndex == 4){
                driveTypeArray[rowPressed] = "Other"
            }
            print(driveTypeArray[rowPressed])

        if(programmingLanguageSelect.selectedSegmentIndex == 0){
                programmingLanguageArray[rowPressed] = "Java"
            }else if(programmingLanguageSelect.selectedSegmentIndex == 1){
                programmingLanguageArray[rowPressed] = "C++"
            }else if(programmingLanguageSelect.selectedSegmentIndex == 2){
                programmingLanguageArray[rowPressed] = "LabView"
            }else if(programmingLanguageSelect.selectedSegmentIndex == 3){
                programmingLanguageArray[rowPressed] = "Kotlin"
            }
           
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
        if(robotWeightBox.text != ""){
        robotWeightArray[rowPressed] = robotWeightBox.text!
        }
        if(robotWidthBox.text != ""){
        robotWidthArray[rowPressed] = robotWidthBox.text!
        }
        if(robotLengthBoxes.text != ""){
        robotLengthArray[rowPressed] = robotLengthBoxes.text!
        }
        if(numOfDTMotors.text != ""){
        dtMotorCountArray[rowPressed] = numOfDTMotors.text!
        }
        if(dtMotorTypeSelect.selectedSegmentIndex == 0){
            dtMotorTypeArray[rowPressed] = "CIM"
        }else if(dtMotorTypeSelect.selectedSegmentIndex == 1){
            dtMotorTypeArray[rowPressed] = "MiniCIM"
        }else if(dtMotorTypeSelect.selectedSegmentIndex == 2){
            dtMotorTypeArray[rowPressed] = "NEO"
        }else if(dtMotorTypeSelect.selectedSegmentIndex == 3){
            dtMotorTypeArray[rowPressed] = "Falcon"
        }else if(dtMotorTypeSelect.selectedSegmentIndex == 4){
            dtMotorTypeArray[rowPressed] = "Other"
        }
        if(wheelDiameterSelect.selectedSegmentIndex == 0){
            wheelDiameterArray[rowPressed] = "4"
    }else if(wheelDiameterSelect.selectedSegmentIndex == 1){
            wheelDiameterArray[rowPressed] = "6"
        }else if(wheelDiameterSelect.selectedSegmentIndex == 2){
            wheelDiameterArray[rowPressed] = "8"
        }else if(wheelDiameterSelect.selectedSegmentIndex == 1){
            wheelDiameterArray[rowPressed] = "Other"
        }
        if(wheelTypeSelect.selectedSegmentIndex == 0){
            wheelTypeArray[rowPressed] = "Traction"
        }else if(wheelTypeSelect.selectedSegmentIndex == 1){
            wheelTypeArray[rowPressed] = "Colson"
        }else if(wheelTypeSelect.selectedSegmentIndex == 2){
            wheelTypeArray[rowPressed] = "Pnuematic"
        }else if(wheelTypeSelect.selectedSegmentIndex == 3){
            wheelTypeArray[rowPressed] = "Omni"
        }else if(wheelTypeSelect.selectedSegmentIndex == 4){
            wheelTypeArray[rowPressed] = "Other"
        }
        if(driveTypeSelect.selectedSegmentIndex == 0){
            driveTypeArray[rowPressed] = "Tank"
        }else if(driveTypeSelect.selectedSegmentIndex == 1){
            driveTypeArray[rowPressed] = "Swerve"
        }else if(driveTypeSelect.selectedSegmentIndex == 2){
            driveTypeArray[rowPressed] = "Mecanum"
        }else if(driveTypeSelect.selectedSegmentIndex == 3){
            driveTypeArray[rowPressed] = "Tank Treads"
        }else if(driveTypeSelect.selectedSegmentIndex == 4){
            driveTypeArray[rowPressed] = "Other"
        }
        print(driveTypeArray[rowPressed])

    if(programmingLanguageSelect.selectedSegmentIndex == 0){
            programmingLanguageArray[rowPressed] = "Java"
        }else if(programmingLanguageSelect.selectedSegmentIndex == 1){
            programmingLanguageArray[rowPressed] = "C++"
        }else if(programmingLanguageSelect.selectedSegmentIndex == 2){
            programmingLanguageArray[rowPressed] = "LabView"
        }else if(programmingLanguageSelect.selectedSegmentIndex == 3){
            programmingLanguageArray[rowPressed] = "Kotlin"
        }
       
        
        
    }
     @objc func showConnectionMenu() {
        let mcBrowser = MCBrowserViewController(serviceType: "ioscreator-chat", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
            sendData()
            
        }
        
        func hostSession(action: UIAlertAction) {
          mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "ioscreator-chat", discoveryInfo: nil, session: mcSession)
          mcAdvertiserAssistant.start()
        }
        
        func joinSession(action: UIAlertAction) {
          let mcBrowser = MCBrowserViewController(serviceType: "ioscreator-chat", session: mcSession)
          mcBrowser.delegate = self
          present(mcBrowser, animated: true)
        }
    @IBAction func sendDataPressed(_ sender: Any) {
        if(mcSession.connectedPeers.count>0){
            sendData()
        }
        else{
            ToastView.shared.short(self.view, txt_msg: "No Connected Persons")
        }
    }
    
        func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
          switch state {
          case .connected:
            print("Connected: \(peerID.displayName)")
          case .connecting:
            print("Connecting: \(peerID.displayName)")
          case .notConnected:
            print("Not Connected: \(peerID.displayName)")
          @unknown default:
            print("fatal error")
          }
        }
        
        func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
          DispatchQueue.main.async { [unowned self] in
            let message = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
    //        self.chatView.text = self.chatView.text + message
          }
        }
        
        func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
          
        }
        
        func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
          
        }
        
        func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
          
        }
        
        func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
          dismiss(animated: true)
        }
        
        func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
          dismiss(animated: true)
        }

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
        
        
        func sendData(){
            if(mcSession.connectedPeers.count>0){
                messageToSend = "@\(teamNumbersArray[rowPressed])|\(teamNamesArray[rowPressed])|\(robotWeightArray[rowPressed])|\(robotWidthArray[rowPressed])|\(robotLengthArray[rowPressed])|\(dtMotorCountArray[rowPressed])|\(dtMotorTypeArray[rowPressed])|\(wheelDiameterArray[rowPressed])|\(wheelTypeArray[rowPressed])|\(driveTypeArray[rowPressed])|\(programmingLanguageArray[rowPressed])|"
                let message = messageToSend.data(using: String.Encoding.utf8, allowLossyConversion: false)
                
                do {
                  try mcSession.send(message!, toPeers: mcSession.connectedPeers, with: .unreliable)
    //                sentData[rowPressed] = messageToSend
                }
                catch {
                  print("Error sending message")
                }
            }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
