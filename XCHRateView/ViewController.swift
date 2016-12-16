//
//  ViewController.swift
//  XCHRateView
//
//  Created by xuech on 2016/12/8.
//  Copyright © 2016年 obizsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let starView = WXStarRateView(frame:  CGRect(x: 20,y: 60,width: 300,height: 30), starCount: 5, score: 0.0)
        starView.isAllowUserPan = true
        starView.isForbidComplete = false
        starView.starValue = {
            (score) in
            print("\(score)")
        }
        self.view.addSubview(starView)
        
    }

}

