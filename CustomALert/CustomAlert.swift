//
//  DashedActionSheet.swift
//  Looplio
//
//  Created by Yurii Koval on 4/13/16.
//  Copyright © 2016 Rachel Schneebaum. All rights reserved.
//

import UIKit
import StoreKit
import Crashlytics

enum CustomAlertConstants {
  static let yes = "yes"
  static let notReally = "notReally"
  static let enjoingTheApp = "enjoingTheApp"
  static let heyThere = "heyThere"
  static let sure = "sure"
  static let no = "no"
  static let awsome = "awsome"
  static let howAbout = "howAbout"
}

class CustomAlert: UIViewController {

  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel!

  var coinsCount: Int!
  var product = SKProduct()
  var coinsToAdd: Int!
  var isYesTapped = false
  var isSKRating = false

  @IBAction func yesButtonTapped(_ sender: UIButton) {
    if isSKRating {
      self.dismiss(animated: true, completion: nil)

      if #available(iOS 10.3, *) {
        SKStoreReviewController.requestReview()
        Answers.logCustomEvent(withName: "Showed SKStore rating", customAttributes: [:])
      }
    }
    else {
      changeShate()
    }
  }

  @IBAction func noButtonTapped(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.yesButton.setTitle(CustomAlertConstants.yes.localized(), for: .normal)
    self.noButton.setTitle(CustomAlertConstants.notReally.localized(), for: .normal)
    self.titleLabel.text = CustomAlertConstants.heyThere.localized()
    self.messageLabel.text = CustomAlertConstants.enjoingTheApp.localized()
    yesButton.layer.cornerRadius = yesButton.bounds.width / 26
  }

  func changeShate() {

    if isYesTapped {
      guard let url = URL(string: "itms-apps://itunes.apple.com/us/app/id1363357112?action=write-review") else { return }

      if #available(iOS 10.0, *) {
        UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
      } else {
        UIApplication.shared.openURL(url)
      }

      isYesTapped = false
      self.dismiss(animated: true, completion: nil)
    }
    else {
      isYesTapped = true
    }

    UIView.animate(withDuration: 0.3, animations: {
      self.yesButton.alpha = 0
      self.noButton.alpha = 0
      self.titleLabel.alpha = 0
      self.messageLabel.alpha = 0
    }) { _ in
      UIView.animate(withDuration: 0.3, delay: 0.2, options: [], animations: {
        self.yesButton.setTitle(CustomAlertConstants.sure.localized(), for: .normal)
        self.noButton.setTitle(CustomAlertConstants.no.localized(), for: .normal)
        self.titleLabel.text = CustomAlertConstants.awsome.localized()
        self.messageLabel.text = CustomAlertConstants.howAbout.localized()

        self.yesButton.alpha = 1
        self.noButton.alpha = 1
        self.titleLabel.alpha = 1
        self.messageLabel.alpha = 1
      }, completion: nil)
    }
  }

  //    MARK: Presentation logic
  func show() {
    self.present(true, completion: nil)
  }

  func present(_ animated: Bool, completion: (() -> Void)?) {
    if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
      self.presentFromController(rootVC, animated: animated, completion: completion)
    }
  }

  fileprivate func presentFromController(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
    controller.present(self, animated: animated, completion: completion)
  }

  func showActionSheet(controller: UIViewController?, isSKRating: Bool, dimmedColorAlpha: CGFloat) {
    self.isSKRating = isSKRating
    var actionSheetContentSize = CGSize()
    actionSheetContentSize.width = self.view.bounds.width
    actionSheetContentSize.height = self.view.bounds.height / 1.2
    modalPresentationStyle = UIModalPresentationStyle.custom
    let localTransitioningDelegate = AlertTransitioningDelegate(withSize: actionSheetContentSize)
    localTransitioningDelegate.dimmedColorAlpha = dimmedColorAlpha
    self.transitioningDelegate = localTransitioningDelegate
    self.show()
  }

  //    MARK: ActionSheetDataSource
  class func createActionSheet() -> CustomAlert {

    let dialogWindowsStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    let dashsedActionSheetStoryboardVC = dialogWindowsStoryboard.instantiateViewController(withIdentifier: "ActionSheetAlert") as! CustomAlert
    return dashsedActionSheetStoryboardVC
  }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
  return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
