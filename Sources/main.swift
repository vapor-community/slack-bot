import Vapor
import VaporTLS

let VERSION = "0.1.0"

let config = try Config(workingDirectory: workingDirectory)
guard let token = config["bot-config", "token"].string else { throw BotError.missingConfig }

let rtmResponse = try HTTPClient.loadRealtimeApi(token: token)
guard let webSocketURL = rtmResponse.data["url"].string else { throw BotError.invalidResponse }

try WebSocket.connect(to: webSocketURL, using: HTTPClient<TLSClientStream>.self) { ws in
    print("Connected to \(webSocketURL)")

    ws.onText = { ws, text in
        let event = try JSON.parseString(text)
        print("[event] - \(event)")
        guard
            let channel = event["channel"].string,
            let text = event["text"].string
            else { return }

        if text.hasPrefix("hello") {
            let response = SlackMessage(to: channel, text: "Hi there 👋")
            try ws.send(response)
        } else if text.hasPrefix("version") {
            let response = SlackMessage(to: channel, text: "Current Version: \(VERSION)")
            try ws.send(response)
        }
    }

    ws.onClose = { ws, _, _, _ in
        print("\n[CLOSED]\n")
    }
}
