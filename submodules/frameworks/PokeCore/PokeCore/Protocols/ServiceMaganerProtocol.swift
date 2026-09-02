//
//  ServiceMaganerProtocol.swift
//  PokeCore
//
//  Created by Hector Climaco on 27/07/26.
//

import Foundation

public protocol ServiceMaganerProtocol {
    func fetchRequest<T: Codable>(with request: URLRequest,
                                         completion: @escaping(Result<T, RequestError>) -> Void)
    func fetchRequest<T: Codable>(with request: URL,
                                         completion: @escaping(Result<T, RequestError>) -> Void)
    func getError(response: URLResponse, data: Data) -> RequestError
}

extension ServiceMaganerProtocol {
    
    public func getError(response: URLResponse, data: Data) -> RequestError {
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return RequestError(statusCode: 00, description: "Error getting description of server error.")
        }
        
        switch httpResponse.statusCode {
        case 400:
            return RequestError(statusCode: 400, description: "Invalid Request", data: data)
        case 401:
            return RequestError(statusCode: 401, description: "Unauthorized", data: data)
        case 404:
            return RequestError(statusCode: 404, description: "Not found", data: data)
        case 500:
            return RequestError(statusCode: 500, description: "Server unavailable", data: data)
        default:
            return RequestError(statusCode: 00, description: "Tuvimos un problema, vuelve a intentarlo más tarde", data: data)
        }
    }
}
