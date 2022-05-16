//
//  Extensions.swift
//  Magnetic
//
//  Created by KingJS226 on 5/9/2022.
//  Copyright © 2022 efremidze. All rights reserved.
//

import SpriteKit

@objc public protocol MagneticDelegate: class {
    func magnetic(_ magnetic: Magnetic, didSelect node: Node)
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node)
    @objc optional func magnetic(_ magnetic: Magnetic, didRemove node: Node)
}

@objcMembers open class Magnetic: SKScene, SKPhysicsContactDelegate {
    
    /**
     The field node that accelerates the nodes.
     */
    open lazy var magneticField: SKFieldNode = { [unowned self] in
        let field = SKFieldNode.radialGravityField()
        self.addChild(field)
        return field
    }()
    
    /**
     Controls whether you can select multiple nodes.
     */
    open var allowsMultipleSelection: Bool = true
    
    
    /**
    Controls whether an item can be removed by holding down
     */
    open var removeNodeOnLongPress: Bool = false
    
    /**
     The length of time (in seconds) the node must be held on to trigger a remove event
     */
    open var longPressDuration: TimeInterval = 0.35
    
    open var isDragging: Bool = false
  
    /**
   Returns the magnetic nodes
   */
    open var nodes: [Node] {
        return children.compactMap { $0 as? Node }
    }
  
    /**
     The selected children.
     */
    open var selectedChildren: [Node] {
        return nodes.filter { $0.isSelected }
    }
    
    /**
     The removed children.
     */
    open var removedChildren: [Node] {
        return nodes.filter { $0.isRemoved }
    }
    
    /**
     The object that acts as the delegate of the scene.
     
     The delegate must adopt the MagneticDelegate protocol. The delegate is not retained.
     */
    open weak var magneticDelegate: MagneticDelegate?
    
    private var touchStarted: TimeInterval?

    private var touchStartLocation: CGPoint?
    
    private var movingNode: SKNode?
    
    override open var size: CGSize {
        didSet {
            configure()
        }
    }
    
    override public init(size: CGSize) {
        super.init(size: size)
        
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .white
        scaleMode = .aspectFill
        configure()
    }
    
    func configure() {
        let strength = Float(max(size.width, size.height))
        let radius = strength.squareRoot() * 100
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: { () -> CGRect in
            var frame = self.frame
            frame.size.width = CGFloat(radius)
            frame.origin.x -= frame.size.width / 2
            return frame
        }())
        
        magneticField.region = SKRegion(radius: radius)
        magneticField.minimumRadius = radius
        magneticField.strength = strength
        magneticField.position = CGPoint(x: size.width / 2, y: size.height / 2)
        magneticField.isEnabled = true
    }
    
    override open func addChild(_ node: SKNode) {
        var x = -node.frame.width // left
        if children.count % 2 == 0 {
            x = frame.width + node.frame.width // right
        }
        let y = CGFloat.random(node.frame.height, frame.height - node.frame.height)
        node.position = CGPoint(x: x, y: y)
        super.addChild(node)
    }

    public func didBegin(_ contact: SKPhysicsContact) {
        let contactPoint = contact.contactPoint
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        
        let positionA = nodeA.position
        let positionB = nodeB.position
        
        var contactNode = nodeB
        var x = positionB.x - contactPoint.x
        var y = positionB.y - contactPoint.y
        var distance = positionA.distance(from: contactPoint)
        var implus = contact.collisionImpulse
        
//        guard movingNode != nil else {
//            let lengthOfChildren = children.count
//            guard lengthOfChildren > 2, lengthOfChildren < 6 else {
//                magneticField.position = CGPoint(x: size.width / 2, y: size.height / 2)
//                return
//            }
//            let centerNode = node(at: magneticField.position)
//            let contacts = centerNode?.physicsBody?.allContactedBodies().count ?? 0
//            if contacts == lengthOfChildren - 2 {
//                var xAxisArray = [CGFloat]()
//                var yAxisArray = [CGFloat]()
//                
//                for child in children {
//                    xAxisArray.append(child.position.x - child.frame.size.width / 2)
//                    xAxisArray.append(child.position.x + child.frame.size.width / 2)
//                    yAxisArray.append(child.position.y - child.frame.size.height / 2)
//                    yAxisArray.append(child.position.y + child.frame.size.height / 2)
//                }
//                
//                let xMin = Float(xAxisArray.min() ?? 0)
//                let yMax = Float(yAxisArray.max() ?? 0)
//                let width = Float(xAxisArray.max() ?? 0) - xMin
//                let height = yMax - Float(yAxisArray.min() ?? 0)
//                
//                let x = (Float(size.width) - width) / 2
//                let y = (Float(size.height) - height) / 2
//                
//                let current = CGPoint(x: size.width / 2, y: size.height / 2)
//                
//                print(">>>>>>>>", x, xMin, y, yMax)
//                
//                if x != xMin || y != yMax {
//                    magneticField.position = CGPoint(x: current.x - CGFloat(xMin - x), y: current.y - CGFloat(yMax - y))
//                }
//                
//            }
//            return
//        }
        
        if (movingNode === nodeB) {
            contactNode = nodeA
            x = positionA.x - contactPoint.x
            y = positionA.y - contactPoint.y
            distance = positionB.distance(from: contactPoint)
            implus = contact.collisionImpulse * -1
        }

        if (movingNode === nodeA || movingNode === nodeB) {
            let acceleration: CGFloat = pow(distance, 1/2)
            let direction = CGVector(dx: 20 * contact.contactNormal.dx * implus, dy: 20 * contact.contactNormal.dy * implus)
            contactNode.physicsBody?.applyImpulse(direction)
        }
    }
    
}

