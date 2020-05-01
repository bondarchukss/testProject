//
//  File.swift
//  mobile.iOS.test
//
//  Created by Сергей Бондарчук on 22.03.2020.
//  Copyright © 2020 Sergey Bondarchuk. All rights reserved.
//

import Foundation
struct RickAndMortyDTO: Codable {
    let info: InfoDTO?
    let results: [CharacterDTO]?
}
