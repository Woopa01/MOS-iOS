//
//  SignUpViewModel.swift
//  MOS-iOS
//
//  Created by 조우진 on 17/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum SignUpStatus {
    case success, failure
}

//class SignUpViewModel {
//    //Input
//    let idInput = PublishRelay<String?>()
//    let passwordInput = PublishRelay<String?>()
//    let usernameInput = PublishRelay<String?>()
//    let signUpDidClicked = PublishRelay<Void?>()
//    
//    //Output
//    let status: Driver<SignUpStatus>
//    
//    init() {
//        let InputsValid = PublishRelay.combineLatest(idInput,passwordInput,usernameInput) { ($0, $1, $2) }
//            .asObservable()
//        
//        self.status = signUpDidClicked
//            .asObservable()
//            .withLatestFrom(InputsValid)
//            .flatMapLatest({ pair -> Observable<Bool> in
//                let (id, password, username) = pair
//                return Observable<Bool>(true)
//            })
//            .map { $0 ? SignUpStatus.success : SignUpStatus.failure }
//            .asDriver(onErrorJustReturn: .failure)
//    }
//}
