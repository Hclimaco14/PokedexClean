//
//  PokemonDetailResponse.swift
//  PokeCore
//
//  Created by Hector Climaco on 27/07/26.
//

public struct PokemonDetailResponse : Codable, Equatable {
    public static func == (lhs: PokemonDetailResponse, rhs: PokemonDetailResponse) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var abilities: [Ability?]
    public var baseExperience: Int?
    public var forms: [Species?]
    public var height: Int?
    public var id: Int
    public var isDefault: Bool
    public var locationAreaEncounters: String?
    public var moves: [Move]?
    public var name: String?
    public var order: Int?
    public var species: Species?
    public var sprites: Sprites?
    public var stats: [Stat]?
    public var types: [TypeElement?]
    public var weight: Int?
    
    enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case abilities = "abilities"
        case forms = "forms"
        case height = "height"
        case id = "id"
        case moves = "moves"
        case name = "name"
        case order = "order"
        case species = "species"
        case sprites = "sprites"
        case stats = "stats"
        case types = "types"
        case weight = "weight"
    }
    
    init() {
        self.abilities = []
        self.baseExperience = nil
        self.forms = []
        self.height = nil
        self.id = 0
        self.isDefault = false
        self.locationAreaEncounters = nil
        self.moves = nil
        self.name = nil
        self.order = nil
        self.species = nil
        self.sprites = nil
        self.stats = nil
        self.types = []
        self.weight = nil
    }
    
    public init(from decoder: Decoder) throws {
        var values = try decoder.container(keyedBy: CodingKeys.self)
            baseExperience = try values.decodeIfPresent(Int.self, forKey: .baseExperience)
            isDefault = try values.decodeIfPresent(Bool.self, forKey: .isDefault)!
            locationAreaEncounters = try values.decodeIfPresent(String.self, forKey: .locationAreaEncounters)
            abilities = try values.decodeIfPresent([Ability?].self, forKey: .abilities)!
            forms = try values.decodeIfPresent([Species?].self, forKey: .forms)!
            height = try values.decodeIfPresent(Int.self, forKey: .height)
            id = try values.decodeIfPresent(Int.self, forKey: .id)!
            moves = try values.decodeIfPresent([Move].self, forKey: .moves)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            order = try values.decodeIfPresent(Int.self, forKey: .order)
            species = try values.decodeIfPresent(Species.self, forKey: .species)
            sprites = try values.decodeIfPresent(Sprites.self, forKey: .sprites)
            stats = try values.decodeIfPresent([Stat].self, forKey: .stats)
            types = try values.decodeIfPresent([TypeElement?].self, forKey: .types)!
            weight = try values.decodeIfPresent(Int.self, forKey: .weight)
    }
}

// MARK: - Ability
public struct Ability : Codable {
    public var ability: Species?
    public var isHidden: Bool?
    public var slot: Int?
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
    
    public init(from decoder: Decoder) throws {
        var values = try decoder.container(keyedBy: CodingKeys.self)
        ability = try values.decodeIfPresent(Species.self, forKey: .ability)
        isHidden = try values.decodeIfPresent(Bool.self, forKey: .isHidden)
        slot = try values.decodeIfPresent(Int.self, forKey: .slot)

    }
            
}

// MARK: - Species
public struct Species : Codable {
    public var name: String?
    public var url: String?
}

// MARK: - Move
public struct Move : Codable {
    public var move: Species?
    public var versionGroupDetails: [VersionGroupDetail]?
}

// MARK: - VersionGroupDetail
public struct VersionGroupDetail : Codable {
    public var levelLearnedAt: Int?
    public var moveLearnMethod, versionGroup: Species?
}

// MARK: - Sprites
public struct Sprites : Codable {
    public var backDefault: String?
    public var backFemale: String?
    public var backShiny: String?
    public var backShinyFemale: String?
    public var frontDefault: String?
    public var frontFemale: String?
    public var frontShiny: String?
    public var frontShinyFemale: String?
    public var other: Other?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case other
    }
    
    public init(from decoder: Decoder) throws {
        var values = try decoder.container(keyedBy: CodingKeys.self)
        backDefault = try values.decodeIfPresent(String.self, forKey: .backDefault)
        backFemale = try values.decodeIfPresent(String.self, forKey: .backFemale)
        backShiny = try values.decodeIfPresent(String.self, forKey: .backShiny)
        backShinyFemale = try values.decodeIfPresent(String.self, forKey: .backShinyFemale)
        frontDefault = try values.decodeIfPresent(String.self, forKey: .frontDefault)
        frontFemale = try values.decodeIfPresent(String.self, forKey: .frontFemale)
        frontShiny = try values.decodeIfPresent(String.self, forKey: .frontShiny)
        frontShinyFemale = try values.decodeIfPresent(String.self, forKey: .frontShinyFemale)
        other = try values.decodeIfPresent(Other.self, forKey: .other)
    }
}

// MARK: - Other
public struct Other : Codable {
    public var officialArtwork: OfficialArtwork?
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
    
    public init(from decoder: Decoder) throws {
        var values = try decoder.container(keyedBy: CodingKeys.self)
        officialArtwork = try values.decodeIfPresent(OfficialArtwork.self, forKey: .officialArtwork)
    }
}

// MARK: - OfficialArtwork
public struct OfficialArtwork : Codable {
    public var frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    public init(from decoder: Decoder) throws {
        var values = try decoder.container(keyedBy: CodingKeys.self)
        frontDefault = try values.decodeIfPresent(String.self, forKey: .frontDefault)
    }
}

// MARK: - Stat
public struct Stat : Codable {
    public var baseStat, effort: Int?
    public var stat: Species?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
    
    public init(from decoder: Decoder) throws {
        var values = try decoder.container(keyedBy: CodingKeys.self)
        baseStat = try values.decodeIfPresent(Int.self, forKey: .baseStat)
        effort = try values.decodeIfPresent(Int.self, forKey: .effort)
        stat = try values.decodeIfPresent(Species.self, forKey: .stat)
    }
    
}

// MARK: - TypeElement
public struct TypeElement : Codable {
    public var slot: Int?
    public var type: Species?
}
