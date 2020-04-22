//
//  LocationModel.swift
//  connectingWithSQL
//
//  Created by Skyhlar Myers on 1/14/20.
//  Copyright © 2020 Skyhlar Myers. All rights reserved.
//

import Foundation
var teamNamesArray = [String]()
var teamNumbersArray = [String]()

class LocationModel: NSObject{
    var TeamNumber: String!
    var TeamNames: String!
    var tempTeamNumber: String!
    var tempTeamName: String!
    override init()
    {
        if TeamNumber != nil{
        tempTeamNumber = TeamNumber!
            tempTeamName = TeamNames!
            tempTeamName.removeLast(4)
            tempTeamName.removeFirst(2)
            teamNamesArray.append(tempTeamName)
            teamNumbersArray.append(tempTeamNumber)
            print("that thing: \(teamNamesArray)")
        }
        else{
            print("called")

        }
        
    }
    
    init(TeamNumber: String!, TeamNames: String!){
        
    }
    
    override var description: String{
        return "Team Number \(TeamNumber!), TeamNames \(TeamNames!)"
    }
}
