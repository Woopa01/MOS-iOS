//
//  MyPageVC.swift
//  MOS-iOS
//
//  Created by 조우진 on 01/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit

class MyPageVC : ASViewController<ASDisplayNode> {
    
    lazy var profileImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 70.0, height: 70.0)
        node.cornerRadius = 35
        node.borderWidth = 0.5
        node.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        return node
    }()
    
    lazy var usernameNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.attributedText = NSAttributedString(string: "hello", attributes: MyPageVC.usernameAttribute)
        return node
    }()
    
    lazy var myPostsListBtnNode: ASButtonNode = {
        let node = ASButtonNode()
        node.style.preferredSize = CGSize(width: 400.0, height: 50.0)
        node.borderWidth = 0.5
        node.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        node.setTitle("내가 쓴 글", with: UIFont.systemFont(ofSize: 20.0), with: .black, for: .normal)
        return node
    }()
    
    init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        
        node.layoutSpecBlock = {[weak self] (_,_) -> ASLayoutSpec in
            guard let `self` = self else { return ASLayoutSpec() }
           
            self.usernameNode.style.spacingAfter = 100.0
            self.myPostsListBtnNode.style.spacingAfter = 350.0
            
            return ASStackLayoutSpec(direction: .vertical,
                                     spacing: 30.0,
                                     justifyContent: .center,
                                     alignItems: .center,
                                     children: [self.profileImageNode,
                                                self.usernameNode,
                                                self.myPostsListBtnNode])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MyPageVC {
    static var usernameAttribute: [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 20.0, weight: .medium),
                .foregroundColor: UIColor.black]
    }
}
