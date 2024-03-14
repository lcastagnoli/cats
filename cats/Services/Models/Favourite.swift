//
//  Favourite.swift
//  cats
//
//  Created by Laryssa Castagnoli on 13/03/24.
//

struct Favourite: Decodable {

    let id: Int?
    let userID, imageID, subID, createdAt: String?
    let image: BreedImage?
}
