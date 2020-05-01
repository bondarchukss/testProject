//
//  NetworkLayer.swift
//  mobile.iOS.test
//
//  Created by Сергей Бондарчук on 02.03.2020.
//  Copyright © 2020 Sergey Bondarchuk. All rights reserved.
//
//
//
import Moya

protocol NetworkClientType {
    func request(_ target: TargetType, callback: @escaping (Result<Response, Error>) -> Void)
}
class NetworkClient: NetworkClientType {
    func request(_ target: TargetType, callback: @escaping (Result<Response, Error>) -> Void ) {
        let provider = MoyaProvider<MultiTarget>()
        provider.request(MultiTarget(target)) { result in
            switch result {
            case .success(let response):
                callback(Result.success(response))
            case .failure(let error):
                callback(Result.failure(error))
            }
        }
    }
}
