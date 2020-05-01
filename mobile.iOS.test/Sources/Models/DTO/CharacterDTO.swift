//
//  CharacterDTO.swift
//  mobile.iOS.test
//
//  Created by Сергей Бондарчук on 22.03.2020.
//  Copyright © 2020 Sergey Bondarchuk. All rights reserved.
//

import Foundation
struct CharacterDTO: Codable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let image: String?
    let location: LocationDTO
}
