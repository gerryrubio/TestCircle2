//
//  ViewController.swift
//  TestCircle2
//
//  Created by Gerry Rubio on 2/26/18.
//  Copyright © 2018 Gerry Rubio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBInspectable var circleColor: UIColor? {
        didSet {
            view1.layer.backgroundColor = (self.view1.backgroundColor as! CGColor)
        }
    }
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    
    var greenSquare: UIView?
    var redSquare: UIView?
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    override func viewDidLoad() {
        super.viewDidLoad()
        newAnimation8()
        newAnimation7()
        newAnimation6()
        newAnimation5()
        newAnimation4()
        newAnimation3()
        newAnimation()
        startBouncingBalls()
    }
    
    func startBouncingBalls() {
        var dimen = CGRect(x: 15, y: 15, width: 30, height: 30)
        greenSquare = UIView(frame: dimen)
        greenSquare?.layer.cornerRadius = (greenSquare?.bounds.height)! / 2
        greenSquare?.backgroundColor = UIColor.green
        greenSquare?.clipsToBounds = true
        
        dimen = CGRect(x: 100, y: 15, width: 45, height: 45)
        redSquare = UIView(frame: dimen)
        redSquare?.layer.cornerRadius = (redSquare?.bounds.height)! / 2
        redSquare?.backgroundColor = UIColor.red
        redSquare?.clipsToBounds = true
        
        self.view8.addSubview(greenSquare!)
        self.view8.addSubview(redSquare!)
        
        let gestureRed = UIPanGestureRecognizer(target: self, action:  #selector (self.handlePan (_:)))
        let gestureGreen = UIPanGestureRecognizer(target: self, action:  #selector (self.handlePan (_:)))
        redSquare?.addGestureRecognizer(gestureRed)
        greenSquare?.addGestureRecognizer(gestureGreen)
        
        animator = UIDynamicAnimator(referenceView: self.view8)
        
        gravity = UIGravityBehavior(items: [greenSquare!, redSquare!])
        let direction = CGVector(dx: 0.1, dy: 1.0)
        gravity?.gravityDirection = direction
        
        let boundaries = UICollisionBehavior(items: [greenSquare!, redSquare!])
        boundaries.translatesReferenceBoundsIntoBoundary = true
        
        let bounce = UIDynamicItemBehavior(items: [greenSquare!, redSquare!])
        bounce.elasticity = 1.0
        
        animator?.addBehavior(bounce)
        animator?.addBehavior(boundaries)
        animator?.addBehavior(gravity!)
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .changed {
            
            gestureRecognizer.view?.removeGestureRecognizer(gestureRecognizer)
     //       animator?.removeAllBehaviors()
            let translation = gestureRecognizer.translation(in: self.view8)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view8)
        }
        if gestureRecognizer.state == .ended {
            let boundaries = UICollisionBehavior(items: [greenSquare!, redSquare!])
            boundaries.translatesReferenceBoundsIntoBoundary = true
            
            let bounce = UIDynamicItemBehavior(items: [greenSquare!, redSquare!])
            bounce.elasticity = 1.0
            
            animator?.addBehavior(bounce)
            animator?.addBehavior(boundaries)
            animator?.addBehavior(gravity!)
            gestureRecognizer.view?.addGestureRecognizer(gestureRecognizer)
        }
    }

    func newAnimation8() {
        let ovalShapeLayer1 = CAShapeLayer()
        let ovalShapeLayer2 = CAShapeLayer()
        ovalShapeLayer1.fillColor = UIColor.clear.cgColor
        let refreshRadius = view1.frame.size.height/2
   //     let point1 = CGPoint(x: view1.layer.bounds.midX, y: view1.layer.bounds.midY)
        let point1 = CGPoint(x: view1.center.x, y: view1.center.y)
        ovalShapeLayer1.path = UIBezierPath(arcCenter: point1, radius: refreshRadius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true).cgPath
        ovalShapeLayer2.path = UIBezierPath(arcCenter: point1, radius: refreshRadius - (refreshRadius * 0.80), startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true).cgPath
        
        
        ovalShapeLayer1.shadowPath = ovalShapeLayer1.path
        ovalShapeLayer1.shadowOpacity = 0.4
        ovalShapeLayer1.shadowColor = UIColor.green.cgColor
        view1.layer.addSublayer(ovalShapeLayer1)
        
        ovalShapeLayer2.shadowPath = ovalShapeLayer2.path
        view1.layer.addSublayer(ovalShapeLayer2)
        ovalShapeLayer2.strokeColor = UIColor.clear.cgColor
        ovalShapeLayer2.fillColor = UIColor.green.cgColor
        
        let basicAnimationStart = CABasicAnimation(keyPath: "shadowPath")
        basicAnimationStart.fromValue = ovalShapeLayer2.path
        basicAnimationStart.toValue = ovalShapeLayer1.path
        //      basicAnimationStart.toValue = ovalShapeLayer2.path
        basicAnimationStart.duration = 2
        basicAnimationStart.repeatCount = MAXFLOAT
        basicAnimationStart.fillMode = kCAFillModeForwards
        ovalShapeLayer1.add(basicAnimationStart, forKey: nil)
    }
    
    func newAnimation7() {
        let ovalShapeLayer = CAShapeLayer()
        ovalShapeLayer.strokeColor = UIColor.white.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = 4.0
        //    ovalShapeLayer.lineDashPattern = [10,5]
        let refreshRadius = view2.frame.size.height/2 * 0.5
        let point1 = CGPoint(x: view2.layer.bounds.midX, y: view2.layer.bounds.midY)
        ovalShapeLayer.path = UIBezierPath(arcCenter: point1, radius: refreshRadius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true).cgPath
        
        view2.layer.addSublayer(ovalShapeLayer)
        let basicAnimationStart = CABasicAnimation(keyPath: "strokeStart")
        basicAnimationStart.fromValue = -0.5
        basicAnimationStart.toValue = 1.0
        basicAnimationStart.fillMode = kCAFillModeForwards
        
        
        let basicAnimationEnd = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimationEnd.fromValue = 0.0
        basicAnimationEnd.toValue = 1.0
        basicAnimationEnd.fillMode = kCAFillModeForwards
        
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 2
        strokeAnimationGroup.repeatCount = MAXFLOAT
        strokeAnimationGroup.animations = [basicAnimationStart,basicAnimationEnd]
        
        ovalShapeLayer.add(strokeAnimationGroup, forKey: nil)
    }
    
    func newAnimation6() {
        let ovalShapeLayer = CAShapeLayer()
        ovalShapeLayer.strokeColor = UIColor.orange.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = 20.0
        ovalShapeLayer.lineDashPattern = [2,3]
        let refreshRadius = view3.frame.size.height/2 * 0.5
        let point1 = CGPoint(x: view3.layer.bounds.midX, y: view3.layer.bounds.midY)
        ovalShapeLayer.path = UIBezierPath(arcCenter: point1, radius: refreshRadius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true).cgPath
        view3.layer.addSublayer(ovalShapeLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.repeatCount = MAXFLOAT
        
        ovalShapeLayer.add(basicAnimation, forKey: nil)
    }
    
    func newAnimation5() {
        //circlePath will be ued by the circleLayer to draw the orbit circle.
        // Will also be used by the animation to pave the path to move the object along the orbit circle
        let point1 = CGPoint(x: view4.layer.bounds.midX, y: view4.layer.bounds.midY)
        let circlePath1 = UIBezierPath(arcCenter: point1, radius: 20, startAngle: 0, endAngle: .pi*2, clockwise: true)
        let circlePath2 = UIBezierPath(arcCenter: point1, radius: 40, startAngle: 0, endAngle: .pi*2, clockwise: true)
        let circlePath3 = UIBezierPath(arcCenter: point1, radius: 60, startAngle: 0, endAngle: .pi*2, clockwise: false)
        
        let sunPath = UIBezierPath(arcCenter: point1, radius: 10, startAngle: 0, endAngle: .pi*2, clockwise: true)
        
        let animation1 = CAKeyframeAnimation(keyPath: "position")
        animation1.duration = 5
        animation1.repeatCount = MAXFLOAT
        animation1.path = circlePath1.cgPath
        
        let ballLayer1 = CAShapeLayer()
        ballLayer1.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 3, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        ballLayer1.fillColor = UIColor.blue.cgColor
        view4.layer.addSublayer(ballLayer1)
        ballLayer1.zPosition = 2
        // You can also pass any unique string value for key
        ballLayer1.add(animation1, forKey: nil)
        
        // circleLayer is only used to locate the circle animation path
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath1.cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 0.25
        circleLayer.fillColor = UIColor.clear.cgColor
        view4.layer.addSublayer(circleLayer)
        //-----------------------------------------
        
        let animation2 = CAKeyframeAnimation(keyPath: "position")
        animation2.duration = 10
        animation2.repeatCount = MAXFLOAT
        animation2.path = circlePath2.cgPath
        
        let ballLayer2 = CAShapeLayer()
        ballLayer2.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 7, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        ballLayer2.fillColor = UIColor.green.cgColor
        view4.layer.addSublayer(ballLayer2)
        // You can also pass any unique string value for key
        ballLayer2.add(animation2, forKey: nil)
        
        // circleLayer is only used to locate the circle animation path
        let circleLayer2 = CAShapeLayer()
        circleLayer2.path = circlePath2.cgPath
        circleLayer2.strokeColor = UIColor.white.cgColor
        circleLayer2.lineWidth = 0.25
        circleLayer2.fillColor = UIColor.clear.cgColor
        circleLayer2.zPosition = -1
        view4.layer.addSublayer(circleLayer2)
        //-----------------------------------------
        
        // circleLayer is only used to locate the circle animation path
        let circleLayer3 = CAShapeLayer()
        circleLayer3.path = circlePath3.cgPath
        circleLayer3.strokeColor = UIColor.white.cgColor
        circleLayer3.lineWidth = 0.25
        circleLayer3.fillColor = UIColor.clear.cgColor
        view4.layer.addSublayer(circleLayer3)
        
        let animation3 = CAKeyframeAnimation(keyPath: "position")
        animation3.duration = 15
        animation3.repeatCount = MAXFLOAT
        animation3.path = circlePath3.cgPath
        
        let ballLayer3 = CAShapeLayer()
        ballLayer3.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        ballLayer3.fillColor = UIColor.magenta.cgColor
        view4.layer.addSublayer(ballLayer3)
        // You can also pass any unique string value for key
        ballLayer3.add(animation3, forKey: nil)
        /*
         // circleLayer is only used to locate the circle animation path
         let circleLayer3 = CAShapeLayer()
         circleLayer3.path = circlePath3.cgPath
         circleLayer3.strokeColor = UIColor.black.cgColor
         circleLayer3.lineWidth = 0.25
         circleLayer3.fillColor = UIColor.clear.cgColor
         view.layer.addSublayer(circleLayer3)
         */
        // sun is only used to draw the orange sun circle
        let sunLayer = CAShapeLayer()
        sunLayer.path = sunPath.cgPath
        sunLayer.strokeColor = UIColor.orange.cgColor
        sunLayer.lineWidth = 1
        sunLayer.fillColor = UIColor.orange.cgColor
        view4.layer.addSublayer(sunLayer)
    }
    
    func newAnimation4() {
        //circlePath will be ued by the circleLayer to draw the orbit circle.
        // Will also be used by the animation to pave the path to move the object along the orbit circle
        let point1 = CGPoint(x: view5.layer.bounds.midX, y: view5.layer.bounds.midY)
        let circlePath = UIBezierPath(arcCenter: point1, radius: 20, startAngle: 0, endAngle: .pi*2, clockwise: true)
        
        let sunPath = UIBezierPath(arcCenter: point1, radius: 5, startAngle: 0, endAngle: .pi*2, clockwise: true)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 5
        animation.repeatCount = MAXFLOAT
        animation.path = circlePath.cgPath
        
        let ballLayer = CAShapeLayer()
        ballLayer.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        ballLayer.fillColor = UIColor.blue.cgColor
        view5.layer.addSublayer(ballLayer)
        // You can also pass any unique string value for key
        ballLayer.add(animation, forKey: nil)
        
        
        
        // circleLayer is only used to locate the circle animation path
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
   //     circleLayer.strokeColor = UIColor.white.cgColor
   //     circleLayer.lineWidth = 0.25
        circleLayer.fillColor = UIColor.clear.cgColor
        view5.layer.addSublayer(circleLayer)
        
        // sun is only used to draw the orange sun circle
        let sunLayer = CAShapeLayer()
        sunLayer.path = sunPath.cgPath
        sunLayer.strokeColor = UIColor.orange.cgColor
        sunLayer.lineWidth = 1
        sunLayer.fillColor = UIColor.orange.cgColor
        view5.layer.addSublayer(sunLayer)
    }
    
    func newAnimation3() {
        //circlePath will be ued by the circleLayer to draw the orbit circle.
        // Will also be used by the animation to pave the path to move the object along the orbit circle
        let point1 = CGPoint(x: view6.layer.bounds.midX, y: view6.layer.bounds.midY)
        let circlePath = UIBezierPath(arcCenter: point1, radius: 20, startAngle: 0, endAngle: .pi*2, clockwise: true)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 5
        animation.repeatCount = MAXFLOAT
        animation.path = circlePath.cgPath
        
        let ballLayer = CAShapeLayer()
        ballLayer.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        ballLayer.fillColor = UIColor.blue.cgColor
        view6.layer.addSublayer(ballLayer)
        // You can also pass any unique string value for key
        ballLayer.add(animation, forKey: nil)
        
        // circleLayer is only used to locate the circle animation path
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 0.25
        circleLayer.fillColor = UIColor.clear.cgColor
        view6.layer.addSublayer(circleLayer)
    }
    
    func newAnimation() {
        let point1 = CGPoint(x: view7.layer.bounds.midX, y: view7.layer.bounds.midY)
        let circlePath = UIBezierPath(arcCenter: point1, radius: 10, startAngle: 0, endAngle: .pi*2, clockwise: true)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 1
        animation.repeatCount = MAXFLOAT
        animation.path = circlePath.cgPath
        
        let squareView = UIView()
        //whatever the value of origin for squareView will not affect the animation
        squareView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        squareView.backgroundColor = .lightGray
        view7.addSubview(squareView)
        // You can also pass any unique string value for key
        squareView.layer.add(animation, forKey: nil)
        
        // circleLayer is only used to locate the circle animation path
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        view7.layer.addSublayer(circleLayer)
    }

}

