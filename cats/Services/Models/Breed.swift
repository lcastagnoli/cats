//
//  Breed.swift
//
//
//  Created by Laryssa Castagnoli on 12/03/24.
//

import Foundation

struct Breed: Decodable {

    enum CodingKeys: String, CodingKey {
        case id, name, temperament, origin
        case breedImage = "image"
        case breedDescription = "description"
        case referenceImageID = "reference_image_id"
    }

    let id: String?
    let name: String?
    let temperament: String?
    let origin: String?
    let referenceImageID: String?
    let breedDescription: String?
    let breedImage: BreedImage?
    
    init(id: String?,
         name: String?,
         temperament: String?,
         origin: String?,
         referenceImageID: String?,
         breedDescription: String?,
         breedImage: BreedImage?) {
        self.id = id
        self.name = name
        self.temperament = temperament
        self.origin = origin
        self.referenceImageID = referenceImageID
        self.breedDescription = breedDescription
        self.breedImage = breedImage
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try values.decodeIfPresent(String.self, forKey: .name)
        let name = try values.decodeIfPresent(String.self, forKey: .name)
        let temperament = try values.decodeIfPresent(String.self, forKey: .temperament)
        let origin = try values.decodeIfPresent(String.self, forKey: .origin)
        let referenceImageID = try values.decodeIfPresent(String.self, forKey: .referenceImageID)
        let breedDescription = try values.decodeIfPresent(String.self, forKey: .breedDescription)
        let breedImage = try values.decodeIfPresent(BreedImage.self, forKey: .breedImage)
        
        self.init(id: id, name: name, temperament: temperament, origin: origin, referenceImageID: referenceImageID, breedDescription: breedDescription, breedImage: breedImage)
    }
}
