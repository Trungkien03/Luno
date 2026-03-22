//
//  WebSocketClient.swift
//  iOS_CleanArchitecture
//
//  Created by Nguyen Trung Kien on 18/3/26.
//

import Foundation

public final class WebSocketClient {
    public static let shared = WebSocketClient()

    private var webSocketTask: URLSessionWebSocketTask?
    public var isConnected = false

    public var onReceiveMessage: ((String) -> Void)?
    public var onStateChange: ((Bool) -> Void)?

    private init() {}

    public func connect(url: URL) {
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        isConnected = true
        onStateChange?(isConnected)
        listen()
    }

    public func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        isConnected = false
        onStateChange?(false)
    }

    public func send(jsonString: String) {
        let message = URLSessionWebSocketTask.Message.string(jsonString)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("WebSocket Send Error: \(error)")
            }
        }
    }

    // Gửi trực tiếp Generic Data Model
    public func send<T: Encodable>(model: T) {
        guard let data = try? JSONEncoder().encode(model),
            let jsonString = String(data: data, encoding: .utf8)
        else { return }
        send(jsonString: jsonString)
    }

    private func listen() {
        webSocketTask?.receive { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    self.onReceiveMessage?(text)
                case .data(let data):
                    if let text = String(data: data, encoding: .utf8) {
                        self.onReceiveMessage?(text)
                    }
                @unknown default: break
                }
                self.listen()  // Nhận xong thì gọi lại chính nó để tiếp tục nghe

            case .failure(let error):
                print("WebSocket disconnect/Error: \(error)")
                self.isConnected = false
                self.onStateChange?(false)
            // Tuỳ chọn logic auto-reconnect ở đây
            }
        }

    }
}
