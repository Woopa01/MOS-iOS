//
//  API.swift
//  MOS-iOS
//
//  Created by 조우진 on 29/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol SignUp {
    func SignUpRequest(params: Parameters) -> Observable<StatusCode>
}

protocol APIProvider: SignUp { }

class Api: APIProvider {
    private let connector = Connector()

    func SignUpRequest(params: Parameters) -> Observable<StatusCode> {
        return connector.get(path: MyPageApi.signup.getPath(),
                             params: params,
                             header: Header.Empty)
            .map{ res, _ -> StatusCode in
                if res.statusCode == 200 { return StatusCode.success }
                else { return StatusCode.failure }
        }
    }
}
