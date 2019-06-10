//
//  PostsViewModel.swift
//  MOS-iOS
//
//  Created by 조우진 on 29/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PostsViewModel{
    //Input
    let ready = PublishRelay<Void>()
    let cellSelected = PublishRelay<IndexPath>()
    
    //Output
    let postlist = BehaviorRelay<[PostModel]>(value: [])
    let selectedDone = BehaviorRelay<String>(value: "")
    
    let disposeBag = DisposeBag()
    
    struct Dependencies {
        let api: Api
    }
    
    private let dependencies = Dependencies(api: Api())
    
    init() {
        ready.asObservable()
            .flatMap {
                self.dependencies.api.PostsList()
            }
            .bind(to: postlist)
            .disposed(by: disposeBag)
        
        cellSelected.asObservable()
            .withLatestFrom(postlist) { indexpath, items in
                return items[indexpath.row]
            }
            .map { $0.postId }
            .bind(to: selectedDone)
            .disposed(by: disposeBag)
    }
}
