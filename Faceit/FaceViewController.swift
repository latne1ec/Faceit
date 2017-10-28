//
//  ViewController.swift
//  Faceit
//
//  Created by Evan Latner on 10/20/17.
//  Copyright © 2017 levellabs. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    @IBOutlet weak var faceView: FaceView! {
        // Called when this variable/outlet is set
        didSet {
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:)))
            faceView.addGestureRecognizer(tapRecognizer)
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeUp.direction = .up
            faceView.addGestureRecognizer(swipeUp)
            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipeDown.direction = .down
            faceView.addGestureRecognizer(swipeDown)
            updateUI()
        }
    }
    
    @objc func increaseHappiness () {
        expression = expression.happier
    }
    
    @objc func decreaseHappiness () {
        expression = expression.sadder
    }
    
    @objc func toggleEyes (byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth:  expression.mouth)
        }
    }
    
    var expression = FacialExpression(eyes: .closed, mouth: .frown) {
        didSet {
            updateUI()
        }
    }
    
    // Make the model match the UI
    private func updateUI () {
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    private var mouthCurvatures = [FacialExpression.Mouth.grin : 0.5, .frown : -1.0, .smile : 1.0, .neutral : 0.0, .smirk : -0.5]
}

