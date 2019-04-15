//
//  SignUpVC.swift
//  MOS-iOS
//
//  Created by 조우진 on 31/03/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import RxSwift
import RxCocoa
import UIKit

class SignUpVC : ASViewController<ASDisplayNode> {
    
        lazy var IdEditNode : ASEditableTextNode  = { () -> ASEditableTextNode in
            let node = ASEditableTextNode()
            node.style.preferredSize = CGSize(width: 280.0, height: 20)
            node.attributedPlaceholderText = NSAttributedString(string: "아이디를 입력해주세요.", attributes: [
                .font : UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor.gray])
            return node
        }()
    
        lazy var PassWordEditNode : ASEditableTextNode = { () -> ASEditableTextNode in
            let node = ASEditableTextNode()
            node.style.preferredSize = CGSize(width: 280.0, height: 20)
            node.attributedPlaceholderText = NSAttributedString(string: "비밀번호를 입력해주세요.", attributes: [
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor.gray])
            return node
        }()
    
        lazy var UserNameEditNode : ASEditableTextNode = { () -> ASEditableTextNode in
            let node = ASEditableTextNode()
            node.style.preferredSize = CGSize(width: 280.0, height: 20)
            node.attributedPlaceholderText = NSAttributedString(string: "닉네임을 입력해주세요.", attributes: [
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor.gray])
            return node
        }()
    
        lazy var underLineNode1 : ASDisplayNode = { () -> ASDisplayNode in
            let node = ASDisplayNode()
            node.style.preferredSize = CGSize(width: 280.0, height: 1)
            node.backgroundColor = .gray
            return node
        }()
    
        lazy var underLineNode2 : ASDisplayNode = { () -> ASDisplayNode in
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 280.0, height: 1)
        node.backgroundColor = .gray
        return node
    }()
   
        lazy var underLineNode3 : ASDisplayNode = { () -> ASDisplayNode in
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 280.0, height: 1)
        node.backgroundColor = .gray
        return node
    }()
    
    
        init() {
            super.init(node: ASDisplayNode())
            node.backgroundColor = .white
            node.automaticallyManagesSubnodes = true
    
            node.layoutSpecBlock = { [weak self] (_,_) in
                guard let strongSelf = self else { return ASLayoutSpec() }
    
                let idStackLayout = strongSelf.IdStackinit()
                let passwordStackLayout = strongSelf.PassWordStackinit()
                let usernameStackLayout = strongSelf.UserNameStackinit()
    
                let stackLayout = ASStackLayoutSpec(direction: .vertical, spacing: 70.0, justifyContent: .spaceBetween, alignItems: .center , children: [
                    idStackLayout,
                    passwordStackLayout,
                    usernameStackLayout])
    
                return ASInsetLayoutSpec(insets: .init(top: .infinity, left: .infinity, bottom: .infinity, right: .infinity), child: stackLayout)
            }
    
            node.onDidLoad { _ in
                self.navigationController?.isNavigationBarHidden = false
            }
        }
    
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    extension SignUpVC {
    
        func IdStackinit() -> ASStackLayoutSpec {
            return ASStackLayoutSpec(direction: .vertical,
                                     spacing: 5.0,
                                     justifyContent: .center,
                                     alignItems: .center,
                                     children: [IdEditNode, underLineNode1])
        }
    
        func PassWordStackinit() -> ASStackLayoutSpec {
            return ASStackLayoutSpec(direction: .vertical,
                                     spacing: 5.0,
                                     justifyContent: .center,
                                     alignItems: .center,
                                     children: [PassWordEditNode, underLineNode2])
        }
    
        func UserNameStackinit() -> ASStackLayoutSpec {
            return ASStackLayoutSpec(direction: .vertical,
                                     spacing: 5.0,
                                     justifyContent: .center,
                                     alignItems: .center,
                                     children: [UserNameEditNode, underLineNode3])
        }
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
    }
}
