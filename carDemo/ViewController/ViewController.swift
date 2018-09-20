//
//  ViewController.swift
//  carDemo
//
//  Created by 丁健 on 2018/9/18.
//  Copyright © 2018年 丁健. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {

    @IBOutlet weak var btnMap: UIButton!
    @IBOutlet weak var btnCarList: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("https://s3-us-west-2.amazonaws.com/wunderbucket/locations.json").responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
//                    print(json["placemarks"][0])
                    print(json)
                }
            case false:
                print(response.result.error ?? "ddd")
            }
            print(response.response!)
            
//            if let data = response.data , let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data:\(utf8Text)")
//                self.tvCar.text = utf8Text
//            }
        };
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressedMap(_ sender: Any) {
        let carPositionVC = CarPositionViewController()
        carPositionVC.requestUrl = "https://s3-us-west-2.amazonaws.com/wunderbucket/locations.json"
        self.navigationController!.pushViewController(carPositionVC, animated: true)
    }
    
    @IBAction func didPressedList(_ sender: Any) {
        let carListVC = CarListViewController()
        carListVC.requestUrl = "https://s3-us-west-2.amazonaws.com/wunderbucket/locations.json"
        self.navigationController!.pushViewController(carListVC, animated: true)
    }
}

   
