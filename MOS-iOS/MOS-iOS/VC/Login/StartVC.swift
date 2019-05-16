//
//  LoginVC.swift
//  MOS-iOS
//
//  Created by 조우진 on 31/03/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa
import RxCocoa_Texture

class StartVC : ASViewController<ASDisplayNode> {
    var viewModel = StartViewModel()
    let disposeBag = DisposeBag()
    
    lazy var titleNode : ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "MOS", attributes: [
            .font: UIFont(name: "DIN Condensed", size: 55)!,
            .foregroundColor : Color.RED.getColor()])
        return node
    }()
    
    lazy var desc1Node : ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "내가 보고 싶은 것만,", attributes: [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor : UIColor.lightGray ])
        return node
    }()
    
    lazy var desc2Node : ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "나만의 작은 SNS", attributes: [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor : UIColor.lightGray ])
        return node
    }()
    
    lazy var SignInButtonNode : ASButtonNode = {
        let node = ASButtonNode()
        node.style.preferredSize = CGSize(width: 280.0, height: 50.0)
        node.cornerRadius = 25.0
        node.shadowOpacity = 0.5
        node.shadowOffset = CGSize.init(width: 1, height: 1)
        node.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        node.setTitle("로그인", with: UIFont.systemFont(ofSize: 15, weight: .medium), with: .white , for: UIControl.State.normal)
        node.backgroundColor = Color.RED.getColor()
        return node
    }()
    
    lazy var SignUpButtonNode : ASButtonNode = {
        let node = ASButtonNode()
        node.style.preferredSize = CGSize(width: 280.0, height: 50.0)
        node.cornerRadius = 25.0
        node.shadowOpacity = 0.5
        node.shadowOffset = CGSize.init(width: 1, height: 1)
        node.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        node.setTitle("회원가입", with: UIFont.systemFont(ofSize: 15, weight: .medium), with: .black , for: UIControl.State.normal)
        node.backgroundColor = .white
        node.borderWidth = 0.5
        return node
    }()
   
    
    init() {
        super.init(node: ASDisplayNode())
        
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = {[weak self] (_,_) -> ASLayoutSpec in
            guard  let strongSelf = self else { return ASLayoutSpec() }
            strongSelf.titleNode.style.spacingBefore = 50.0
            strongSelf.desc1Node.style.spacingAfter = 5.0
            strongSelf.desc2Node.style.spacingAfter = 250.0
            strongSelf.SignInButtonNode.style.spacingAfter = 10.0
            strongSelf.SignUpButtonNode.style.spacingAfter = 10.0
            
            return ASStackLayoutSpec(direction: .vertical,
                                     spacing: 0.5,
                                     justifyContent: .center,
                                     alignItems: .center,
                                     children: [strongSelf.titleNode,
                                                strongSelf.desc1Node,
                                                strongSelf.desc2Node,
                                                strongSelf.SignInButtonNode,
                                                strongSelf.SignUpButtonNode])
            
        }
        
        bindViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StartVC {
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
        SignInButtonNode.rx
            .tap(to: viewModel.SignInDidCilcked)
            .disposed(by: disposeBag)
        
        SignUpButtonNode.rx
            .tap(to: viewModel.SignUpDidClicked)
            .disposed(by: disposeBag)
        
        
        
        viewModel.SignUpResult
            .drive(onNext: { isTrue in
                if isTrue {
                    self.navigationController?.pushViewController(SignUpVC(), animated: true)
                }
            }).disposed(by: disposeBag)
        
        viewModel.SignInResult
            .drive(onNext: { isTrue in
                if isTrue {
                    self.navigationController?.pushViewController(SignInVC(), animated: true)
                }
            }).disposed(by: disposeBag)
    }
    
}



