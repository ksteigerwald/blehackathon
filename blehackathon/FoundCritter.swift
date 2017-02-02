//
//  FoundCritter.swift
//  blehackathon
//
//  Created by KRIS STEIGERWALD on 2/1/17.
//  Copyright © 2017 Velaru. All rights reserved.
//

import UIKit

class FoundCritter: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    var pic:String?
    
    init(_ img: String) {
        super.init(frame: UIScreen.main.bounds);
        self.frame = frame
        self.pic = img
        self.backgroundColor = UIColor.init(red: 165/255, green: 219/255, blue: 220/225, alpha: 1.0)
        self.btnClose()
        self.critter()
        createParticles()
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func btnClose() {
        let r = CGRect(x: 320, y: 50, width: 30, height: 20)
        let btn = UIButton(frame: r )
        btn.setTitle("Close", for: .normal)
        btn.layer.backgroundColor = UIColor.green.cgColor
        btn.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        self.addSubview(btn)
    }
    
    func critter() {
        let m = CGRect(x: 50, y: 100, width: 325, height: 325)
        let mount:UIView = UIView(frame: m)
        
        mount.layer.borderWidth = 5
        mount.layer.borderColor = UIColor.cyan.cgColor
        mount.layer.cornerRadius = mount.frame.width / 2
        mount.layer.backgroundColor = UIColor.gray.cgColor
        
        let p = CGPoint(x: mount.frame.size.width / 2, y: mount.frame.size.height / 2)
        let r = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: mount.frame.width-45, height: mount.frame.height-45))
        let critter:UIImageView = UIImageView(frame: r)
        critter.center = p
        
        print("****\(self.pic)")
        critter.image = UIImage(named: self.pic!)
        mount.addSubview(critter)
        
        self.addSubview(mount)
    }
    
    func close() {
        print("close")
        state.critterCalled = false
        self.removeFromSuperview()
    }
    

    
    func createParticles() {
        let particleEmitter = CAEmitterLayer()
        
        particleEmitter.emitterPosition = CGPoint(x: self.center.x, y: -96)
        particleEmitter.emitterShape = kCAEmitterLayerLine
        particleEmitter.emitterSize = CGSize(width: self.frame.size.width, height: 1)
        
        let red = makeEmitterCell(color: UIColor.red)
        let green = makeEmitterCell(color: UIColor.green)
        let blue = makeEmitterCell(color: UIColor.blue)
        
        particleEmitter.emitterCells = [red, green, blue]
        
        self.layer.addSublayer(particleEmitter)
    }
    
    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05
        
        cell.contents = UIImage(named: "star")?.cgImage
        return cell
    }


}
