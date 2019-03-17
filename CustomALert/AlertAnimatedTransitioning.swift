//
//  AlertAnimatedTransitioning.swift
//  Looplio
//
//  Created by Yurii Koval on 4/8/16.
//  Copyright © 2016 Rachel Schneebaum. All rights reserved.
//

import UIKit

class AlertAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
  
  var isPresentation : Bool = false
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
    let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
    let fromView = fromVC?.view
    let toView = toVC?.view
    let containerView = transitionContext.containerView
    
    if isPresentation {
      containerView.addSubview(toView!)
    }
    
    let animatingVC = isPresentation ? toVC : fromVC
    let animatingView = animatingVC?.view
    
    let finalFrameForVC = transitionContext.finalFrame(for: animatingVC!)
    var initialFrameForVC = finalFrameForVC
    initialFrameForVC.origin.y += initialFrameForVC.size.height
    
    let initialFrame = isPresentation ? initialFrameForVC : finalFrameForVC
    let finalFrame = isPresentation ? finalFrameForVC : initialFrameForVC
    
    animatingView?.frame = initialFrame
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext), delay:0, usingSpringWithDamping:300.0, initialSpringVelocity:5.0, options:UIView.AnimationOptions.allowUserInteraction, animations:{
      animatingView?.frame = finalFrame
    }, completion:{ (value: Bool) in
      if !self.isPresentation {
        fromView?.removeFromSuperview()
      }
      transitionContext.completeTransition(true)
    })
  }
  
}
