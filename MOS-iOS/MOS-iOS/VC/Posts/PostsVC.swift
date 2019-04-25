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

class PostsVC : ASViewController<ASTableNode> {
    
    lazy var appNameNode : ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "MOS", attributes: [
            .font: UIFont(name: "DIN Condensed", size: 30)!,
            .foregroundColor: Color.RED.getColor()
            ])
        return node
    }()
    
    init() {
        let tableNode = ASTableNode(style: .plain)
        tableNode.backgroundColor = .white
        tableNode.automaticallyManagesSubnodes = true
        super.init(node: tableNode)
        
        
        
        node.onDidLoad { node in
            guard let strongNode = node as? ASTableNode else { return }
            strongNode.view.separatorStyle = .singleLine
            
            let searchBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(PostsVC.goSearch))
            let writeBarButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(PostsVC.goWrite))
            let filterBarButton = UIBarButtonItem(image: UIImage(named: "filterIcon.png"), style: .plain, target: self, action: #selector(PostsVC.goFilter))
            
            self.navigationItem.rightBarButtonItems = [searchBarButton,writeBarButton,filterBarButton]
        }
        
//        self.node.dataSource = self
//        self.node.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostsVC : ASTableDataSource, ASTableDelegate {
    
}

extension PostsVC {
    @objc func goSearch(){
        
    }
    
    @objc func goWrite(){
        
    }
    
    @objc func goFilter(){
        
    }
}
