//
//  SignUpVC.swift
//  MOS-iOS
//
//  Created by 조우진 on 31/03/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa
import RxCocoa_Texture

class SignUpVC : ASViewController<ASDisplayNode> {
    var viewModel: SignUpViewModel!
    let disposeBag = DisposeBag()
    
    lazy var profileImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 70.0, height: 70.0)
        node.cornerRadius = 35.0
        node.borderWidth = 2
        node.borderColor = UIColor.black.cgColor
        node.image = UIImage(named: "user")
        return node
    }()
    
    lazy var IdEditNode = IdInputNode()
    
    lazy var PassWordEditNode = PasswordInputNode()
    
    lazy var UserNameEditNode = UserNameInputNode()
    
    lazy var underLineNode1 : ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 280.0, height: 1)
        node.backgroundColor = .gray
        return node
    }()
    
    lazy var underLineNode2 : ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 280.0, height: 1)
        node.backgroundColor = .gray
        return node
    }()
    
    lazy var underLineNode3 : ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 280.0, height: 1)
        node.backgroundColor = .gray
        return node
    }()
    
    lazy var signUpBtnNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setTitle("회원가입", with: UIFont.systemFont(ofSize: 20), with: .white, for: .normal)
        node.style.preferredSize = CGSize(width: 280.0, height: 50)
        node.cornerRadius = 25.0
        node.backgroundColor = Color.RED.getColor()
        return node
    }()
    
    
    init() {
        super.init(node: ASDisplayNode())
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        
        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let strongSelf = self else { return ASLayoutSpec() }
            strongSelf.profileImageNode.style.spacingAfter = 30.0
            strongSelf.signUpBtnNode.style.spacingAfter = 50.0
            
            let idStackLayout = strongSelf.IdStackinit()
            let passwordStackLayout = strongSelf.PassWordStackinit()
            let usernameStackLayout = strongSelf.UserNameStackinit()
            
            let stackLayout = ASStackLayoutSpec(direction: .vertical, spacing: 50.0, justifyContent: .center, alignItems: .center , children: [
                strongSelf.profileImageNode,
                idStackLayout,
                passwordStackLayout,
                usernameStackLayout,
                strongSelf.signUpBtnNode])
            
            return ASInsetLayoutSpec(insets: .init(top: .infinity, left: .infinity, bottom: .infinity, right: .infinity), child: stackLayout)
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
}

extension SignUpVC {
    func bindViewModel(){
        viewModel = SignUpViewModel()
        
        IdEditNode.idField?.rx.text
            .orEmpty
            .bind(to: viewModel.idInput)
            .disposed(by: disposeBag)
        
        PassWordEditNode.passwordField?.rx.text
            .orEmpty
            .bind(to: viewModel.passwordInput)
            .disposed(by: disposeBag)
        
        UserNameEditNode.userNameField?.rx.text
            .orEmpty
            .bind(to: viewModel.usernameInput)
            .disposed(by: disposeBag)
        
        signUpBtnNode.rx
            .tap(to: viewModel.signUpDidClicked)
            .disposed(by: disposeBag)
        
        viewModel.status.asObservable()
            .subscribe(onNext: { [weak self] isSuccess in
                guard let `self` = self else { return }
                if isSuccess {
                    let alert = UIAlertController(title: "회원가입", message: "성공적으로 회원가입 되었습니다.", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.navigationController?.popToRootViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
}

class IdInputNode: ASDisplayNode {
    
    var idField: UITextField? {
        return self.view as? UITextField
    }
    
    override init() {
        super.init()
        self.setViewBlock { () -> UIView in
            let field = UITextField()
            field.attributedPlaceholder = NSAttributedString(string: "아이디를 입력해주세요.",attributes:
                [.font: UIFont.systemFont(ofSize: 15),
                 .foregroundColor: UIColor.gray])
            return field
        }
        self.style.preferredSize = CGSize(width: 280.0, height: 15.0)
    }
}

class PasswordInputNode: ASDisplayNode {
    
    var passwordField: UITextField? {
        return self.view as? UITextField
    }
    
    override init() {
        super.init()
        self.setViewBlock { () -> UIView in
            let field = UITextField()
            field.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해주세요.",attributes:
                [.font: UIFont.systemFont(ofSize: 15),
                 .foregroundColor: UIColor.gray])
            return field
        }
        self.style.preferredSize = CGSize(width: 280.0, height: 15.0)
    }
}

class UserNameInputNode: ASDisplayNode {
    
    var userNameField: UITextField? {
        return self.view as? UITextField
    }
    
    override init() {
        super.init()
        self.setViewBlock { () -> UIView in
            let field = UITextField()
            field.attributedPlaceholder = NSAttributedString(string: "이름을 입력해주세요.",attributes:
                [.font: UIFont.systemFont(ofSize: 15),
                 .foregroundColor: UIColor.gray])
            return field
        }
        self.style.preferredSize = CGSize(width: 280.0, height: 15.0)
    }
}
