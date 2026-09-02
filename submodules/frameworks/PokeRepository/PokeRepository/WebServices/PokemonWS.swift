//
//  PokemonWS.swift
//  PokeRepository
//
//  Created by Hector Climaco on 27/07/26.
//

import Foundation
import PokeCore

public class PokemonWS: BusinessToPokemonDelegate{
    
    private let serviceMager: ServiceMaganerProtocol
    
    public init(serviceManager: ServiceMaganerProtocol = ServicesManager()) {
        self.serviceMager = serviceManager
    }
    
    public func getPokemonList(startIndex: Int) async throws -> PokemonListResponse {
        
        let urlString = Constants.baseURL + "pokemon?offset=\(startIndex)&limit=\(Constants.paginationSize)"
        guard let requestURL  = URL(string: urlString) else { throw RequestError(statusCode: 0, description: "Error in creating URL")  }
        
        return try await withCheckedThrowingContinuation { continuation in
            
            serviceMager.fetchRequest(with: requestURL) {
                (result: Result<PokemonListResponse, RequestError>) in
                
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
            
        }
        
    }
    
    public func getPokemonListResult(pokemon: PokemonListResult) async throws -> PokemonDetailResponse{
        
        guard let requestURL  = URL(string: pokemon.url) else { throw RequestError(statusCode: 0, description: "Error in creating URL")  }
        
        return try await withCheckedThrowingContinuation { continuation in
            
            serviceMager.fetchRequest(with: requestURL) {
                (result: Result<PokemonDetailResponse, RequestError>) in
                
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
            
        }
        
        
    }
}
