//
//  RequestError.swift
//  PokeCore
//
//  Created by Hector Climaco on 27/07/26.
//

import Foundation

public struct RequestError: Error {
    public let statusCode: Int
    public let description: String
    public var data: Data?
    
    public init(statusCode: Int, description: String, data: Data? = nil) {
        self.statusCode = statusCode
        self.description = description
        self.data = data
    }
}
