//
//  PostWriteVC.swift
//  MOS-iOS
//
//  Created by 조우진 on 21/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import RxSwift
import RxCocoa

class PostWriteVC: ASViewController<ASDisplayNode> {
    let disposeBag = DisposeBag()
    
    lazy var postTitleInputNode: ASDisplayNode = PostTitleInputNode()
    
    lazy var categoryPickerNode = CategoryPickerNode()
    
    lazy var categoryTextNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.attributedText = NSAttributedString(string: "카테고리", attributes: PostWriteVC.categoryAttribute)
        return node
    }()
    
    lazy var postContentInputNode: ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.style.preferredSize = CGSize(width: 280.0, height: 300)
        node.borderWidth = 2
        node.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        node.cornerRadius = 10
        return node
    }()
    
    lazy var publishPostBtnNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = Color.RED.getColor()
        node.setAttributedTitle(NSAttributedString(string: "글 올리기",
                                                   attributes: [ .font: UIFont
                                                        .systemFont(ofSize: 20.0, weight: .medium),
                                                        .foregroundColor: UIColor.white]),for: .normal)
        node.style.preferredSize = CGSize(width: 280.0, height: 50.0)
        node.cornerRadius = 25.0
        return node
    }()
    
    init() {
        super.init(node: ASDisplayNode())
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        
        node.layoutSpecBlock = { [weak self] (_,_) -> ASLayoutSpec in
            guard let `self` = self else { return ASLayoutSpec() }
            
            self.publishPostBtnNode.style.spacingAfter = 100.0
            
            return ASStackLayoutSpec(direction: .vertical,
                                     spacing: 20.0,
                                     justifyContent: .center,
                                     alignItems: .center,
                                     children: [self.categoryTextNode,
                                                self.postTitleInputNode,
                                                self.postContentInputNode,
                                                self.publishPostBtnNode])
            
            
        }
        
        node.onDidLoad { _ in
            Observable.just(["일상","교육","금융","예술","스포츠","여행"])
                .bind(to: self.categoryPickerNode.pickerView.rx.itemTitles) { _, item in
                    return "\(item)"
            }.disposed(by: self.disposeBag)
            
            self.categoryTextNode.isUserInteractionEnabled = true
            self.categoryTextNode.addTarget(self, action: #selector(PostWriteVC.selectCategory), forControlEvents: .touchUpInside)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostWriteVC {
    static var categoryAttribute: [NSAttributedString.Key : Any]{
        return [.font: UIFont.systemFont(ofSize: 15.0),
                .foregroundColor: UIColor.black]
    }
}

extension PostWriteVC{
    @objc func selectCategory() {
        let alert = UIAlertController(title: "카테고리 선택", message: "", preferredStyle: .actionSheet)
        alert.isModalInPopover = true
        alert.view.addSubnode(categoryPickerNode)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

class PostTitleInputNode: ASDisplayNode{
    
    var titleInput: UITextField? {
        return self.view as? UITextField
    }
    
    override init() {
        super.init()
        self.setViewBlock { () -> UIView in
            let field = UITextField()
            field.attributedPlaceholder = NSAttributedString(string: "제목을 입력해주세요.", attributes: [
                .font: UIFont.systemFont(ofSize: 15.0, weight: .medium),
                .foregroundColor: UIColor.gray])
            return field
        }
        self.style.preferredSize = CGSize(width: 280.0, height: 30.0)
        self.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
}

