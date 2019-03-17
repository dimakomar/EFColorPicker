//
//  ColorAlert.swift
//  Border
//
//  Created by Dima Komar  on 3/17/19.
//  Copyright © 2019 Dima Komar . All rights reserved.
//

import UIKit
import EFColorPicker

class ColorAlert: EFColorSelectionViewController {

  @IBOutlet weak var colorView: UIView!
  var containerView: UIView!

  //    MARK: Presentation logic
  func show() {
    self.present(true, completion: nil)
  }

  func present(_ animated: Bool, completion: (() -> Void)?) {
    if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
      self.presentFromController(rootVC, animated: animated, completion: completion)
    }
  }

  private func presentFromController(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
    controller.present(self, animated: animated, completion: completion)
  }

  func showActionSheet(controller: UIViewController?, dimmedColorAlpha: CGFloat) {
    let actionSheetContentSize = CGSize()
    modalPresentationStyle = UIModalPresentationStyle.custom
    let localTransitioningDelegate = AlertTransitioningDelegate(withSize: actionSheetContentSize)
    localTransitioningDelegate.dimmedColorAlpha = dimmedColorAlpha
    self.transitioningDelegate = localTransitioningDelegate
    self.show()
  }

  //    MARK: ActionSheetDataSource
  func createActionSheet() -> ColorAlert {

    let dialogWindowsStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    let dashsedActionSheetStoryboardVC = dialogWindowsStoryboard.instantiateViewController(withIdentifier: "ColorAlert") as! ColorAlert

    return dashsedActionSheetStoryboardVC
  }
}
