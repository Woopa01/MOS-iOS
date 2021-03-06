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
import RxCocoa_Texture

class PostsVC : ASViewController<ASTableNode> {
    var postList: [PostModel] = []
    var viewModel: PostsViewModel!
    let disposeBag = DisposeBag()
    
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
        
        self.node.dataSource = self
        self.node.delegate = self
        
        viewModel = PostsViewModel()
        bindViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostsVC : ASTableDelegate ,ASTableDataSource{
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard self.postList.count > indexPath.row else { return { ASCellNode() } }
        
        let viewModel = PostCellViewModel(model: self.postList[indexPath.row])
        
        return{
            let cell = PostsCell(viewModel: viewModel)
            return cell
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.postList.count
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellSelected.accept(indexPath)
                
        viewModel.selectedDone.asObservable()
            .subscribe(onNext: { postId in
                UserDefaults.standard.set(postId, forKey: "postID")
            })
            .disposed(by: disposeBag)
        
        self.navigationController?.pushViewController(PostsDetailVC(), animated: true)
    }
}

extension PostsVC{
    func bindViewModel(){
        rx.viewWillAppear
            .bind(to: viewModel.ready)
            .disposed(by: disposeBag)
        
        viewModel.postlist.asObservable()
            .subscribe(onNext: { [weak self] data in
                guard let `self` = self else { return }
                self.postList = data
                self.node.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
}

extension PostsVC {
    @objc func goSearch(){
        
    }
    
    @objc func goWrite(){
        self.navigationController?.pushViewController(PostWriteVC(), animated: true)
    }
    
    @objc func goFilter(){
        let alert = UIAlertController(title: "Filtering", message: "보고싶은 카테고리를 골라주세요.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "일상", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "교육", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "금융", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "예술", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "스포츠", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "여행", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
