//
//  DiscoverViewController.swift
//  blehackathon
//
//  Created by KRIS STEIGERWALD on 2/1/17.
//  Copyright © 2017 Velaru. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createParticles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: myEvents, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createParticles() {
        let particleEmitter = CAEmitterLayer()
        
        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -96)
        particleEmitter.emitterShape = kCAEmitterLayerLine
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        
        let red = makeEmitterCell(color: UIColor.red)
        let green = makeEmitterCell(color: UIColor.green)
        let blue = makeEmitterCell(color: UIColor.blue)
        
        particleEmitter.emitterCells = [red, green, blue]
        
        view.layer.addSublayer(particleEmitter)
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
