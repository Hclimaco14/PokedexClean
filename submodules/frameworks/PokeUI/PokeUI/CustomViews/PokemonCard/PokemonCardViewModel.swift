//
//  PokemonCardViewModel.swift
//  PokeUI
//
//  Created by Hector Climaco on 30/07/26.
//

import Foundation
import PokeCore
import PokeSharedUI
import Combine
import SwiftUI


class PokemonCardViewModel: ObservableObject {
    
    @Published var namePokemon: String = ""
    @Published var idPokemon: String = ""
    @Published var attributes: [String] = []
    @Published var image: CachedAsyncImage?
    @Published var color: Color = .gray
    
    private var pokemon: PokemonDetailResponse?
    
    init(pokemonDetail: PokemonDetailResponse?){
        
        self.pokemon = pokemonDetail
        self.namePokemon = pokemonDetail?.name ?? ""
        self.idPokemon = (pokemonDetail?.id ?? 0).toIdFormat()
        self.attributes = pokemonDetail?.types.compactMap({ $0?.type?.name }) ?? []
        self.image = CachedAsyncImage(urlString: pokemonDetail?.sprites?.other?.officialArtwork?.frontDefault, placeholder: Image(asset: .pokeball))
        
        if let type = pokemonDetail?.types.first, let colorRaw = type?.type?.name?.capitalized, let color = AssetColors(rawValue: colorRaw) {
            self.color = Color(color: color)
        }
        
    }
    
    
}
