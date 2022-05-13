//
//  Extensions.swift
//  Magnetic
//
//  Created by KingJS226 on 5/9/2022.
//  Copyright © 2022 efremidze. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class RNBubbleSelectNodeView: UIView {
  var id: String?
  var value: CGFloat = 0.0
  var title: String?
  var subTitle: String?
  var prefix: String? // Prefix of value
  var surfix: String? // Surfix of value
  var icon: UIImage?
  var image: UIImage? // Background Image
  var color: UIColor? // Background Color
  var radius: CGFloat?
  var marginScale: CGFloat?
  var padding: CGFloat?
  
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
  var borderColor: UIColor?
  var borderWidth: CGFloat?
  
  var selectedScale: CGFloat?
  var deselectedScale: CGFloat?
  var animationDuration: CGFloat?
  var selectedColor: UIColor?
  var selectedFontColor: UIColor?
  var scaleToFitContent: Bool = true
  
  lazy var node: Node = {
    let node = Node(
      value: value,
      title: title,
      subTitle: subTitle,
      prefix: prefix,
      surfix: surfix,
      image: image,
      color: color ?? .black,
      radius: radius ?? 30
    )
    return node
  }()
  
  override func didUpdateReactSubviews() {
    updateNode()
  }
  
  func updateNode() {
    node.id = id
    node.value = value
    node.title = title
    node.subTitle = subTitle
    node.prefix = prefix ?? ""
    node.surfix = surfix ?? ""
    node.fontName = fontName ?? Node.Defaults.fontName
    node.valueSize = valueSize ?? Node.Defaults.fontSize
    node.titleSize = titleSize ?? Node.Defaults.fontSize
    node.subTitleSize = subTitleSize ?? Node.Defaults.fontSize
    node.valueColor = valueColor ?? Node.Defaults.fontColor
    node.titleColor = titleColor ?? Node.Defaults.fontColor
    node.subTitleColor = subTitleColor ?? Node.Defaults.fontColor
    node.label.lineHeight = lineHeight
    node.borderColor = borderColor ?? Node.Defaults.borderColor
    node.borderWidth = borderWidth ?? Node.Defaults.borderWidth
    node.color = color ?? Node.Defaults.color
    node.padding = padding ?? Node.Defaults.padding
    node.scaleToFitContent = scaleToFitContent
    
    if let image = image {
      node.image = image
    }

    if let icon = icon {
      node.icon = icon
    }

    if let iconSize = iconSize {
      node.iconSize = iconSize
    }

    if let selectedScale = selectedScale {
      node.selectedScale = selectedScale
    }
    
    if let deselectedScale = deselectedScale {
      node.deselectedScale = deselectedScale
    }
    
    if let animationDuration = animationDuration {
      node.animationDuration = TimeInterval(animationDuration)
    }
    
    if let selectedColor = selectedColor {
      node.selectedColor = selectedColor
    }
    
    if let selectedFontColor = selectedFontColor {
      node.selectedFontColor = selectedFontColor
    }
    
    if let radius = radius {
      node.update(radius: radius)
    }
  }
}

// MARK:- Setters
extension RNBubbleSelectNodeView {
  @objc func setId(_ id: String?) {
    self.id = id
  }
  
  @objc func setValue(_ value: CGFloat) {
    self.value = value
    updateNode()
  }

  @objc func setTitle(_ title: String?) {
    self.title = title
    updateNode()
  }

  @objc func setSubTitle(_ subTitle: String?) {
    self.subTitle = subTitle
    updateNode()
  }

  @objc func setPrefix(_ prefix: String?) {
    self.prefix = prefix
    updateNode()
  }

  @objc func setSurfix(_ surfix: String?) {
    self.surfix = surfix
    updateNode()
  }

  @objc func setIcon(_ icon: UIImage?) {
    self.icon = icon
    updateNode()
  }
  
  @objc func setImage(_ image: UIImage?) {
    self.image = image
    updateNode()
  }
  
  @objc func setColor(_ color: UIColor?) {
    self.color = color
    updateNode()
  }
  
  @objc func setRadius(_ radius: CGFloat) {
    self.radius = radius
    updateNode()
  }
  
  @objc func setMarginScale(_ marginScale: CGFloat) {
    self.marginScale = marginScale
  }
  
  // Label Styling
  @objc func setValueSize(_ fontSize: CGFloat) {
    self.valueSize = fontSize
    updateNode()
  }

  @objc func setTitleSize(_ fontSize: CGFloat) {
    self.titleSize = fontSize
    updateNode()
  }

  @objc func setSubTitleSize(_ fontSize: CGFloat) {
    self.subTitleSize = fontSize
    updateNode()
  }

  @objc func setIconSize(_ iconSize: CGFloat) {
    self.iconSize = iconSize
    updateNode()
  }
  
  @objc func setFontName(_ fontName: String?) {
    self.fontName = fontName
    updateNode()
  }
  
  @objc func setValueColor(_ fontColor: UIColor?) {
    self.valueColor = fontColor
    updateNode()
  }
  
  @objc func setTitleColor(_ fontColor: UIColor?) {
    self.titleColor = fontColor
    updateNode()
  }

  @objc func setSubTitleColor(_ fontColor: UIColor?) {
    self.subTitleColor = fontColor
    updateNode()
  }

  @objc func setLineHeight(_ lineHeight: CGFloat) {
    self.lineHeight = lineHeight
    updateNode()
  }
  
  @objc func setBorderColor(_ color: UIColor?) {
    self.borderColor = color
    updateNode()
  }
  
  @objc func setBorderWidth(_ width: CGFloat) {
    self.borderWidth = width
    updateNode()
  }
  
  @objc func setPadding(_ padding: CGFloat) {
    self.padding = padding
    updateNode()
  }
  
  @objc func setSelectedScale(_ selectedScale: CGFloat) {
    self.selectedScale = selectedScale
    updateNode()
  }
  
  @objc func setSelectedColor(_ selectedColor: UIColor?) {
    self.selectedColor = selectedColor
    updateNode()
  }
  
  @objc func setDeselectedScale(_ deselectedScale: CGFloat) {
    self.deselectedScale = deselectedScale
    updateNode()
  }
  
  @objc func setAnimationDuration(_ animationDuration: CGFloat) {
    self.animationDuration = animationDuration
    updateNode()
  }
  
  @objc func setSelectedFontColor(_ fontColor: UIColor?) {
    self.selectedFontColor = fontColor
    updateNode()
  }
  
  @objc func setAutoSize(_ autoSize: Bool) {
    self.scaleToFitContent = autoSize
    updateNode()
  }
}
