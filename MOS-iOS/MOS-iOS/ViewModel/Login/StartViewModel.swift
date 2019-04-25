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
    let fbLoginDidClicked = PublishRelay<Void>()
    let emailSignUpDidClicked = PublishRelay<Void>()
    let emailSignInDidCilcked = PublishRelay<Void>()
    
    //Output
    var fbResult : Driver<Bool>
    var emailSignUpResult : Driver<Bool>
    var emailSignInResult : Driver<Bool>
    
    init() {
        self.fbResult = fbLoginDidClicked
            .asObservable()
            .map { return true }
            .asDriver(onErrorJustReturn: false)
        
        self.emailSignUpResult = emailSignUpDidClicked
            .asObservable()
            .map { return true }
            .asDriver(onErrorJustReturn: false)
        
        self.emailSignInResult = emailSignInDidCilcked
            .asObservable()
            .map { return true }
            .asDriver(onErrorJustReturn: false)
    }
    
    
}
