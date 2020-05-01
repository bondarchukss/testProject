//
//  CellViewModel.swift
//  mobile.iOS.test
//
//  Created by Sergey Bondarchuk on 17.02.2020.
//  Copyright © 2020 Sergey Bondarchuk. All rights reserved.
//

import Foundation
struct FeedCellViewModel {
    let id: Int
    let name: String
    let status: String
    let species: String
    let imageUrl: String
    init?(model: CharacterDTO) {
        guard let id = model.id,
            let name = model.name,
            let status = model.status,
            let species = model.species,
            let imageUrl = model.image else {return nil}
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.imageUrl = imageUrl
    }
}
