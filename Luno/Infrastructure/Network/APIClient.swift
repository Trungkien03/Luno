//
//  APIClient.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 18/3/26.
//

import Foundation


public protocol APIClient {
    func request<E: APIEndpoint>(_ endpoint: E) async throws -> E.ResponseType
    func requestVoid<E: APIEndpoint>(_ endpoint: E) async throws where E.ResponseType == EmptyResponse
}

///📌 Giành cho những API không trả body gì cả (nhưng code báo 200 là thành công)
public struct EmptyResponse: Decodable {}

public final class DefaultAPIClient: APIClient {
    private let config: NetworkConfigurable
    private let session: URLSession
    
    public init(config: NetworkConfigurable, session: URLSession = .shared) {
        self.config = config
        self.session = session
    }
    
    
    public func request<E>(_ endpoint: E) async throws -> E.ResponseType where E : APIEndpoint {
        let request = try endpoint.asURLRequest(with: config)
        
        #if DEBUG
        print("🚀 [\(request.httpMethod ?? "")] \(request.url?.absoluteString ?? "")")
        #endif
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch let urlError as URLError where urlError.code == .notConnectedToInternet {
            throw NetworkError.noInternetConnection
        } catch {
            throw error
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown(statusCode: 0, data: data)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            if E.ResponseType.self == EmptyResponse.self {
                return EmptyResponse() as! E.ResponseType
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(E.ResponseType.self, from: data)
                
                return decodedObject
            } catch {
                throw NetworkError.decodingFailed(error)
            }
            
        case 204:
            throw NetworkError.noContent
        
        case 400:
            let message = extractErrorMessage(from: data) ?? "Bad Request"
            throw NetworkError.badRequest(message: message)
            
        case 401:
            throw NetworkError.unauthorized
            
        case 403:
            let message = extractErrorMessage(from: data) ?? "Forbidden"
            throw NetworkError.forbidden(message: message)
        
        case 404:
            throw NetworkError.notFound
        
        case 500...509:
            throw NetworkError.serverError
        default:
            throw NetworkError.unknown(statusCode: httpResponse.statusCode, data: data)
        }
        
    }
    
    public func requestVoid<E: APIEndpoint>(_ endpoint: E) async throws where E.ResponseType == EmptyResponse {
        _ = try await request(endpoint)
    }
    
    
    // 📌 Logic móc message từ JSON lỗi
    private func extractErrorMessage(from data: Data) -> String? {
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return nil }
        
        if let message = dict["message"] as? String {
            return message
        } else if let message = dict["statusMessage"] as? String {
            return message
        } else if let errObj = dict["error"] as? [String: Any], let message = errObj["message"] as? String {
            return message
        }
        return nil
    }
}
