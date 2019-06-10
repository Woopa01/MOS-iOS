//
//  PostsDetailVC.swift
//  MOS-iOS
//
//  Created by 조우진 on 27/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import RxSwift
import RxCocoa
import RxCocoa_Texture

class PostsDetailVC: ASViewController<ASScrollNode>{
    var viewModel: PostsDetailViewModel!
    let disposeBag = DisposeBag()
    
    lazy var blankNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = .white
        node.style.preferredSize = CGSize(width: 30.0, height: 30.0)
        return node
    }()
    
    lazy var userProfileImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 50.0, height: 50.0)
        node.cornerRadius = 25
        node.borderWidth = 0.5
        node.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        return node
    }()
    
    lazy var userNameNode: ASTextNode = {
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
        node.style.preferredSize = CGSize(width: 200.0, height: 300.0)
        node.attributedText = NSAttributedString(string: "content", attributes:
            [.foregroundColor: UIColor.black,
             .font: UIFont.systemFont(ofSize: 15, weight: .bold)])
        node.style.flexGrow = 1.0
        node.style.flexShrink = 1.0
        return node
    }()
    
    lazy var likeBtnNode: ASButtonNode = {
        let node = ASButtonNode()
        node.style.flexShrink = 1.0
        node.style.flexGrow = 0.0
        node.setImage(UIImage(named: "empty_like")!, for: .normal)
        node.imageNode.style.preferredSize = CGSize(width: 30.0, height: 30.0)
        node.style.preferredSize = CGSize(width: 30.0, height: 30.0)
        return node
    }()
    
    lazy var likeTotalNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "0", attributes: totalTextAttribute)
        node.style.flexShrink = 1.0
        node.maximumNumberOfLines = 1
        return node
    }()
    
    lazy var commentTableNode: ASTableNode = {
        let node = ASTableNode()
        node.backgroundColor = .white
        //        node.delegate = self
        //        node.dataSource = self
        return node
    }()
    
    lazy var commentInputNode: ASDisplayNode = CommentInputNode()
    
    lazy var commentSendBtnNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setTitle("Send", with: UIFont.systemFont(ofSize: 15), with: UIColor.gray, for: .normal)
        node.style.preferredSize = CGSize(width: 50.0, height: 20.0)
        node.backgroundColor = Color.RED.getColor()
        return node
    }()
    
    init() {
        super.init(node: ASScrollNode())
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
                
        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let `self` = self else { return ASLayoutSpec() }
            let author = self.profileContentCell()
            let textContent = self.titleWithcontentStack()
            let likeContent = self.likeContentStack()
            let commentContent = self.commentContentStack()
            
            let postDetailContentStack = ASStackLayoutSpec(direction: .vertical,
                                                           spacing: 50.0,
                                                           justifyContent: .start,
                                                           alignItems: .stretch,
                                                           children: [author,textContent,
                                                                      likeContent,
                                                                      self.commentTableNode,
                                                                      commentContent])
            
            return postDetailContentStack
            
        }
        bindViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostsDetailVC {
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
                .font: UIFont.systemFont(ofSize: 15, weight: .medium)]
    }
}

extension PostsDetailVC {
    func profileTextContent() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 10.0,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [userNameNode, dateNode])
    }
    
    func profileContentCell() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .horizontal,
                                 spacing: 3.0,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [blankNode, userProfileImageNode, profileTextContent()])
    }
    
    func titleWithcontentStack() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 30.0,
                                 justifyContent: .center,
                                 alignItems: .center,
                                 children: [titleNode, contentNode])
    }
    
    func likeContentStack() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .horizontal,
                                 spacing: 10.0,
                                 justifyContent: .center,
                                 alignItems: .center,
                                 children: [likeBtnNode, likeTotalNode])
    }
    
    func commentContentStack() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .horizontal,
                                 spacing: 10.0,
                                 justifyContent: .center,
                                 alignItems: .center,
                                 children: [commentInputNode, commentSendBtnNode])
    }
}

extension PostsDetailVC {
    func bindViewModel(){
        viewModel = PostsDetailViewModel()
        
        viewModel.postId.accept(UserDefaults.standard.value(forKey: "postID") as! String)
        
    }
}

extension PostsDetailVC: ASTableDelegate, ASTableDataSource {
    
}
