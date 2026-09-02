//
//  PokemonListResponse.swift
//  PokeRepository
//
//  Created by Hector Climaco on 27/07/26.
//

public struct PokemonListResponse : Codable {
    
    public let count : Int
    public let next : String?
    public let previous : String?
    public let results : [PokemonListResult?]

}

public struct PokemonListResult : Codable {
    public let name : String
    public let url : String
}
