//
//  ServiceOfRickAndMorty.swift
//  mobile.iOS.test
//
//  Created by Сергей Бондарчук on 02.03.2020.
//  Copyright © 2020 Sergey Bondarchuk. All rights reserved.
//
import Foundation
import Moya

protocol RickAndMortyType {
    func listOfCharacter(callback: @escaping (RickAndMortyDTO) -> Void)
    func detailInfo(id: Int, callback: @escaping (CharacterDTO) -> Void)
}

class ServiceOfRickAndMorty: RickAndMortyType {
    let networkLayer = NetworkClient()
    func listOfCharacter(callback: @escaping (RickAndMortyDTO) -> Void) {
        let type: RickAndMortyApi = .listOfCharacter
        networkLayer.request(type) { result in
            switch result {
            case .success(let response):
                guard let characterDTO = try? response.map(RickAndMortyDTO.self) else {
                    print("Ошибка маппинга listOfCharacter")
                    break
                }
                callback(characterDTO)
            case .failure(let error):
                print(error)
            }
        }
    }
    func detailInfo(id: Int, callback: @escaping (CharacterDTO) -> Void) {
        let type: RickAndMortyApi = .detailInfo(id: id)
        networkLayer.request(type) { result in
            switch result {
            case .success(let response):
                guard let detailinfoDTO = try? response.map(CharacterDTO.self) else {
                    print("Ошибка маппинга detailInfo")
                    break
                }
                callback(detailinfoDTO)
            case .failure(let error):
                print(error)
            }
        }
    }
}
