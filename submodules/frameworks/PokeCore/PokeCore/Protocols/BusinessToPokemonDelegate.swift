//
//  BusinessToPokemonDelegate.swift
//  PokeCore
//
//  Created by Hector Climaco on 27/07/26.
//


public protocol BusinessToPokemonDelegate {
    func getPokemonList(startIndex: Int) async throws -> PokemonListResponse
    func getPokemonListResult(pokemon: PokemonListResult) async throws -> PokemonDetailResponse
}
