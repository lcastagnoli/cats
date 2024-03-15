//
//  Favourite.swift
//  cats
//
//  Created by Laryssa Castagnoli on 14/03/24.
//

import SwiftData

@Model
final class Favourite {

    let id: String
    let name: String
    let temperament: String
    let origin: String
    let descriptionBreed: String
    let imageUrl: String
    let lifeSpan: String
    
    init(id: String, name: String, temperament: String, origin: String, descriptionBreed: String, image: String, lifeSpan: String) {
        self.id = id
        self.name = name
        self.temperament = temperament
        self.origin = origin
        self.descriptionBreed = descriptionBreed
        self.imageUrl = image
        self.lifeSpan = lifeSpan
    }
    
    init(with breed: Breed) {
        self.id = breed.id
        self.name = breed.name
        self.temperament = breed.temperament
        self.origin = breed.origin
        self.descriptionBreed = breed.description
        self.imageUrl = breed.image?.url ?? ""
        self.lifeSpan = breed.lifeSpan
    }
}

extension Favourite: BreedProtocol {

    var description: String { descriptionBreed }
}
