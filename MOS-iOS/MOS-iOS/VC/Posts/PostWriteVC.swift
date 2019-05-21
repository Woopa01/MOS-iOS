//
//  PostWriteVC.swift
//  MOS-iOS
//
//  Created by 조우진 on 21/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class PostWriteVC: ASViewController<ASDisplayNode> {
    
    lazy var postTitleInputNode: ASDisplayNode = PostTitleInputNode()
    
    lazy var postContentInputNode: ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.style.preferredSize = CGSize(width: 280.0, height: 300)
        node.borderWidth = 2
        node.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        node.cornerRadius = 10
        return node
    }()
    
    init() {
        super.init(node: ASDisplayNode())
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        
        node.layoutSpecBlock = { [weak self] (_,_) -> ASLayoutSpec in
            guard let `self` = self else { return ASLayoutSpec() }
            
            self.postContentInputNode.style.spacingAfter = 100.0
            
            return ASStackLayoutSpec(direction: .vertical,
                                     spacing: 20.0,
                                     justifyContent: .center,
                                     alignItems: .center,
                                     children: [self.postTitleInputNode, self.postContentInputNode])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PostTitleInputNode: ASDisplayNode{
    
    var titleInput: UITextField? {
        return self.view as? UITextField
    }
    
    override init() {
        super.init()
        self.setViewBlock { () -> UIView in
            let field = UITextField()
            field.attributedPlaceholder = NSAttributedString(string: "제목을 입력해주세요.", attributes: [
                .font: UIFont.systemFont(ofSize: 15.0, weight: .medium),
                .foregroundColor: UIColor.gray])
//            field.borderStyle = .roundedRect
            return field
        }
        self.style.preferredSize = CGSize(width: 280.0, height: 30.0)
        self.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
}
