//
//  APIEndpoint.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 18/3/26.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol APIEndpoint {
    associatedtype ResponseType: Decodable

    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryParameters: [String: Any]? { get }
    var bodyParameters: [String: Any]? { get }
}

extension APIEndpoint {
    public var method: HTTPMethod { .get }
    
    public var headers: [String: String] { [:] }
    public var queryParameters: [String: Any]? { nil }
    public var bodyParameters: [String: Any]? { nil }

    public func asURLRequest(with config: NetworkConfigurable) throws -> URLRequest {
        var urlComponents = URLComponents(
            url: config.baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: true
        )

        // 1. Chỉ gắn query parameters nếu có
        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            urlComponents?.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }

        // 2. Lấy URL ra ngoài (Bắt buộc phải có URL dù có query hay không)
        guard let url = urlComponents?.url else {
            throw NetworkError.invalidURL
        }

        // 3. Khởi tạo request ở phạm vi ngoài cùng của hàm
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // 4. Xử lý Headers
        var allHeaders = config.headers
        headers.forEach { allHeaders[$0.key] = $0.value }
        request.allHTTPHeaderFields = allHeaders

        // 5. Xử lý Body Parameters
        if let bodyParameters = bodyParameters, !bodyParameters.isEmpty {
            request.httpBody = try? JSONSerialization.data(
                withJSONObject: bodyParameters
            )
            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.setValue(
                    "application/json",
                    forHTTPHeaderField: "Content-Type"
                )
            }
        }

        return request
    }
}
