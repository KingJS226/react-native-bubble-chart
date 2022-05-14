//
//  Extensions.swift
//  Magnetic
//
//  Created by KingJS226 on 5/9/2022.
//  Copyright © 2022 efremidze. All rights reserved.
//

import SpriteKit

@objcMembers open class Node: SKShapeNode {

    let category: UInt32 = 1 << 0
    
    public lazy var label: SKMultilineLabelNode = { [unowned self] in
        let label = SKMultilineLabelNode()
        label.fontName = Defaults.fontName
        label.valueFontSize = Defaults.fontSize
        label.titleFontSize = Defaults.fontSize
        label.subTitleFontSize = Defaults.fontSize
        label.valueColor = Defaults.fontColor
        label.titleColor = Defaults.fontColor
        label.subTitleColor = Defaults.fontColor
        label.verticalAlignmentMode = .center
        label.width = self.frame.width
        label.separator = " "
        addChild(label)
        return label
    }()
    
    open var id: String! {
      didSet {
        self.name = id
      }
    }

    open var prefix: String = ""
    open var surfix: String = ""

    open var value: CGFloat = 0 {
        didSet {
          guard value != 0 else { return self.valueLabel = nil }
          self.valueLabel = "\(value)"
          self.valueLabel = self.prefix + self.valueLabel!
          self.valueLabel = self.valueLabel! + self.surfix
        }
    }
    
    open var minWidth: CGFloat = 0
    
    /**
     The icon displayed by the node
     */
    open var icon: UIImage? {
        get { return label.icon }
        set {
            label.icon = newValue
            resize()
        }
    }
    
    open var iconSize: CGFloat? {
        get { return label.iconSize }
        set {
            label.iconSize = newValue
            resize()
        }
    }
    
    /**
     The text displayed by the node.
     */
    open var valueLabel: String? {
        get { return label.value }
        set {
            label.value = newValue
            resize()
        }
    }

    open var title: String? {
        get { return label.title }
        set {
            label.title = newValue
            resize()
        }
    }
    
    open var subTitle: String? {
        get { return label.subTitle }
        set {
            label.subTitle = newValue
            resize()
        }
    }
    
    /**
     The image displayed by the node.
     */
    open var image: UIImage? {
        didSet {
//            let url = URL(string: "https://picsum.photos/1200/600")!
//            let image = UIImage(data: try! Data(contentsOf: url))
            fillTexture = image.map { SKTexture(image: $0.aspectFill(self.frame.size)) }
            texture = image.map { SKTexture(image: $0.aspectFill(self.frame.size)) }
        }
    }
    
    /**
     The color of the node.
     
     Also blends the color with the image.
     */
    open var color: UIColor = Defaults.color {
        didSet {
            self.fillColor = color
        }
    }
    
    open var texture: SKTexture?
    
    /**
     The selection state of the node.
     */
    open var isSelected: Bool = false {
        didSet {
            guard isSelected != oldValue else { return }
            if isSelected {
                selectedAnimation()
            } else {
                deselectedAnimation()
            }
        }
    }
    
    /**
     The removal state of the node
     */
    open var isRemoved: Bool = false
    
    /**
     Controls whether the node should auto resize to fit its content
     */
    open var scaleToFitContent: Bool = Defaults.scaleToFitContent {
        didSet {
            resize()
        }
    }
    
    /**
     Additional padding to be applied on resize
     */
    open var padding: CGFloat = Defaults.padding {
        didSet {
            resize()
        }
    }
  
    /**
     The scale of the selected animation
    */
    open var selectedScale: CGFloat = 4 / 3
  
    /**
     The scale of the deselected animation
    */
    open var deselectedScale: CGFloat = 1

    /**
     The original color of the node before animation
    */
    private var originalColor: UIColor = Defaults.color
  
    /**
     The color of the seleted node
    */
    open var selectedColor: UIColor?
  
    /**
     The text color of the seleted node
    */
    open var selectedFontColor: UIColor?
  
    /**
     The original text color of the node before animation
     */
    private var originalFontColor: UIColor = Defaults.fontColor
    
    /**
     The duration of the selected/deselected animations
     */
    open var animationDuration: TimeInterval = 0.2
  
    /**
     The name of the label's font
    */
    open var fontName: String {
      get { label.fontName ?? Defaults.fontName }
      set {
        label.fontName = newValue
        resize()
      }
    }
    
    /**
     The size of the label's font
    */
    open var valueSize: CGFloat {
      get { label.valueFontSize }
      set {
        label.valueFontSize = newValue
        resize()
      }
    }
    
    open var titleSize: CGFloat {
      get { label.titleFontSize }
      set {
        label.titleFontSize = newValue
        resize()
      }
    }
    
    open var subTitleSize: CGFloat {
      get { label.subTitleFontSize }
      set {
        label.subTitleFontSize = newValue
        resize()
      }
    }
    
    /**
     The color of the label's font
    */
    open var valueColor: UIColor {
      get { label.valueColor ?? Defaults.fontColor }
      set { label.valueColor = newValue }
    }
    
