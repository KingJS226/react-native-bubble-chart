//
//  Extensions.swift
//  Magnetic
//
//  Created by KingJS226 on 5/9/2022.
//  Copyright © 2022 efremidze. All rights reserved.
//

import Foundation

@objc(RNBubbleSelectViewManager)
class RNBubbleSelectViewManager: RCTViewManager {
  override func view() -> UIView! {
    return RNBubbleMagneticView()
  }
  
  override class func requiresMainQueueSetup() -> Bool {
    return false
  }
}
