//
//  PostCellViewModel.swift
//  MOS-iOS
//
//  Created by 조우진 on 17/05/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PostCellViewModel {
    //Output
    let authorName: Observable<String>
    let title: Observable<String>
    let content: Observable<String>
    let category: Observable<String>
    let date: Observable<String>
    let voteCount: Observable<String>
    let commentCount: Observable<String>
    
    init(model: PostModel) {
        self.authorName = Observable.just(model.postAuthor)
        self.title = Observable.just(model.postTitle)
        self.content = Observable.just(model.postContent)
        self.category = Observable.just(model.category)
        self.date = Observable.just(model.date)
        self.voteCount = Observable.just(String(model.voteCount))
        self.commentCount = Observable.just(String(model.commentCount))
    }
}
