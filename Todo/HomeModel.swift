//
//  HomeModel.swift
//  connectingWithSQL
//
//  Created by Skyhlar Myers on 1/14/20.
//  Copyright © 2020 Skyhlar Myers. All rights reserved.
//

import Foundation
protocol HomeModelProtocol: class{
    func itemsDownloaded(items: NSArray)
}

class HomeModel: NSObject, URLSessionDataDelegate{
    weak var delegate: HomeModelProtocol!
    var data = Data()
    
    let urlPath: String = "https://www.lhsrobotics.net/pullTeamNums.php"
    
    func downloadItems(){
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error)
            in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data downloaded")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    func parseJSON(_ data:Data){
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let location = LocationModel()
            
            if let TeamNumber = jsonElement["Team Number"] as? String,
                let TeamName = jsonElement["Team Names"] as? String
            {
                teamNumbersArray.append(TeamNumber)
                teamNamesArray.append(TeamName)
                location.TeamNumber = TeamNumber
                location.TeamNames = TeamName
            }
            locations.add(location)
        }
        DispatchQueue.main.async (execute: {()-> Void in self.delegate.itemsDownloaded(items: locations)
        })
    }
}
