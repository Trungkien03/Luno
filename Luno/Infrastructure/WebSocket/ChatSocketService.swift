//
//  WebSocketProvider.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 18/3/26.
//

import Foundation

/// Supported WebSocket actions for the Chat module.
enum ChatSocketAction: String {
    case returnConnection = "returnConnection"
    case createUserConnectionId = "createUserConnectionId"
    case getRoomsByUserId = "getRoomsByUserId"
    case getAllMessages = "getAllMessages"
    case join = "join"
}

/// Generic DTO for sending requests via WebSocket.
struct SocketRequestDTO<T: Encodable>: Encodable {
    let action: String
    let data: T?
}

protocol ChatSocketServiceDelegate: AnyObject {
    func didReceiveRooms(_ rooms: [String])
    func didConnectSuccessfully()
    func didFailWithError(_ error: Error)
}

final class ChatSocketService {
    private let socketClient: WebSocketClient
    weak var delegate: ChatSocketServiceDelegate?

    init(socketClient: WebSocketClient = .shared) {
        self.socketClient = socketClient
        bindSocketEvents()
    }

    func openConnection(userId: String) {
        // TODO: Move URL to a configuration file or DI container
        guard let url = URL(string: "wss://...YOUR_AWS_URL...") else { return }
        socketClient.connect(url: url)
    }

    func getRoomsByUserId(userId: Int) {
        let request = SocketRequestDTO(
            action: ChatSocketAction.getRoomsByUserId.rawValue,
            data: ["user_id": userId]
        )
        socketClient.send(model: request)
    }

    private func bindSocketEvents() {
        socketClient.onReceiveMessage = { [weak self] json in
            self?.handleRawResponse(json)
        }
    }

    private func handleRawResponse(_ jsonString: String) {
        guard let data = jsonString.data(using: .utf8) else { return }

        struct BaseResponse: Decodable { let action: String? }
        
        do {
            let base = try JSONDecoder().decode(BaseResponse.self, from: data)
            guard let rawAction = base.action,
                  let action = ChatSocketAction(rawValue: rawAction) else { return }

            switch action {
            case .createUserConnectionId:
                delegate?.didConnectSuccessfully()

            case .getRoomsByUserId:
                // TODO: Decode RoomDTOs when models are ready
                delegate?.didReceiveRooms(["Room A", "Room B"])

            default:
                break
            }
        } catch {
            print("Socket decoding error: \(error)")
        }
    }
}
