//
//  EmailSignInVC.swift
//  MOS-iOS
//
//  Created by 조우진 on 16/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class SignInVC : ASViewController<ASDisplayNode>{
    
    lazy var titleNode: ASTextNode = { () -> ASTextNode in
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Login", attributes: [
            .font : UIFont(name: "DIN Condensed", size: 50)!,
            .foregroundColor : Color.RED.getColor()])
        return node
    }()
    
    lazy var idInputNode: ASEditableTextNode = { () -> ASEditableTextNode in
        let node = ASEditableTextNode()
        node.style.preferredSize = CGSize(width: 280.0, height: 20)
        node.attributedPlaceholderText = NSAttributedString(string: "아이디를 입력해주세요.", attributes: [
            .font : UIFont.systemFont(ofSize: 20),
            .foregroundColor : UIColor.lightGray])
        return node
    }()
    
    lazy var passwordInputNode: ASEditableTextNode = { () -> ASEditableTextNode in
        let node = ASEditableTextNode()
        node.style.preferredSize = CGSize(width: 280.0, height: 20)
        node.attributedPlaceholderText = NSAttributedString(string: "비밀번호를 입력해주세요.", attributes: [
            .font : UIFont.systemFont(ofSize: 20),
            .foregroundColor : UIColor.lightGray])
        return node
    }()
    
    lazy var signInButton : ASButtonNode = { () -> ASButtonNode in
        let node = ASButtonNode()
        node.setTitle("로그인", with: UIFont.systemFont(ofSize: 20), with: .white, for: .normal)
        node.style.preferredSize = CGSize(width: 280.0, height: 50)
        node.cornerRadius = 25.0
        node.backgroundColor = Color.RED.getColor()
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
    
    init(){
        super.init(node: ASDisplayNode())
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let strongSelf = self else {return ASLayoutSpec()}
            
            let idStackLayoutSpec = strongSelf.idStackInit()
            let passwordStackLayoutSpec = strongSelf.passwordStackInit()
            let loginStackLayoutSpec = ASStackLayoutSpec(direction: .vertical,
                                                         spacing: 40.0,
                                                         justifyContent: .center,
                                                         alignItems: .center,
                                                         children: [idStackLayoutSpec,
                                                                    passwordStackLayoutSpec,
                                                                    strongSelf.signInButton])
            
            strongSelf.titleNode.style.spacingAfter = 200.0
            loginStackLayoutSpec.style.spacingAfter = 100.0
            
            return ASStackLayoutSpec(direction: .vertical,
                                     spacing: 0.0,
                                     justifyContent: .center,
                                     alignItems: .center,
                                     children: [strongSelf.titleNode,
                                                loginStackLayoutSpec])
        }
        
        node.onDidLoad { _ in
            self.navigationController?.isNavigationBarHidden = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignInVC {
    func idStackInit() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 5.0,
                                 justifyContent: .center,
                                 alignItems: .center,
                                 children: [idInputNode,underLineNode1])
    }
    
    func passwordStackInit() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 5.0,
                                 justifyContent: .center,
                                 alignItems: .center,
                                 children: [passwordInputNode,underLineNode2])
    }
    
   
}
