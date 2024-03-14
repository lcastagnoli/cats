//
//  Favourite.swift
//  cats
//
//  Created by Laryssa Castagnoli on 14/03/24.
//

import SwiftData

@Model
final class LocalBreed {

    let id: String
    let name: String
    let temperament: String
    let origin: String
    let descriptionBreed: String
    let image: String
    let lifeSpan: String
    var isFavorited: Bool
    
    init(id: String, name: String, temperament: String, origin: String, descriptionBreed: String, image: String, lifeSpan: String, isFavorited: Bool) {
        self.id = id
        self.name = name
        self.temperament = temperament
        self.origin = origin
        self.descriptionBreed = descriptionBreed
        self.image = image
        self.lifeSpan = lifeSpan
        self.isFavorited = isFavorited
    }
    
    init(with breed: Breed) {
        self.id = breed.id ?? ""
        self.name = breed.name ?? ""
        self.temperament = breed.temperament ?? ""
        self.origin = breed.origin ?? ""
        self.descriptionBreed = breed.description ?? ""
        self.image = breed.image?.url ?? ""
        self.lifeSpan = breed.lifeSpan ?? ""
        self.isFavorited = false
    }
}
