//
//  EmailSignInVC.swift
//  MOS-iOS
//
//  Created by 조우진 on 16/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import RxSwift
import RxCocoa

class SignInVC : ASViewController<ASDisplayNode>{
    var viewModel: LoginViewModel!
    let disposeBag = DisposeBag()
    
    lazy var titleNode: ASTextNode = { () -> ASTextNode in
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Login", attributes: [
            .font : UIFont(name: "DIN Condensed", size: 50)!,
            .foregroundColor : Color.RED.getColor()])
        return node
    }()
    
    lazy var idInputNode = IdInputNode()

    lazy var passwordInputNode = PasswordInputNode()
    
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
                                                                    passwordStackLayoutSpec])
            
            strongSelf.titleNode.style.spacingAfter = 100.0
            loginStackLayoutSpec.style.spacingAfter = 100.0
            strongSelf.signInButton.style.spacingAfter = 50.0
            
            return ASStackLayoutSpec(direction: .vertical,
                                     spacing: 0.0,
                                     justifyContent: .center,
                                     alignItems: .center,
                                     children: [strongSelf.titleNode,
                                                loginStackLayoutSpec,
                                                strongSelf.signInButton])
        }
        
        node.onDidLoad { _ in
            self.navigationController?.isNavigationBarHidden = false
        }
        bindViewModel()
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

extension SignInVC {
    
    func initTabBarController() -> UITabBarController{
        let tabBarController = UITabBarController()
        let posts = UINavigationController(rootViewController: PostsVC())
        let user = UINavigationController(rootViewController: MyPageVC())
        posts.tabBarItem = UITabBarItem(title: "posts", image: nil, selectedImage: nil)
        user.tabBarItem = UITabBarItem(title: "user", image: nil, selectedImage: nil)
        tabBarController.setViewControllers([posts, user], animated: false)
        return tabBarController
    }
    
    func bindViewModel() {
        viewModel = LoginViewModel()
        
        idInputNode.idField?.rx.text
            .orEmpty
            .bind(to: viewModel.signInIdInput)
            .disposed(by: disposeBag)
        
        passwordInputNode.passwordField?.rx.text
            .orEmpty
            .bind(to: viewModel.signInPasswordInput)
            .disposed(by: disposeBag)
        
        signInButton.rx
            .tap(to: viewModel.signInDidClicked)
            .disposed(by: disposeBag)
        
        viewModel.signInStatus.asObservable()
            .subscribe(onNext: { [weak self] isSuccess in
                guard let `self` = self else { return }
                if isSuccess {
                    self.present(self.initTabBarController(), animated: true, completion: nil)
                }
            })
        .disposed(by: disposeBag)
    }
}

