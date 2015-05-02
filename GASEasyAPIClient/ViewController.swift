//
//  ViewController.swift
//  GASEasyAPIClient
//
//  Created by YuheiMiyazato on 5/2/15.
//  Copyright (c) 2015 mitolab. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct AppConsts {
    
    struct HttpGetUrl {
        static let UserList = ""
    }
    
    struct HttpPostUrl {
        static let RegUser = ""
    }
}

class GetPostModel: NSObject {
    
    var gpModel: Dictionary<String,String> = [:]
    
    init(id: String, name: String, created: String) {
        gpModel["id"] = id
        gpModel["name"] = name
        gpModel["created"] = created
    }
    
    func getGpModel() -> Dictionary<String,String> {
        return gpModel
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var logTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getBtnTapped(sender: AnyObject) {
        getUserList()
    }

    
    @IBAction func postBtnTapped(sender: AnyObject) {
        postUser()
    }
    
    func plotLog(json: JSON?, error: NSError?, method: String) {
        var logTxt :String! = self.logTextView.text
        logTxt = logTxt + "\n - - - \(method) RESPONSE - - - \n"
        logTxt = logTxt + String(stringInterpolationSegment: json);
        logTxt = logTxt + "\n"
        logTxt = logTxt + String(stringInterpolationSegment: error);
        logTxt = logTxt + "\n"
        self.logTextView.text = logTxt
    }
    
    func getUserList() {
        
        Alamofire
        .request(.GET, AppConsts.HttpGetUrl.UserList)
        .responseJSON {(request, response, jsonObj, error) in
            let json = JSON(jsonObj!)
            println(json)
            println(error)
            self.plotLog(json, error: error, method:"GET")
        }
    }

    func postUser() {
        
        let createdDate = NSDate().description
        var users : Array<Dictionary<String,String>>! = []
        for i in 1..<5 {
            let aModel: GetPostModel =
            GetPostModel(id: String(i), name:"人造人間\(String(i))号", created: createdDate)
            users.append(aModel.getGpModel())
        }
        
        Alamofire
        .request(.POST, AppConsts.HttpPostUrl.RegUser, parameters: ["Users":users], encoding: .JSON)
        .responseJSON {(request, response, jsonObj, error) in
            let json = JSON(jsonObj!)
            println(json)
            println(error)
            self.plotLog(json, error: error, method:"POST")
        }
    }

}

