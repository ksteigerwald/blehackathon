//
//  Captured.swift
//  blehackathon
//
//  Created by KRIS STEIGERWALD on 2/2/17.
//  Copyright © 2017 Velaru. All rights reserved.
//

import UIKit

class Captured: UIView {
    
    
    init() {
        super.init(frame: UIScreen.main.bounds);
        self.layer.borderWidth = 5
        self.layer.borderColor = state.colors.tanner.cgColor
        
        self.backgroundColor = state.colors.baseBlue
        self.btnClose()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func didMoveToSuperview() {
        
        badges(x: 40, y: 80, iname: "panda")
        badges(x: 210, y: 80, iname: "lion")
        badges(x: 40, y: 220, iname: "lock")
        badges(x: 210, y: 220, iname: "lock")
        badges(x: 40, y: 360, iname: "lock")
        badges(x: 210, y: 360, iname: "lock")
        
    
    }
    
    func btnClose() {
        
        let r = CGRect(x: 20, y: self.frame.height - 80, width: self.frame.width - 40, height: 50)
        let btn = UIButton(frame: r )
        
        btn.setTitle("Close", for: .normal)
        btn.layer.backgroundColor = state.colors.org.cgColor
        btn.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        
        self.addSubview(btn)
    }

    func close() {
        print("close")
        state.critterCalled = false
        self.removeFromSuperview()
    }

    func badges(x: Int, y: Int, iname: String) {
        
        let frm = CGRect(x: 0, y: 0, width: 125, height: 125)
        let view:UIImageView = UIImageView(frame: frm)
        
        view.layer.cornerRadius = frm.width / 2
        view.layer.borderColor = state.colors.blueHighlight.cgColor
        view.layer.borderWidth = 5
        view.layer.backgroundColor = state.colors.tanner.cgColor
        
        let p = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        
        view.center = p
        view.image = UIImage(named: iname)
        
        self.addSubview(view)
        
        view.frame = CGRect(x: x, y: y, width: 125, height: 125)
        
    }
    

    
}
