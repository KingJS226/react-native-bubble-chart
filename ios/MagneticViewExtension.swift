//
//  Extensions.swift
//  Magnetic
//
//  Created by KingJS226 on 5/9/2022.
//  Copyright © 2022 efremidze. All rights reserved.
//

import Foundation

extension MagneticView {
  
  override public func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    guard let subview = subview as? RNBubbleSelectNodeView else { return }
    magnetic.addChild(subview.node)
  }
  
  public override func removeReactSubview(_ subview: UIView!) {
    guard let subview = subview as? RNBubbleSelectNodeView else { return }
    subview.node.removeFromParent()
  }
  
  
  // Stub functions to make sure RN works
  @objc func setOnSelect(_ onSelectNode: RCTDirectEventBlock?) {
  }
  
  @objc func setOnDeselectNode(_ onDeselectNode: RCTDirectEventBlock?) {
  }
  
  @objc func setAllowsMultipleSelection(_ allowsMultipleSelection: Bool) {
  }
}

