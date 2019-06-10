//
//  PostsDetailViewModel.swift
//  MOS-iOS
//
//  Created by 조우진 on 28/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PostsDetailViewModel {
    //Input
    let postId = BehaviorRelay<String>(value: "")
    
    //Output
    let authorName = BehaviorRelay<String>(value: "")
    let date = BehaviorRelay<String>(value: "")
    let title = BehaviorRelay<String>(value: "")
    let content = BehaviorRelay<String>(value: "")
    let isVoted = BehaviorRelay<Bool>(value: false)
    let comments = BehaviorRelay<[CommentModel]>(value: [])
    let voteCount = BehaviorRelay<String>(value: "")
    let commentCount = BehaviorRelay<String>(value: "")
    
    init() {
        let api = Api()
        let disposeBag = DisposeBag()
        
        postId.asObservable()
            .flatMap { api.PostDetail(id: $0) }
            .subscribe(onNext: { [weak self] model in
                guard let `self` = self else { return }
                self.authorName.accept(model?.postAuthor ?? "")
                self.date.accept(model?.date ?? "")
                self.title.accept(model?.postTitle ?? "")
                self.content.accept(model?.postContent ?? "")
                self.isVoted.accept(model?.isVoted ?? false)
                self.comments.accept(model?.comment ?? [])
            })
        .disposed(by: disposeBag)
    }
    
}
