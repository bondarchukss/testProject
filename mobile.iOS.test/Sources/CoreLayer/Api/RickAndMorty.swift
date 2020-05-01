//
//  RickAndMorty.swift
//  mobile.iOS.test
//
//  Created by Sergey Bondarchuk on 11.02.2020.
//  Copyright © 2020 Sergey Bondarchuk. All rights reserved.
import Foundation
import Moya

enum RickAndMortyApi {
    case listOfCharacter
    case detailInfo (id: Int)
}

extension RickAndMortyApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://rickandmortyapi.com/api")!
    }
    var path: String {
        switch self {
        case .listOfCharacter:
            return "/character"
        case let .detailInfo (id):
            return "/character/\(id)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .listOfCharacter:
            return .get
        case .detailInfo:
            return .get
        }
    }
    var sampleData: Data {
        switch self {
        case .listOfCharacter:
            return Data()
        case .detailInfo:
            return Data()
        }
    }
    var task: Task {
        switch self {
        case .listOfCharacter:
            return .requestPlain
        case .detailInfo:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
