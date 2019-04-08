//
//  ViewController.swift
//  MOS-iOS
//
//  Created by 조우진 on 26/03/2019.
//  Copyright © 2019 조우진. All rights reserved.
//


import AsyncDisplayKit
import RxSwift
import RxCocoa

class MainVC : ASViewController<ASScrollNode> {
    
    lazy var appNameNode : ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "MOS", attributes: [
            .font: UIFont(name: "DIN Condensed", size: 30),
            .foregroundColor: Color.RED.getColor()
            ])
        return node
    }()
    
    init() {
        super.init(node: ASScrollNode())
        node.scrollableDirections = .down
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.layoutSpecBlock = { [weak self] node, constrainedSize in
            let strongSelf = self; else { return ASLayoutSpec() }
            return ASInsetLayoutSpec(insets: .init(top: 0.0 , left: 0.0 , bottom: 0.0, right: 0.0), child: strongSelf.appNameNode )
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