extension Magnetic {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard removeNodeOnLongPress, let touch = touches.first else { return }
        touchStarted = touch.timestamp
        touchStartLocation = touch.location(in: self)
        movingNode = node(at: touchStartLocation!)
        movingNode?.physicsBody?.isDynamic = false
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let previous = touch.previousLocation(in: self)
        guard location.distance(from: previous) != 0 else {
            return
        }
        
        isDragging = true
        
        moveNode(location: location, previous: previous)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        defer { isDragging = false; movingNode?.physicsBody?.isDynamic = true; movingNode = nil }
        guard !isDragging, let node = node(at: location) else { return }
                
        if removeNodeOnLongPress && !node.isSelected {
            guard let touchStarted = touchStarted else { return }
            let touchEnded = touch.timestamp
            let timeDiff = touchEnded - touchStarted
            
            if (timeDiff >= longPressDuration) {
                node.removedAnimation {
                    node.isRemoved = true
                    self.magneticDelegate?.magnetic?(self, didRemove: node)
                }
                return
            }
        }
        
        if node.isSelected {
            node.isSelected = false
            magneticDelegate?.magnetic(self, didDeselect: node)
        } else {
            if !allowsMultipleSelection, let selectedNode = selectedChildren.first {
                selectedNode.isSelected = false
                magneticDelegate?.magnetic(self, didDeselect: selectedNode)
            }
            node.isSelected = true
            magneticDelegate?.magnetic(self, didSelect: node)
        }
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        movingNode?.physicsBody?.isDynamic = true
        movingNode = nil
        isDragging = false
    }
    
}

extension Magnetic {
    
    open func moveNodes(location: CGPoint, previous: CGPoint) {
        let x = location.x - previous.x
        let y = location.y - previous.y
        
        for node in children {
            let distance = node.position.distance(from: location)
            let acceleration: CGFloat = 3 * pow(distance, 1/2)
            let direction = CGVector(dx: x * acceleration, dy: y * acceleration)
            node.physicsBody?.applyImpulse(direction)
        }
    }

    open func moveNode(location: CGPoint, previous: CGPoint) {
        let x = location.x - previous.x
        let y = location.y - previous.y
        
        let node = self.node(at: previous)
        let distance = location.distance(from: previous)
        let acceleration: CGFloat = pow(distance, 1/3)
        let direction = CGVector(dx: 1, dy: 1)
        node?.position =  CGPoint(x: (node?.position.x)! + x, y: (node?.position.y)! + y)
    }
    
    open func node(at point: CGPoint) -> Node? {
        return nodes(at: point).compactMap { $0 as? Node }.filter { $0.path!.contains(convert(point, to: $0)) }.first
    }

    open func getMovingNode() -> Node? {
        return children.compactMap { $0 as? Node }.filter { abs(($0.physicsBody?.velocity.dx) ?? 0) < 0.1 && abs(($0.physicsBody?.velocity.dy) ?? 0) < 0.1 }.first
    }
    
}
