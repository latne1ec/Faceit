//
//  EmotionsViewController.swift
//  Faceit
//
//  Created by Evan Latner on 10/27/17.
//  Copyright © 2017 levellabs. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destViewController = segue.destination
        if let navigcationController = destViewController as? UINavigationController {
            destViewController = navigcationController.visibleViewController ?? destViewController
        }
        if let faceViewController = destViewController as? FaceViewController {
            if let identifier = segue.identifier {
                if let expresseion = emotionalFace[identifier] {
                    faceViewController.expression = expresseion
                    faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
    
    private let emotionalFace: Dictionary<String, FacialExpression> = [
        "sad" : FacialExpression(eyes: .closed, mouth: .frown), "happy" : FacialExpression(eyes: .open, mouth: .smile),
        "worried" : FacialExpression(eyes: .open, mouth: .smirk)
    ]

}
