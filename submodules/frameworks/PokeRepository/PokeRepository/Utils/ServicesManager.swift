//
//  ServicesManager.swift
//  PokeRepository
//
//  Created by Hector Climaco on 26/07/26.
//

import Foundation
import CoreLocation
import PokeCore

public class ServicesManager: ServiceMaganerProtocol {
    
    private let session = URLSession.shared
    private static let share = ServicesManager()
    private var retries = 0
    private let retryLimit = 3

    public init() {
        
    }
    public func fetchRequest<T: Codable>(with request: URLRequest,
                                         completion: @escaping(Result<T, RequestError>) -> Void) {
        
        self.session.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                //MARK: validated error
                if let err = error {
                    let nsError = err as NSError
                    let possibleInternetErrors = [
                        NSURLErrorNotConnectedToInternet,
                        NSURLErrorNetworkConnectionLost,
                        NSURLErrorCannotConnectToHost,
                        NSURLErrorCannotFindHost,
                    ]
                    if possibleInternetErrors.contains(nsError.code) && self.retries < self.retryLimit {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            ServicesManager.share.fetchRequest(with: request, completion: completion)
                            self.retries += 1
                            return
                        }
                    } else {
                        return completion(.failure(RequestError(statusCode: nsError.code, description: nsError.description, data: data)))
                    }
                    
                }
                
                guard let response = response, let data = data else {
                    return completion(.failure( RequestError(statusCode: 0, description: "Error desconocido",
                                                             data: data)))
                }
                
                //MARK: validated response
                guard let httpResp = response as? HTTPURLResponse,
                      (200...299).contains(httpResp.statusCode) else {
                    completion(.failure(self.getError(response: response, data: data)))
                    return
                }
                
                if let respData = Mapper<T>().map(object: data) {
                    return completion(.success(respData))
                } else {
                    return completion(.failure( RequestError( statusCode: 0,description: "Error in decoder",
                                                              data: data)))
                }
            }
            
        }).resume()
    }
    
    public func fetchRequest<T: Codable>(with request: URL,
                                         completion: @escaping(Result<T, RequestError>) -> Void) {
        
        self.session.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                //MARK: validated error
                if let err = error {
                    let nsError = err as NSError
                    let possibleInternetErrors = [
                        NSURLErrorNotConnectedToInternet,
                        NSURLErrorNetworkConnectionLost,
                        NSURLErrorCannotConnectToHost,
                        NSURLErrorCannotFindHost,
                    ]
                    if possibleInternetErrors.contains(nsError.code) && self.retries < self.retryLimit {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            ServicesManager.share.fetchRequest(with: request, completion: completion)
                            self.retries += 1
                            return
                        }
                    } else {
                        return completion(.failure(RequestError(statusCode: nsError.code, description: nsError.description, data: data)))
                    }
                    
                }
                
                guard let response = response, let data = data else {
                    return completion(.failure( RequestError(statusCode: 0, description: "Error desconocido", data: data))
                    )
                }
                
                //MARK: validated response
                guard let httpResp = response as? HTTPURLResponse,
                      (200...299).contains(httpResp.statusCode) else {
                    
                    return completion(.failure(self.getError(response: response, data: data)))
                }
                
                if let respData = Mapper<T>().map(object: data) {
                    return completion(.success(respData))
                } else {
                    return completion(.failure(RequestError( statusCode: 0,description: "Error in decoder", data: data)))
                }
            }
        }).resume()
    }
    
}


class MockServiceManager: ServiceMaganerProtocol {
    
    var name: String
    
    public init(nameFile:String) {
        self.name = nameFile
    }
    
    func fetchRequest<T>(with request: URLRequest, completion: @escaping (Result<T, RequestError>) -> Void) where T : Decodable, T : Encodable {
        DispatchQueue.main.async {
            var error = RequestError( statusCode: 0,description: "Error in decoder", data: nil)
            
            do {
                if let bundlePath = Bundle.main.path(forResource: self.name,ofType: "json") {
                    let data = try Data(contentsOf: URL(fileURLWithPath: bundlePath), options: .mappedIfSafe)
                    
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    
                    guard let resonse = Mapper<T>().map(object: jsonResult) else {
                        error.data = data
                        return completion(.failure(error))
                    }
                    return completion(.success(resonse))
                }
                
            } catch {
                return completion(.failure(error as! RequestError))
            }
            
            return completion(.failure(error))
        }
    }
    
    func fetchRequest<T>(with request: URL, completion: @escaping (Result<T, RequestError>) -> Void) where T : Decodable, T : Encodable {
        
        var error = RequestError( statusCode: 0,description: "Error in decoder", data: nil)
        DispatchQueue.main.async {
            do {
                if let bundlePath = Bundle.main.path(forResource: self.name,ofType: "json") {
                    let data = try Data(contentsOf: URL(fileURLWithPath: bundlePath), options: .mappedIfSafe)
                    
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    
                    guard let resonse = Mapper<T>().map(object: jsonResult) else {
                        error.data = data
                        return completion(.failure(error))
                    }
                    return completion(.success(resonse))
                }
                
                
            } catch {
                return completion(.failure(error as! RequestError))
            }
            
            return completion(.failure(error))
        }
    }
    
}
