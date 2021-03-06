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

protocol Login {
    func SignUpRequest(params: Parameters) -> Observable<StatusCode>
    func SignInRequest(params: Parameters) -> Observable<(StatusCode,String?)>
}

protocol Posts {
    func PostsList() -> Observable<[PostModel]>
    func PostDetail(id: String) -> Observable<PostModel?>
}


protocol APIProvider: Login, Posts {
    func statusCode(code: Int) -> StatusCode
}

class Api: APIProvider {
    private let connector = Connector()
    
    func statusCode(code: Int) -> StatusCode {
        switch code {
        case 200: return StatusCode.success
        default: return StatusCode.failure
        }
    }
    
    func SignUpRequest(params: Parameters) -> Observable<StatusCode> {
        return connector.post(path: MyPageApi.signup.getPath(),
                              params: params,
                              header: Header.Empty)
            .map{ res, _ -> StatusCode in
                print(res)
                if res.statusCode == 200 { return StatusCode.success }
                else { return StatusCode.failure }
        }
    }
    
    func SignInRequest(params: Parameters) -> Observable<(StatusCode, String?)> {
        return connector.post(path: MyPageApi.login.getPath(),
                              params: params,
                              header: Header.Empty)
            .map{ res, data -> (StatusCode, String?) in
                guard let response = try? JSONDecoder().decode(TokenModel.self, from: data)
                    else { return (StatusCode.failure, nil) }
                
                return (self.statusCode(code: res.statusCode),response.token)
        }
    }
    
    func PostsList() -> Observable<[PostModel]> {
        return connector.get(path: PostsApi.getpostlist.getPath(),
                             params: nil,
                             header: Header.Authorization)
            .map{ res,data -> [PostModel] in
                if res.statusCode == 500 { print("server error") }
                
                guard let response = try? JSONDecoder().decode(PostsListResponse.self, from: data)
                    else {
                        print("decode failure")
                        return []
                }
                
                return response.postlist
        }
    }
    
    func PostDetail(id: String) -> Observable<PostModel?> {
        print("fdsaasdf \(id)")
        return connector.get(path: PostsApi.getpostdetail.getPath(),
                             params: ["id" : id],
                             header: Header.Empty)
            .map { res, data -> PostModel? in
                if res.statusCode == 500 { print("server error") }
                
                guard let response = try? JSONDecoder().decode(PostModel.self,from: data) else {
                    print("decode failure")
                    return nil
                }
                
                return response
            }
    }
    
}
