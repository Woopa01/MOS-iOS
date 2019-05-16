//
//  LoginViewModel.swift
//  MOS-iOS
//
//  Created by 조우진 on 17/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class StartViewModel {
    
    //Input
    let SignUpDidClicked = PublishRelay<Void>()
    let SignInDidCilcked = PublishRelay<Void>()
    
    //Output
    var SignUpResult : Driver<Bool>
    var SignInResult : Driver<Bool>
    
    init() {
        
        self.SignUpResult = SignUpDidClicked
            .asObservable()
            .map { return true }
            .asDriver(onErrorJustReturn: false)
        
        self.SignInResult = SignInDidCilcked
            .asObservable()
            .map { return true }
            .asDriver(onErrorJustReturn: false)
    }
    
    
}
