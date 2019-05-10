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

class SignUpViewModel {
    //Input
    let idInput = PublishRelay<String?>()
    let passwordInput = PublishRelay<String?>()
    let usernameInput = PublishRelay<String?>()
    let signUpDidClicked = PublishRelay<Void?>()
    
    //Output
    let status: Driver<Bool>
    
    struct Dependencies {
        let api: Api
    }
    
    private let dependencies = Dependencies(api: Api())
    
    init() {
        let InputsValid = PublishRelay.combineLatest(idInput,passwordInput,usernameInput) { ($0, $1, $2) }
            .asObservable()
        
        self.status = signUpDidClicked.asObservable()
            .withLatestFrom(InputsValid)
            .flatMapLatest { pair in
                let (id, password, username) = pair
                let params: Parameters = ["id": id!,
                              "password": password!,
                              "name": username!,
                              "imageurl": "",
                              "category": [""]]
                
                self.dependencies.api.SignUpRequest(params: params)
            }
            .map { if $0 == StatusCode.success { return true }
                   else { return false}
            }
            .asDriver(onErrorJustReturn: false)
    }
}
