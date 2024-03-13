//
//  Breed.swift
//  cats
//
//  Created by Laryssa Castagnoli on 12/03/24.
//

struct Breed: Decodable {

    let id: String?
    let name: String?
    let temperament: String?
    let origin: String?
    let referenceImageID: String?
    let description: String?
    let image: BreedImage?
}

