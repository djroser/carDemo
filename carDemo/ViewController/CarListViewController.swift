//
//  CarListViewController.swift
//  carDemo
//
//  Created by 丁健 on 2018/9/19.
//  Copyright © 2018年 丁健. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CarListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var mainTableView: UITableView!
    var requestUrl: String?
    var dataJson: JSON?
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "CarListCell", bundle: nil)
        self.mainTableView.register(cellNib, forCellReuseIdentifier: "CarListCell")
        getCarListRequest(sUrl: "https://s3-us-west-2.amazonaws.com/wunderbucket/locations.json") 
    }
    
    
    func getCarListRequest(sUrl : String) {
        Alamofire.request(sUrl).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    self.dataJson = json
                    print(json)
                    self.mainTableView.reloadData()
                }
            case false:
                print(response.result.error ?? "ddd")
            }
            print(response.response!)
        };
    }
}


extension CarListViewController {

    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.dataJson != nil) {
            return self.dataJson!["placemarks"].count;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cardata = self.dataJson!["placemarks"][indexPath.row]
        let cell:CarListCell = tableView.dequeueReusableCell(withIdentifier: "CarListCell") as! CarListCell
        
        cell.lblName?.text = cardata["name"].string
        cell.lblAddress?.text = cardata["address"].string
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
