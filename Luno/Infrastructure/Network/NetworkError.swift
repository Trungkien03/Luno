//
//  NetworkError.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 18/3/26.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noInternetConnection
    case badRequest(message: String?)
    case unauthorized
    case forbidden(message: String?)
    case notFound
    case serverError
    case noContent
    case decodingFailed(Error)
    case timeout
    case unknown(statusCode: Int, data: Data?)

    /// A high-level description of the error (Summary)
    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .noInternetConnection: return "Connection Failed"
        case .badRequest: return "Bad Request"
        case .unauthorized: return "Session Expired"
        case .forbidden: return "Access Denied"
        case .notFound: return "Resource Not Found"
        case .serverError: return "Internal Server Error"
        case .noContent: return "No Data Available"
        case .decodingFailed: return "Data Processing Error"
        case .timeout: return "Request Timeout"
        case .unknown(let code, _): return "Unexpected Error (Code: \(code))"
        }
    }

    /// A detailed explanation of why the error occurred
    public var failureReason: String? {
        switch self {
        case .invalidURL: return "The application attempted to connect to an improperly formatted or invalid URL."
        case .noInternetConnection: return "No active internet connection was detected. Please check your Wi-Fi or cellular data."
        case .badRequest(let message): return message ?? "The server could not understand the request due to invalid syntax."
        case .unauthorized: return "Your authentication credentials are missing or have expired. Please log in again."
        case .forbidden(let message): return message ?? "You do not have the required permissions to access this resource (403)."
        case .notFound: return "The requested resource could not be found on the server. It may have been moved or deleted."
        case .serverError: return "The server encountered an unexpected condition that prevented it from fulfilling the request."
        case .noContent: return "The request was successful, but the server returned no data."
        case .decodingFailed(let error): return "The system failed to parse the response data. Details: \(error.localizedDescription)"
        case .timeout: return "The server took too long to respond. Please try again later."
        case .unknown(_, let data):
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                return "An unhandled error occurred. Server response: \(responseString)"
            }
            return "An unidentified error occurred while communicating with the server."
        }
    }
}
