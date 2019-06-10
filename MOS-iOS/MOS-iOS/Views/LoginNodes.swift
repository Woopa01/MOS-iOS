//
//  LoginNodes.swift
//  MOS-iOS
//
//  Created by 조우진 on 16/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import AsyncDisplayKit

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
            field.textContentType = .password
            field.isSecureTextEntry = true
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

class CommentInputNode: ASDisplayNode {
    var commentField: UITextField? {
        return self.view as? UITextField
    }
    
    override init() {
        super.init()
        self.setViewBlock { () -> UIView in
            let field = UITextField()
            field.attributedPlaceholder = NSAttributedString(string: "댓글을 입력해주세요.", attributes:
                [.font: UIFont.systemFont(ofSize: 15),
                 .foregroundColor: UIColor.gray])
            return field
        }
        self.style.preferredSize = CGSize(width: 280.0, height: 15.0)

    }
}
