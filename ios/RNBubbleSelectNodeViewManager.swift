//
//  Extensions.swift
//  Magnetic
//
//  Created by KingJS226 on 5/9/2022.
//  Copyright © 2022 efremidze. All rights reserved.
//

import Foundation
import UIKit

@objc(RNBubbleSelectNodeViewManager)
class RNBubbleSelectNodeViewManager: RCTViewManager {
  
  var id: String?
  var value: CGFloat = 0.0
  var title: String?
  var subTitle: String?
  var prefix: String?
  var surfix: String?
  var icon: UIImage?
  var image: UIImage?
  var color: UIColor?
  var radius: CGFloat?
  var marginScale: CGFloat?
  
  // Label Styling
  var fontName: String?
  var valueSize: CGFloat?
  var titleSize: CGFloat?
  var subTitleSize: CGFloat?
  var iconSize: CGFloat?
  var valueColor: UIColor?
  var titleColor: UIColor?
  var subTitleColor: UIColor?
  var lineHeight: CGFloat?
  
  override func view() -> UIView! {
    let node = RNBubbleSelectNodeView()
    node.id = id
    node.value = value
    node.title = title
    node.subTitle = subTitle
    node.prefix = prefix
    node.surfix = surfix
    node.icon = icon
    node.image = image
    node.color = color
    node.radius = radius
    node.marginScale = marginScale
    node.fontName = fontName
    node.valueSize = valueSize
    node.titleSize = titleSize
    node.subTitleSize = subTitleSize
    node.iconSize = iconSize
    node.valueColor = valueColor ?? .white
    node.titleColor = titleColor ?? .white
    node.subTitleColor = subTitleColor ?? .white
    node.lineHeight = lineHeight ?? 1.1
    node.updateNode()
    return node
  }
}

// MARK:- Setters
extension RNBubbleSelectNodeViewManager {
  @objc func setId(_ id: String?) {
    self.id = id
  }
  
 @objc func setValue(_ value: CGFloat) {
   self.value = value
 }

  @objc func setTitle(_ title: String?) {
    self.title = title
  }

  @objc func setSubTitle(_ subTitle: String?) {
    self.subTitle = subTitle
  }

  @objc func setPrefix(_ prefix: String?) {
    self.prefix = prefix
  }

  @objc func setSurfix(_ surfix: String?) {
    self.surfix = surfix
  }

  @objc func setIcon(_ icon: UIImage?) {
    self.icon = icon
  }
  
  @objc func setImage(_ image: UIImage?) {
    self.image = image
  }
  
  @objc func setColor(_ color: UIColor?) {
    self.color = color
  }
  
  @objc func setRadius(_ radius: CGFloat) {
    self.radius = radius
  }
  
  @objc func setMarginScale(_ marginScale: CGFloat) {
    self.marginScale = marginScale
  }
  
  @objc func setValueSize(_ valueSize: CGFloat) {
    self.valueSize = valueSize
  }

  @objc func setTitleSize(_ titleSize: CGFloat) {
    self.titleSize = titleSize
  }

  @objc func setIconSize(_ iconSize: CGFloat) {
    self.iconSize = iconSize
  }

  @objc func setSubTitleSize(_ subTitleSize: CGFloat) {
    self.subTitleSize = subTitleSize
  }
  
  @objc func setFontName(_ fontName: String?) {
    self.fontName = fontName
  }
  
  @objc func setValueColor(_ valueColor: UIColor?) {
    self.valueColor = valueColor
  }

  @objc func setTitleColor(_ titleColor: UIColor?) {
    self.titleColor = titleColor
  }

  @objc func setSubTitleColor(_ subTitleColor: UIColor?) {
    self.subTitleColor = subTitleColor
  }
  
  @objc func setLineHeight(_ lineHeight: CGFloat) {
    self.lineHeight = lineHeight
  }
}
