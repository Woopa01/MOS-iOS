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

final class StartViewModel {
    
    //Input
    let fbLoginDidClicked = PublishRelay<Void>()
    let emailSignUpDidClicked = PublishRelay<Void>()
    let emailSignInDidCilcked = PublishRelay<Void>()
    
    //Output
    var fbResult : Driver<Bool>
    var emailSignUpResult : Driver<Bool>
    var emailSignInResult : Driver<Bool>
    
    
    //    func transform(input: StartViewModel.Input) -> StartViewModel.Output {
    //        let fbResult = input.fbLoginDidClicked
    //            .asObservable()
    //            .map { return true }
    //            .asDriver(onErrorJustReturn: false)
    //
    //        let emailLoginResult = input.emailLoginDidClicked
    //            .asObservable()
    //            .map { return true }
    //            .asDriver(onErrorJustReturn: false)
    //
    //        let emailSignInResult = input.emailSignInDidCilcked
    //            .asObservable()
    //            .map { return true }
    //            .asDriver(onErrorJustReturn: false)
    //
    //        return Output(fbResult: fbResult,
    //                      emailLoginResult: emailLoginResult,
    //                      emailSignInResult: emailSignInResult)
    //    }
    
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
