//
//  SignUpViewModel.swift
//  MOS-iOS
//
//  Created by 조우진 on 17/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class LoginViewModel {
    //Input
    let signUpIdInput = BehaviorRelay<String>(value: "")
    let signUpPasswordInput = BehaviorRelay<String>(value: "")
    let signUpUsernameInput = BehaviorRelay<String>(value: "")
    let signUpDidClicked = PublishRelay<Void>()
    
    let signInIdInput = BehaviorRelay<String>(value: "")
    let signInPasswordInput = BehaviorRelay<String>(value: "")
    let signInDidClicked = PublishRelay<Void>()
    
    //Output
    let signUpStatus = BehaviorRelay<Bool>(value: false)
    let signInStatus = BehaviorRelay<Bool>(value: false)
    
    let disposeBag = DisposeBag()
    
    struct Dependencies {
        let api: Api
    }
    
    private let dependencies = Dependencies(api: Api())
    
    init() {
        let signUpInputsValid = BehaviorRelay
            .combineLatest(signUpIdInput,signUpPasswordInput,signUpUsernameInput) { ($0, $1, $2) }
            .asObservable()
        
        let signInInputValid = BehaviorRelay
            .combineLatest(signInIdInput, signInPasswordInput) { ($0,$1) }
            .asObservable()
        
        signUpDidClicked.asObservable()
            .withLatestFrom(signUpInputsValid)
            .flatMapLatest { pair -> Observable<StatusCode> in
                let (id, password, username) = pair
                let params: Parameters = ["id": id,
                                          "password": password,
                                          "name": username]
                
                return self.dependencies.api.SignUpRequest(params: params)
            }
            .map { if $0 == StatusCode.success { return true }
            else { return false}
            }.bind(to: signUpStatus)
            .disposed(by: disposeBag)
        
        signInDidClicked.asObservable()
            .withLatestFrom(signInInputValid)
            .flatMapLatest { pair -> Observable<(StatusCode,String?)> in
                let (id, password) = pair
                let params: Parameters = ["id": id, "password": password]
                return self.dependencies.api.SignInRequest(params: params)
            }
            .map { status, token in
                if status == StatusCode.success, token != nil {
                    UserDefaults.standard.set(token, forKey: "token")
                    print(UserDefaults.standard.value(forKey: "token" as! String))
                    return true
                } else { return false }
            }
            .bind(to: signInStatus)
            .disposed(by: disposeBag)
        
    }
}
