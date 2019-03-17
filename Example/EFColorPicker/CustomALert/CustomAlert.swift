//
//  DashedActionSheet.swift
//  Looplio
//
//  Created by Yurii Koval on 4/13/16.
//  Copyright © 2016 Rachel Schneebaum. All rights reserved.
//

import UIKit
import StoreKit

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
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
  return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
