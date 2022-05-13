//
//  Extensions.swift
//  Magnetic
//
//  Created by KingJS226 on 5/9/2022.
//  Copyright © 2022 efremidze. All rights reserved.
//

import SpriteKit

@objcMembers open class SKMultilineLabelNode: SKShapeNode {
    
    open var value: String? { didSet { update() } }
    open var title: String? { didSet { update() } }
    open var subTitle: String? { didSet { update() } }
    
    open var iconNode: SKShapeNode?
    open var icon: UIImage? { didSet { update() } }
    
    open var iconSize: CGFloat? { didSet { update() } }
    
    open var fontName: String? { didSet { update() } }

    open var valueFontSize: CGFloat = 32 { didSet { update() } }
    open var titleFontSize: CGFloat = 32 { didSet { update() } }
    open var subTitleFontSize: CGFloat = 32 { didSet { update() } }

    open var valueColor: UIColor? { didSet { update() } }
    open var titleColor: UIColor? { didSet { update() } }
    open var subTitleColor: UIColor? { didSet { update() } }
    
    open var separator: String? { didSet { update() } }
    
    open var verticalAlignmentMode: SKLabelVerticalAlignmentMode = .baseline { didSet { update() } }
    open var horizontalAlignmentMode: SKLabelHorizontalAlignmentMode = .center { didSet { update() } }
    
    open var lineHeight: CGFloat? { didSet { update() } }
    
    open var width: CGFloat! { didSet { update() } }
    
    func update() {
        self.removeAllChildren()

        var valueStack = Stack<String>()
        var titleStack = Stack<String>()
        var subTitleStack = Stack<String>()
        
        if icon != nil, iconSize != nil {
            iconNode = SKShapeNode(rect: CGRect(x: self.frame.width / 2, y: self.frame.height / 2, width: iconSize!, height: iconSize!))
            iconNode?.fillTexture = icon.map { SKTexture(image: $0.aspectFill(CGSize(width: iconSize!, height: iconSize!))) }
            iconNode?.fillColor = .white
            iconNode?.strokeColor = .clear
            self.addChild(iconNode!)
        }

        if value != nil {
            let value = value!
            var sizingLabel = makeSizingLabel()
            let words = separator.map { value.components(separatedBy: $0) } ?? value.map { String($0) }
            for (index, word) in words.enumerated() {
                sizingLabel.text += word
                if sizingLabel.frame.width > width, index > 0 {
                    valueStack.add(toStack: word)
                    sizingLabel = makeSizingLabel()
                } else {
                    valueStack.add(toCurrent: word)
                }
            }
        }
        
        if title != nil {
            let title = title!
            var sizingLabel = makeSizingLabel()
            let words = separator.map { title.components(separatedBy: $0) } ?? title.map { String($0) }
            for (index, word) in words.enumerated() {
                sizingLabel.text += word
                if sizingLabel.frame.width > width, index > 0 {
                    titleStack.add(toStack: word)
                    sizingLabel = makeSizingLabel()
                } else {
                    titleStack.add(toCurrent: word)
                }
            }
        }
        
        if subTitle != nil {
            let subTitle = subTitle!
            var sizingLabel = makeSizingLabel()
            let words = separator.map { subTitle.components(separatedBy: $0) } ?? subTitle.map { String($0) }
            for (index, word) in words.enumerated() {
                sizingLabel.text += word
                if sizingLabel.frame.width > width, index > 0 {
                    subTitleStack.add(toStack: word)
                    sizingLabel = makeSizingLabel()
                } else {
                    subTitleStack.add(toCurrent: word)
                }
            }
        }
        
        let valueLines = valueStack.values.map { $0.joined(separator: separator ?? "") }
        let titleLines = titleStack.values.map { $0.joined(separator: separator ?? "") }
        let subTitleLines = subTitleStack.values.map { $0.joined(separator: separator ?? "") }
        var valueHeight: CGFloat = CGFloat(valueLines.count) * (lineHeight ?? valueFontSize)
        var titleHeight: CGFloat = CGFloat(titleLines.count) * (lineHeight ?? titleFontSize)
        let subTitleHeight: CGFloat = CGFloat(subTitleLines.count) * (lineHeight ?? subTitleFontSize)
        var iconHeight = iconSize ?? 0
        
        if valueLines.count != 0 && (titleLines.count != 0 || subTitleLines.count != 0) {
            valueHeight = valueHeight + 2
        }
        
        if subTitleLines.count != 0 && (valueLines.count != 0 || titleLines.count != 0) {
            titleHeight = titleHeight + 2
        }
        
        var height = valueHeight + titleHeight + subTitleHeight
        
        if iconNode != nil {
            height = height + iconHeight + 4
            iconHeight = iconHeight + 4
            let yPoint = (height / 2) - iconHeight + 4
            iconNode?.position = (CGPoint(x: self.frame.width / 2 - iconSize! / 2, y: yPoint))
        }

        for (index, line) in valueLines.enumerated() {
            let label = SKLabelNode(fontNamed: fontName)
            label.text = line
            label.fontSize = valueFontSize
            label.fontColor = valueColor
            label.verticalAlignmentMode = verticalAlignmentMode
            label.horizontalAlignmentMode = horizontalAlignmentMode
            let y = (height / 2) - iconHeight - (CGFloat(index) + 0.5) * (lineHeight ?? valueFontSize)
            label.position = CGPoint(x: 0, y: y)
            self.addChild(label)
        }
        
        for (index, line) in titleLines.enumerated() {
            let label = SKLabelNode(fontNamed: fontName)
            label.text = line
            label.fontSize = titleFontSize
            label.fontColor = titleColor
            label.verticalAlignmentMode = verticalAlignmentMode
            label.horizontalAlignmentMode = horizontalAlignmentMode
            let y = (height / 2) - iconHeight - valueHeight - (CGFloat(index) + 0.5) * (lineHeight ?? titleFontSize)
            label.position = CGPoint(x: 0, y: y)
            self.addChild(label)
        }
        
        for (index, line) in subTitleLines.enumerated() {
            let label = SKLabelNode(fontNamed: fontName)
            label.text = line
            label.fontSize = subTitleFontSize
            label.fontColor = subTitleColor
            label.verticalAlignmentMode = verticalAlignmentMode
            label.horizontalAlignmentMode = horizontalAlignmentMode
            let y = (height / 2) - iconHeight - valueHeight - titleHeight - (CGFloat(index) + 0.5) * (lineHeight ?? subTitleFontSize)
            label.position = CGPoint(x: 0, y: y)
            self.addChild(label)
        }
    }
    
    private func makeSizingLabel() -> SKLabelNode {
        let label = SKLabelNode(fontNamed: fontName)
        label.fontSize = titleFontSize
        return label
    }
    
}

private struct Stack<U> {
    typealias T = (stack: [[U]], current: [U])
    private var value: T
    var values: [[U]] {
        return value.stack + [value.current]
    }
    init() {
        self.value = (stack: [], current: [])
    }
    mutating func add(toStack element: U) {
        self.value = (stack: value.stack + [value.current], current: [element])
    }
    mutating func add(toCurrent element: U) {
        self.value = (stack: value.stack, current: value.current + [element])
    }
}

private func +=(lhs: inout String?, rhs: String) {
    lhs = (lhs ?? "") + rhs
}