    open var titleColor: UIColor {
      get { label.titleColor ?? Defaults.fontColor }
      set { label.titleColor = newValue }
    }
    
    open var subTitleColor: UIColor {
      get { label.subTitleColor ?? Defaults.fontColor }
      set { label.subTitleColor = newValue }
    }
    
    /**
     The margin scale of the node
     */
    open var marginScale: CGFloat = Defaults.marginScale {
      didSet {
        guard let path = path else { return }
        regeneratePhysicsBody(withPath: path)
      }
    }

    /**
     The border color of the node
     */
    open var borderColor: UIColor {
      get { strokeColor }
      set { strokeColor = newValue }
    }
    
    /**
     The border width of the node
     */
    open var borderWidth: CGFloat {
      get { lineWidth }
      set {
        lineWidth = newValue
        resize()
      }
    }
    
    open private(set) var radius: CGFloat?
    
    /**
     Set of default values
     */
    struct Defaults {
        static let fontName = "Avenir-Black"
        static let fontColor = UIColor.white
        static let fontSize = CGFloat(12)
        static let color = UIColor.clear
        static let marginScale = CGFloat(1.01)
        static let scaleToFitContent = false // backwards compatability
        static let padding = CGFloat(20)
        static let borderWidth = CGFloat(0)
        static let borderColor = UIColor.clear
    }
    
    /**
     Creates a node with a custom path.
     
     - Parameters:
        - text: The text of the node.
        - image: The image of the node.
        - color: The color of the node.
        - path: The path of the node.
        - marginScale: The margin scale of the node.
     
     - Returns: A new node.
     */
    public init(value: CGFloat, title: String? = nil, subTitle: String? = nil, prefix: String? = nil, surfix: String? = nil, image: UIImage? = nil, color: UIColor, path: CGPath, marginScale: CGFloat = 1.01) {
        super.init()
        self.path = path
        regeneratePhysicsBody(withPath: path)
        self.color = color
        self.strokeColor = .white
        _ = self.title
        self.prefix = prefix ?? ""
        self.surfix = surfix ?? ""
        self.value = value
        self.title = title
        self.subTitle = subTitle
        self.configure(image: image, color: color)
    }
    
    /**
     Creates a node with a circular path.
     
     - Parameters:
        - text: The text of the node.
        - image: The image of the node.
        - color: The color of the node.
        - radius: The radius of the node.
        - marginScale: The margin scale of the node.
     
     - Returns: A new node.
     */
    public convenience init(
        value: CGFloat,
        title: String? = nil,
        subTitle: String? = nil,
        prefix: String? = nil,
        surfix: String? = nil,
        image: UIImage? = nil,
        color: UIColor,
        valueColor: UIColor? = nil,
        titleColor: UIColor? = nil,
        descriptionColor: UIColor? = nil,
        valueSize: CGFloat? = nil,
        titleSize: CGFloat? = nil,
        subTitleSize: CGFloat? = nil,
        radius: CGFloat,
        marginScale: CGFloat = 1.01
    ) {
        let path = SKShapeNode(circleOfRadius: radius).path!
        self.init(value: value, title: title, subTitle: subTitle, prefix: prefix, surfix: surfix, image: image, color: color, path: path, marginScale: marginScale)
        self.subTitleColor = descriptionColor ?? Defaults.fontColor
        self.subTitleSize = subTitleSize ?? Defaults.fontSize
        self.titleColor = titleColor ?? Defaults.fontColor
        self.titleSize = titleSize ?? Defaults.fontSize
        self.valueColor = valueColor ?? Defaults.fontColor
        self.valueSize = valueSize ?? Defaults.fontSize
        generatePercentNode(radius: radius, percent: value)
    }

