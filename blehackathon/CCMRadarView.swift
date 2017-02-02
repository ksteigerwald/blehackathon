//
//  Copyright 2014 Carlos Compean.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

extension CCMRadarView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if flag{
            if let sublayers = layer.sublayers {
                for index in 0..<sublayers.count {
                    if(index == sublayers.count - 1 && animating){
                        startAnimation()
                    } else {
                        restoreInitialAlphas()
                    }
                    
                }
            }
            
        }
    }
    
}

@objc @IBDesignable open class CCMRadarView: UIView{
    
    //var color: UIColor = UIColor.blueColor()
    fileprivate var animating: Bool = false
    
    @IBInspectable open var reversedRadar:Bool = false{
        didSet{
            initialSetup()
        }
    }
    
    @IBInspectable open var numberOfWaves:Int = 4{
        didSet{
            initialSetup()
        }
    }
    
    @IBInspectable open var radarColor: UIColor = UIColor.blue {
        didSet{
            initialSetup()
        }
    }
    
    @IBInspectable open var innerRadius: Double = 50.0 {
        didSet{
            initialSetup()
        }
    }
    
    @IBInspectable open var iconImage: UIImage?{
        didSet{
            initialSetup()
        }
    }
    
    @IBInspectable open var iconSize: CGSize = CGSize(width: 20, height: 20){
        didSet{
            initialSetup()
        }
    }
    
    @IBInspectable open var waveWidth: CGFloat = 2 {
        didSet{
            initialSetup()
        }
    }
    
    @IBInspectable open var maxWaveAlpha: CGFloat = 1 {
        didSet{
            initialSetup()
        }
    }
    
    open func startAnimation() {
        animating = true
        if let sublayers = layer.sublayers {
            for (index,sublayer) in (layer.sublayers as [CALayer]!).enumerated() {
                if let sublayer = sublayer as? CAShapeLayer {
                    let animation = CAKeyframeAnimation()
                    animation.keyPath = "opacity"
                    animation.values = [0,0,1,0]
                    animation.duration = 1.5
                    var beginTime:Double
                    if (!reversedRadar){
                        beginTime = (Double(animation.duration)/Double(numberOfWaves + 1)) * (Double(sublayers.count) - 1.0 - Double(index))
                    } else {
                        beginTime = (Double(animation.duration)/Double(numberOfWaves + 1)) * Double(index)
                    }
                    let keyTime1 = NSNumber(value: beginTime/animation.duration)
                    let keyTime2 = NSNumber(value: beginTime/animation.duration)
                    let keyTime3 = NSNumber(value: (beginTime + Double(animation.duration)/(Double(numberOfWaves) - 2.5))/animation.duration)
                    animation.keyTimes = [0, keyTime1, keyTime2, keyTime3]
                    animation.delegate = self
                    sublayer.add(animation, forKey: "animForLayer\(index)")
                    sublayer.opacity = 0
                }
            }
        }
    }
    
    fileprivate func restoreInitialAlphas(){
        var currentAlpha = maxWaveAlpha;
        if reversedRadar {
            for _ in 1..<numberOfWaves{
                currentAlpha /= 2.5
            }
        }
        
        
        UIView.animate(withDuration: 0.6, animations: { () -> Void in
            for (_,sublayer) in (self.layer.sublayers as [CALayer]!).enumerated() {
                if sublayer is CAShapeLayer {
                    sublayer.opacity = Float(currentAlpha)
                    if(self.reversedRadar){
                        currentAlpha *= 2.5
                    } else {
                        currentAlpha /= 2.5
                    }
                }
            }
        })
    }
    
    open func stopAnimation() {
        animating = false
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    override open func layoutSubviews() {
        initialSetup()
    }
    
    fileprivate func initialSetup(){
        layer.sublayers = []
        let insetOffsetDelta = (Double(self.layer.bounds.height/2) - innerRadius) / Double(numberOfWaves)
        //let alphaVariance = (maxWaveAlpha - minWaveAlpha) / CGFloat(numberOfWaves)
        var currentInsetOffset:CGFloat = 0;
        
        var currentAlpha = maxWaveAlpha;
        if reversedRadar {
            for _ in 1..<numberOfWaves{
                currentAlpha /= 2.5
            }
        }
        
        for _ in 0..<numberOfWaves {
            let sublayer = CAShapeLayer()
            sublayer.frame = self.layer.bounds.insetBy(dx: currentInsetOffset, dy: currentInsetOffset)
            let circle = UIBezierPath(ovalIn: sublayer.bounds.insetBy(dx: waveWidth, dy: waveWidth))
            sublayer.path = circle.cgPath
            sublayer.strokeColor = radarColor.cgColor
            sublayer.lineWidth = waveWidth
            sublayer.fillColor = UIColor.clear.cgColor
            sublayer.opacity = Float(currentAlpha)
            layer.addSublayer(sublayer)
            currentInsetOffset += CGFloat(insetOffsetDelta)
            if(reversedRadar){
                currentAlpha *= 2.5
            } else {
                currentAlpha /= 2.5
            }
        }
        
        if let image = iconImage {
            let imageView = UIImageView(frame: CGRect(x: (self.bounds.width - iconSize.width) / 2.0, y: (self.bounds.height - iconSize.height) / 2.0, width: iconSize.width, height: iconSize.height))
            imageView.image = image
            self.addSubview(imageView)
        }
        
    }
}
