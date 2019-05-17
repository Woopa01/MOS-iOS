//
//  PostsCell.swift
//  MOS-iOS
//
//  Created by 조우진 on 28/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class PostsCell : ASCellNode {
    
    lazy var authorImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 50.0, height: 50.0)
        node.cornerRadius = 25.0
        node.borderWidth = 0.5
        node.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        return node
    }()
    
    lazy var authorNameNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "author", attributes:
            defaultTextAttribute)
        node.maximumNumberOfLines = 1
        node.style.flexShrink = 1.0
        return node
    }()
    
    lazy var dateNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "date", attributes:
            defaultTextAttribute)
        node.maximumNumberOfLines = 1
        node.style.flexShrink = 1.0
        return node
    }()
    
    lazy var titleNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Title", attributes:
            titleTextAttribute)
        node.style.flexShrink = 1.0
        node.style.flexGrow = 0.0
        return node
    }()
    
    lazy var contentNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "content", attributes:
            [.foregroundColor: UIColor.black,
             .font: UIFont.systemFont(ofSize: 15, weight: .bold)])
        node.style.flexGrow = 1.0
        node.style.flexShrink = 1.0
        return node
    }()
    
    lazy var underLineNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 280.0, height: 1)
        node.backgroundColor = .gray
        return node
    }()
    
    lazy var likeBtnNode: ASButtonNode = {
        let node = ASButtonNode()
        node.style.preferredSize = CGSize(width: 25.0, height: 25.0)
        return node
    }()
    
    lazy var likeTotalNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "0", attributes: totalTextAttribute)
        node.style.flexShrink = 1.0
        node.maximumNumberOfLines = 1
        return node
    }()
    
    lazy var commentBtnNode: ASButtonNode = {
        let node = ASButtonNode()
        node.style.preferredSize = CGSize(width: 25.0, height: 25.0)
        return node
    }()
    
    lazy var commentTotalNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "0", attributes: totalTextAttribute)
        node.style.flexShrink = 1.0
        node.maximumNumberOfLines = 1
        return node
    }()
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.backgroundColor = .white
        self.selectionStyle = .none
    }
    
}

extension PostsCell {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let profileLayout = profileContentStackinit()
        let postLayout = postContentStackinit()
        let likeWithComment = postLikeWithCommentStackinit()
        
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 100.0,
                                 justifyContent: .center,
                                 alignItems: .center,
                                 children: [profileLayout,postLayout,likeWithComment])
    }
}

extension PostsCell {
    var defaultTextAttribute: [NSAttributedString.Key: Any] {
        return [.foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 15)]
    }
    
    var titleTextAttribute: [NSAttributedString.Key: Any] {
        return [.foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 20, weight: .bold)]
    }
    
    var totalTextAttribute: [NSAttributedString.Key: Any]{
        return [.foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 13, weight: .medium)]
    }
}

extension PostsCell{
    func profileTextStackinit() -> ASLayoutSpec{
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 0.0,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [authorNameNode,dateNode])
    }
    
    func profileContentStackinit() -> ASLayoutSpec{
        return ASStackLayoutSpec(direction: .horizontal,
                                 spacing: 0.0,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [authorImageNode,profileTextStackinit()])
    }
    
    func postContentStackinit() -> ASLayoutSpec{
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 0.0,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [titleNode,contentNode,underLineNode])
    }
    
    func likeContentStackinit() -> ASLayoutSpec{
        return ASStackLayoutSpec(direction: .horizontal,
                                 spacing: 0.0,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [likeBtnNode,likeTotalNode])
    }
    
    func commentContentStackinit() -> ASLayoutSpec{
        return ASStackLayoutSpec(direction: .horizontal,
                                 spacing: 0.0,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [commentBtnNode,commentTotalNode])
    }
    
    func likeInsetinit() -> ASLayoutSpec{
        return ASInsetLayoutSpec(insets: .init(top: 10.0,
                                               left: 10.0,
                                               bottom: 10.0,
                                               right: 10.0), child: likeContentStackinit())
    }
    
    func commentInsetinit() -> ASLayoutSpec{
        return ASInsetLayoutSpec(insets: .init(top: 10.0,
                                               left: 10.0,
                                               bottom: 10.0,
                                               right: 10.0), child: commentContentStackinit())
    }
    
    func postLikeWithCommentStackinit() -> ASLayoutSpec{
        return ASStackLayoutSpec(direction: .horizontal,
                                 spacing: 0.0,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [likeContentStackinit(),commentContentStackinit()])
    }
}

class ImageCarousels : ASCollectionNode {
    
}
