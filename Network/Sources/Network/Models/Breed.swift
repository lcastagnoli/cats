//
//  Breed.swift
//
//
//  Created by Laryssa Castagnoli on 12/03/24.
//

import Foundation
import SwiftData

@Model
public final class Breed {

    @Attribute(.unique) public let id: String
    public let name: String?
    public let temperament: String?
    public let origin: String?
    public let referenceImageID: String?
    public let breedDescription: String?
    
    init(id: String, name: String? = nil, temperament: String? = nil, origin: String? = nil, referenceImageID: String? = nil, breedDescription: String? = nil) {
        self.id = id
        self.name = name
        self.temperament = temperament
        self.origin = origin
        self.referenceImageID = referenceImageID
        self.breedDescription = breedDescription
    }
}

// MARK: - Decodable
extension Breed: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id, name, temperament, origin
        case breedDescription = "description"
        case referenceImageID = "reference_image_id"
    }
    
    public convenience init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let id = try values.decode(String.self, forKey: .id)
        let name = try? values.decode(String.self, forKey: .name)
        let temperament = try? values.decode(String.self, forKey: .temperament)
        let origin = try? values.decode(String.self, forKey: .origin)
        let referenceImageID = try? values.decode(String.self, forKey: .referenceImageID)
        let breedDescription = try? values.decode(String.self, forKey: .breedDescription)

        self.init(id: id,
                  name: name,
                  temperament: temperament,
                  origin: origin,
                  referenceImageID: referenceImageID,
                  breedDescription: breedDescription)
    }
}
