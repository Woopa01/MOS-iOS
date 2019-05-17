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
    
    //Output
    let postlist = BehaviorRelay<[PostModel]>(value: [])
    
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
    }
}
