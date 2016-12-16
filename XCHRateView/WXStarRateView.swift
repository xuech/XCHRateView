//
//  WXStarRateView.swift
//  XCHRateView
//
//  Created by xuech on 2016/12/8.
//  Copyright © 2016年 obizsoft. All rights reserved.
//

import UIKit



class WXStarRateView: UIView {
    
    fileprivate var starCount   : Int!
    fileprivate var score       : Float!
    
    fileprivate var starBackgroundView:UIView!
    fileprivate var starForegroundView:UIView!
    
    public var starValue: ((Float) -> Void)?
    
    var isUsePanAnimation: Bool   = false
    var isForbidComplete:Bool = true{
        willSet{
            self.isForbidComplete = newValue
            showStarRate()
        }
    }
    
    var isAllowUserPan: Bool{
        set{
            if newValue {
                let pan = UIPanGestureRecognizer(target: self,action: #selector(WXStarRateView.starPan(_:)))
                addGestureRecognizer(pan)
            }
            _isAllowUserPan = newValue
        }
        get{
            return _isAllowUserPan
        }
    }
    fileprivate var _isAllowUserPan:Bool = true

    
    override convenience init(frame: CGRect) {
        self.init(frame:frame, starCount: 5, score: 0.0)
    }
    
    init(frame: CGRect, starCount: Int, score: Float) {
        self.starCount = starCount
        self.score = score
        super.init(frame: frame)
        self.clipsToBounds = true
        buildBackView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildBackView() {
        starBackgroundView = starViewWithImageName("star_tempty_icon")
        starForegroundView = starViewWithImageName("star_full_icon")
        addSubview(starBackgroundView)
        addSubview(starForegroundView)
        showStarRate()
        
        let tap = UITapGestureRecognizer(target: self,action: #selector(WXStarRateView.starTap(_:)))
        addGestureRecognizer(tap)
    }
    
    fileprivate func starViewWithImageName(_ imageName:String) -> UIView {
        let starView = UIView(frame: self.bounds)
        starView.clipsToBounds = true
        let width = self.frame.size.width / CGFloat(starCount)
        for index in 0...starCount {
            let imageView = UIImageView(frame: CGRect(x:CGFloat(index) * width,y: 0,width:width,height:self.bounds.size.height))
            imageView.image = UIImage(named: imageName)
            starView.addSubview(imageView)
        }
        return starView
    }
    
    fileprivate func showStarRate() {
        let  durationTime = isUsePanAnimation ? 0.1 : 0.0
        UIView.animate(withDuration: durationTime, animations: {
            var kStarWidth : CGFloat = 0.0
            if self.isForbidComplete {
                kStarWidth = self.bounds.width / CGFloat(self.starCount) * CGFloat(self.score)
            }else{
               kStarWidth = self.bounds.width / CGFloat(self.starCount) * CGFloat(Int(self.score + 0.8))
            }
            self.starForegroundView.frame = CGRect(x: 0,y: 0,width: kStarWidth, height: self.bounds.height)
        })
    }
    
    func starPan(_ recognizer:UIPanGestureRecognizer) {
        var offSetX:CGFloat = 0
        if recognizer.state == .began{
            offSetX = recognizer.location(in: self).x
        }else if recognizer.state == .changed{
            offSetX += recognizer.location(in: self).x
        }else{
            return
        }
        score = Float(offSetX) / Float(self.bounds.width) * Float(starCount)
        showStarRate()
        returnSorce()
    }
    func starTap(_ recognizer:UITapGestureRecognizer) {
        let offSetX = recognizer.location(in: self).x
        score = Float(offSetX) / Float(self.bounds.width) * Float(starCount)
        showStarRate()
        returnSorce()
    }
    
    fileprivate func returnSorce() {
        var newScore:Float =  isForbidComplete ? score : Float(Int(score + 0.8))
        if  newScore > Float(starCount){
            newScore = Float(starCount)
        }else if newScore < 0{
            newScore = 0
        }
        starValue?(newScore)
    }


}
