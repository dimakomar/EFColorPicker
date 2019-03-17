//
//  AlertTransitioningDelegate.swift
//  Looplio
//
//  Created by Yurii Koval on 4/8/16.
//  Copyright © 2016 Rachel Schneebaum. All rights reserved.
//

import UIKit

class AlertTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
  
  var sizeOfViewController = CGSize()
  var dimmedColorAlpha: CGFloat = 0.0
  
  init(withSize size: CGSize) {
    self.sizeOfViewController = size
    
  }
  
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "main") 
    let presentationController = AlertPresentationController(presentedViewController:presented, presenting:vc)
    presentationController.sizeOfViewController = self.sizeOfViewController
    presentationController.dimmedColorAlpha = dimmedColorAlpha
    return presentationController
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animationController = AlertAnimatedTransitioning()
    animationController.isPresentation = true
    return animationController
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animationController = AlertAnimatedTransitioning()
    animationController.isPresentation = false
    return animationController
  }
  
}
