//
//  AlertPresentationController.swift
//  Looplio
//
//  Created by Yurii Koval on 4/8/16.
//  Copyright © 2016 Rachel Schneebaum. All rights reserved.
//

import UIKit

class AlertPresentationController: UIPresentationController, UIAdaptivePresentationControllerDelegate {
  
  var chromeView: UIView = UIView()
  var sizeOfViewController = CGSize()
  var isPurchaseStarted = false
  var dimmedColorAlpha: CGFloat = 0.0 {
    didSet {
      chromeView.backgroundColor = UIColor(white:0.0, alpha: dimmedColorAlpha)
    }
  }

  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    super.init(presentedViewController:presentedViewController, presenting:presentingViewController)
    chromeView.backgroundColor = UIColor(white:0.0, alpha: dimmedColorAlpha)
    chromeView.alpha = 0.0
  }
  
  func purchaseStarted() {
    self.isPurchaseStarted = true
  }
  
  func purchaseFinished() {
    self.isPurchaseStarted = false
  }
  
  @objc func chromeViewTapped(_ gesture: UIGestureRecognizer) {
    if gesture.state == UIGestureRecognizer.State.ended && !self.isPurchaseStarted {
      presentingViewController.dismiss(animated: true, completion: nil)
    }
  }
  
  override var frameOfPresentedViewInContainerView : CGRect {
    guard let containerBounds = containerView?.bounds else { return CGRect.zero}

    var bottomInsert: CGFloat = 15.0

    if #available(iOS 11.0, *) {
      let window = UIApplication.shared.keyWindow
      bottomInsert += window?.safeAreaInsets.bottom ?? 0.0
    }
    
    var rect = CGRect.zero
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
      rect = CGRect(x: 15,
                    y: containerBounds.height - containerBounds.height / 2.1,
                    width: containerBounds.width - 30,
                    height: containerBounds.height / 2.1 - bottomInsert)
    case .pad:
      rect = CGRect(x: containerBounds.width / 2 - containerBounds.width / 5,
                    y: containerBounds.height - containerBounds.height / 4,
                    width: containerBounds.width / 2.5,
                    height: containerBounds.height / 4 - bottomInsert)
    default:
      rect = CGRect.zero
    }
    
    return rect
  }
  
  override func presentationTransitionWillBegin() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(AlertPresentationController.chromeViewTapped(_:)))
    chromeView.addGestureRecognizer(tap)
    chromeView.frame = self.containerView!.bounds
    chromeView.alpha = 0.0
    containerView?.insertSubview(chromeView, at:0)
    guard let coordinator = presentedViewController.transitionCoordinator else {
      chromeView.alpha = 1.0
      return
    }
    coordinator.animate(alongsideTransition: {
      (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
      self.chromeView.alpha = 1.0
    }, completion:nil)
  }
  
  override func dismissalTransitionWillBegin() {
    guard let coordinator = presentedViewController.transitionCoordinator else {
      chromeView.alpha = 1.0
      return
    }
    coordinator.animate(alongsideTransition: {
      (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
      self.chromeView.alpha = 0.0
    }, completion:nil)
  }
  
  override func containerViewWillLayoutSubviews() {
    chromeView.frame = containerView!.bounds
    presentedView!.frame = frameOfPresentedViewInContainerView
  }
  
  override var shouldPresentInFullscreen : Bool {
    return true
  }
  
  override var adaptivePresentationStyle : UIModalPresentationStyle {
    return UIModalPresentationStyle.fullScreen
  }
  
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return UIModalPresentationStyle.overFullScreen
  }
}

