//
//  PostsVC.swift
//  MOS-iOS
//
//  Created by 조우진 on 01/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import RxSwift
import RxCocoa

class PostsVC : ASViewController<ASScrollNode> {
    
    lazy var appNameNode : ASTextNode = { () -> ASTextNode in
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "MOS", attributes: [
            .font: UIFont(name: "DIN Condensed", size: 30)!,
            .foregroundColor: Color.RED.getColor()
            ])
        return node
    }()
    
    init() {
        super.init(node: ASScrollNode())
        node.scrollableDirections = .down
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        //        node.layoutSpecBlock = { [weak self] node, constrainedSize in
        //            let strongSelf = self; else { return ASLayoutSpec() }
        //            return ASInsetLayoutSpec(insets: .init(top: 0.0 , left: 0.0 , bottom: 0.0, right: 0.0), child: strongSelf.appNameNode )
        //        }
        
        node.onDidLoad { _ in
            let searchBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(PostsVC.goSearch))
            let writeBarButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(PostsVC.goWrite))
            let filterBarButton = UIBarButtonItem(image: UIImage(named: "filterIcon.png"), style: .plain, target: self, action: #selector(PostsVC.goFilter))
            
            self.navigationItem.rightBarButtonItems = [searchBarButton,writeBarButton,filterBarButton]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostsVC {
    @objc func goSearch(){
        
    }
    
    @objc func goWrite(){
        
    }
    
    @objc func goFilter(){
        
    }
}
