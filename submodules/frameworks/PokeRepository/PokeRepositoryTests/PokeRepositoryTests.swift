//
//  PokeRepositoryTests.swift
//  PokeRepositoryTests
//
//  Created by Hector Climaco on 28/07/26.
//

import Foundation
import Testing
import PokeCore
@testable import PokeRepository

struct PokeRepositoryTests {

    @Test("getPokemonList returns the response and builds the paginated URL")
    func getPokemonListSuccess() async throws {
        let expectedResponse = try makePokemonListResponse()
        let serviceManager = MockServiceManager(result: .listSuccess(expectedResponse))
        let sut = PokemonWS(serviceManager: serviceManager)

        let response = try await sut.getPokemonList(startIndex: 40)

        #expect(response.count == expectedResponse.count)
        #expect(response.next == expectedResponse.next)
        #expect(response.results.count == expectedResponse.results.count)
        #expect(response.results.first??.name == "bulbasaur")
        #expect(serviceManager.lastURL?.absoluteString ==
                "https://pokeapi.co/api/v2/pokemon?offset=40&limit=20")
    }

    @Test("getPokemonList loads a list from the PokeAPI")
    func getPokemonListLiveAPI() async throws {
        let sut = PokemonWS()

        let response = try await sut.getPokemonList(startIndex: 0)
        let results = response.results.compactMap { $0 }

        debugPrint(results)
        #expect(response.count > 0)
        #expect(results.count > 0)
        #expect(results.allSatisfy { !$0.name.isEmpty && !$0.url.isEmpty })
    }

    @Test("getPokemonList propagates the service error")
    func getPokemonListFailure() async throws {
        let expectedError = RequestError(statusCode: 500, description: "Server unavailable")
        let serviceManager = MockServiceManager(result: .failure(expectedError))
        let sut = PokemonWS(serviceManager: serviceManager)

        var receivedError: RequestError?

        do {
            _ = try await sut.getPokemonList(startIndex: 0)
        } catch let error as RequestError {
            receivedError = error
        }

        #expect(receivedError?.statusCode == expectedError.statusCode)
        #expect(receivedError?.description == expectedError.description)
    }

    @Test("getPokemonListResult requests and returns the pokemon detail")
    func getPokemonListResultSuccess() async throws {
        let expectedResponse = try makePokemonDetailResponse()
        let listResponse = try makePokemonListResponse()
        let pokemon = try #require(listResponse.results.first ?? nil)
        let serviceManager = MockServiceManager(result: .detailSuccess(expectedResponse))
        let sut = PokemonWS(serviceManager: serviceManager)

        let response = try await sut.getPokemonListResult(pokemon: pokemon)

        #expect(response == expectedResponse)
        #expect(serviceManager.lastURL?.absoluteString == pokemon.url)
    }

    private func makePokemonListResponse() throws -> PokemonListResponse {
        let json = """
        {
            "count": 2,
            "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
            "previous": null,
            "results": [
                {
                    "name": "bulbasaur",
                    "url": "https://pokeapi.co/api/v2/pokemon/1/"
                },
                {
                    "name": "ivysaur",
                    "url": "https://pokeapi.co/api/v2/pokemon/2/"
                }
            ]
        }
        """

        return try JSONDecoder().decode(
            PokemonListResponse.self,
            from: Data(json.utf8)
        )
    }

    private func makePokemonDetailResponse() throws -> PokemonDetailResponse {
        let json = """
        {
            "abilities": [],
            "base_experience": 64,
            "forms": [],
            "height": 7,
            "id": 1,
            "is_default": true,
            "location_area_encounters": null,
            "moves": [],
            "name": "bulbasaur",
            "order": 1,
            "species": null,
            "sprites": null,
            "stats": [],
            "types": [],
            "weight": 69
        }
        """

        return try JSONDecoder().decode(
            PokemonDetailResponse.self,
            from: Data(json.utf8)
        )
    }
}

private final class MockServiceManager: ServiceMaganerProtocol {

    enum ResultStub {
        case listSuccess(PokemonListResponse)
        case detailSuccess(PokemonDetailResponse)
        case failure(RequestError)
    }

    let result: ResultStub
    private(set) var lastURL: URL?

    init(result: ResultStub) {
        self.result = result
    }

    func fetchRequest<T: Codable>(
        with request: URLRequest,
        completion: @escaping (Result<T, RequestError>) -> Void
    ) {
        completion(.failure(RequestError(
            statusCode: 0,
            description: "Unexpected URLRequest overload"
        )))
    }

    func fetchRequest<T: Codable>(
        with request: URL,
        completion: @escaping (Result<T, RequestError>) -> Void
    ) {
        lastURL = request

        switch result {
        case .listSuccess(let response):
            complete(response, completion: completion)

        case .detailSuccess(let response):
            complete(response, completion: completion)

        case .failure(let error):
            completion(.failure(error))
        }
    }

    private func complete<T: Codable>(
        _ response: Any,
        completion: @escaping (Result<T, RequestError>) -> Void
    ) {
        guard let response = response as? T else {
            completion(.failure(RequestError(
                statusCode: 0,
                description: "Unexpected response type"
            )))
            return
        }

        completion(.success(response))
    }
}
