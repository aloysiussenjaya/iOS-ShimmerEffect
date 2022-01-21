//
//  ViewController.swift
//  iOS-ShimmerEffect
//
//  Created by Aloysius Shendy on 22/01/22.
//

import UIKit

class ViewController: UIViewController {
    // Create Label
    let label = UILabel()
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set the gradient frame to the label bounds
        gradientLayer.frame = label.bounds
        gradientLayer.cornerRadius = label.bounds.height / 2
    }
    
    func setup() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shimmer"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        // Add the gradient layer to the label. Cause this sublayer to appear on top
        label.layer.addSublayer(gradientLayer)
        
        // Create the Shimmer Animation
        let titleGroup = makeAnimationGroup()
        titleGroup.beginTime = 0.0
        gradientLayer.add(titleGroup, forKey: "backgroundColor")

    }
    
    func layout() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 1),
            label.heightAnchor.constraint(equalToConstant: 36),
        ])
        
        
    }
    
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5
        
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = UIColor.gradientLightGrey.cgColor
        anim1.toValue = UIColor.gradientDarkGrey.cgColor
        anim1.duration = animDuration
        anim1.beginTime = 0.0

        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.gradientDarkGrey.cgColor
        anim2.toValue = UIColor.gradientLightGrey.cgColor
        anim2.duration = animDuration
        anim2.beginTime = anim1.beginTime + anim1.duration

        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            // Offset groups by 0.33 seconds for effect
            group.beginTime = previousGroup.beginTime + 0.33
        }

        return group
    }


}


extension UIColor {
    static var gradientDarkGrey: UIColor {
        return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
    }

    static var gradientLightGrey: UIColor {
        return UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
    }
}