    open func configure(image: UIImage?, color: UIColor) {
        self.image = image
        self.color = color
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func removeFromParent() {
        removedAnimation() {
            super.removeFromParent()
        }
    }
  
    /**
     Resizes the node to fit its current content
     */
    public func resize() {
        guard scaleToFitContent else { return }

        var iconHeight: CGFloat = 0
        if icon != nil && iconSize != nil { iconHeight = iconSize! }
        var titleFontSize: CGSize = CGSize(width: 0, height: 0)
        var valueFontSize: CGSize = CGSize(width: 0, height: 0)
        var subTitleFontSize: CGSize = CGSize(width: 0, height: 0)

        if title != nil {
            let font = UIFont(name: fontName, size: titleSize)
            let fontAttributes = [NSAttributedString.Key.font: font]
            titleFontSize = (title! as NSString).size(withAttributes: fontAttributes)
        }
        
        if valueLabel != nil {
            let font = UIFont(name: fontName, size: valueSize)
            let fontAttributes = [NSAttributedString.Key.font: font]
            valueFontSize = (valueLabel! as NSString).size(withAttributes: fontAttributes)
        }
        
        if subTitle != nil {
            let font = UIFont(name: fontName, size: subTitleSize)
            let fontAttributes = [NSAttributedString.Key.font: font]
            subTitleFontSize = (subTitle! as NSString).size(withAttributes: fontAttributes)
        }
        
        let width = max(iconHeight, valueFontSize.width, titleFontSize.width, subTitleFontSize.width)
        let height = iconHeight + valueFontSize.height + titleFontSize.height + subTitleFontSize.height

        let distance = hypot(width / 2, height / 2)
        let radius = distance + 15

        update(radius: radius, withLabelWidth: distance)
    }
    
    /**
     Updates the radius of the node and sets the label width to a given width or the radius
     
      - Parameters:
        - radius: The new radius
        - withLabelWidth: A custom width for the text label
     */
    public func update(radius: CGFloat, withLabelWidth width: CGFloat? = nil) {
        guard let path = SKShapeNode(circleOfRadius: radius).path else { return }
        self.path = path
        self.label.width = width ?? radius
        self.radius = radius
        generatePercentNode(radius: radius, percent: self.value)
        regeneratePhysicsBody(withPath: path)
    }
    
    /**
     Regenerates the physics body with a given path after the path has changed .i.e. after resize
     */
    public func regeneratePhysicsBody(withPath path: CGPath) {
        self.physicsBody = {
          var transform = CGAffineTransform.identity.scaledBy(x: marginScale, y: marginScale)
          let body = SKPhysicsBody(polygonFrom: path.copy(using: &transform)!)
          body.allowsRotation = true
          body.friction = 0
          body.linearDamping = 3
          body.velocity = CGVector(dx: 1.0, dy: 1.0)
          body.categoryBitMask = category
          body.collisionBitMask = category
          body.contactTestBitMask = category
          return body
        }()
    }

    /**
     Generate the child node which shows percentage of this node
     */
    public func generatePercentNode(radius: CGFloat, percent: CGFloat = 0) {
        var percentAngle = (0.5 + (100 - percent) / 50) * .pi
        var clockwise = false
        if percent == 100 {
            clockwise = true
            percentAngle = 2.5 * .pi
        }

        self.physicsBody?.isDynamic = false
        var currentPosition = self.position
        let percentChild = self.childNode(withName: "percent")
        if percentChild != nil {
            currentPosition = (percentChild?.position)!
            self.removeChildren(in: [percentChild!])
        }

        let percentBgNode = SKShapeNode(path: UIBezierPath(arcCenter: currentPosition, radius: self.frame.size.width / 2 - 10, startAngle: 0, endAngle: 2 * .pi, clockwise: false).cgPath,
            centered: false)
        percentBgNode.strokeColor = UIColor(white: 0.8, alpha: 0.5)
        percentBgNode.name = "percent"
        percentBgNode.lineWidth = 4

        let percentNode = SKShapeNode(path: UIBezierPath(arcCenter: currentPosition, radius: self.frame.size.width / 2 - 10, startAngle: 0.5 * .pi, endAngle: percentAngle, clockwise: clockwise).cgPath, centered: false)
        percentNode.strokeColor = UIColor(white: 1, alpha: 0.7)
        percentNode.lineWidth = 4
        percentBgNode.addChild(percentNode)
        self.addChild(percentBgNode)
        self.physicsBody?.isDynamic = true
    }
    
    /**
     The animation to execute when the node is selected.
     */
    open func selectedAnimation() {
        self.originalFontColor = color
        self.originalColor = fillColor
        
        let scaleAction = SKAction.scale(to: selectedScale, duration: animationDuration)
        
        if let selectedFontColor = selectedFontColor {
            label.run(.colorTransition(from: originalFontColor, to: selectedFontColor))
        }
        
        if let selectedColor = selectedColor {
          run(.group([
            scaleAction,
            .colorTransition(from: originalColor, to: selectedColor, duration: animationDuration)
          ]))
        } else {
          run(scaleAction)
        }

        if let texture = texture {
          fillTexture = texture
        }
    }
    
    /**
     The animation to execute when the node is deselected.
     */
    open func deselectedAnimation() {
        let scaleAction = SKAction.scale(to: deselectedScale, duration: animationDuration)
        
        if let selectedColor = selectedColor {
          run(.group([
            scaleAction,
            .colorTransition(from: selectedColor, to: originalColor, duration: animationDuration)
          ]))
        } else {
          run(scaleAction)
        }
        
        if let selectedFontColor = selectedFontColor {
          label.run(.colorTransition(from: selectedFontColor, to: originalFontColor, duration: animationDuration))
        }

        // self.fillTexture = nil
    }
    
    /**
     The animation to execute when the node is removed.
     
     - important: You must call the completion block.
     
     - parameter completion: The block to execute when the animation is complete. You must call this handler and should do so as soon as possible.
     */
    open func removedAnimation(completion: @escaping () -> Void) {
        run(.group([.fadeOut(withDuration: animationDuration), .scale(to: 0, duration: animationDuration)]), completion: completion)
    }
    
}
