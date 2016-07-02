import Vapor
import VaporSSL

import libc

extension UInt32 {
    static func random() -> UInt32 {
        let max = UInt32.max
        #if os(Linux)
            let val = UInt32(libc.random() % Int(max))
        #else
            let val = UInt32(arc4random_uniform(max))
        #endif
        return val
    }
}

extension JSON {
    // Do not rename `parse`, it will interfere w/ a property declaration
    static func parseString(_ str: String) throws -> JSON {
        return try JSON.parse(Array(str.utf8))
    }
}

struct SlackMessage {
    let id: UInt32
    let channel: String
    let text: String

    init(to channel: String, text: String) {
        self.id = UInt32.random()
        self.channel = channel
        self.text = text
    }
}

extension WebSocket {
    func send(_ json: JSON) throws {
        let message = try JSON.serialize(json).string
        try send(message)
    }
}

extension WebSocket {
    func send(_ message: SlackMessage) throws {
        var response: JSON = [:]
        response["id"] = JSON(message.id)
        response["type"] = JSON("message")
        response["channel"] = JSON(message.channel)
        response["text"] = JSON(message.text)
        try send(response)
    }
}


#if os(Linux)
let workDir = "./"
#else
var workDir: String {
    let parent = #file.characters.split(separator: "/").map(String.init).dropLast().joined(separator: "/")
    let path = "/\(parent)/.."
    return path
}
#endif

let config = Config(workingDirectory: workDir)
guard let token = config["bot-config", "token"].string else { fatalError("Missing Config/bot-config.json") }

let headers: Headers = ["Accept": "application/json; charset=utf-8"]
let query: [String: StructuredDataRepresentable] = [
    "token": token,
    "simple_latest": 1,
    "no_unreads": 1
]
let rtmResponse = try HTTPClient<SSLClientStream>.get("https://slack.com/api/rtm.start",
                                                      headers: headers,
                                                      query: query)

guard let webSocketURL = rtmResponse.data["url"].string else { fatalError("Failed to start") }

try WebSocket.connect(to: webSocketURL, using: HTTPClient<SSLClientStream>.self) { ws in
    print("Connected to \(webSocketURL)")

    ws.onText = { ws, text in
        let event = try JSON.parseString(text)
        print("[event] - \(event)")
        guard
            let channel = event["channel"].string,
            let text = event["text"].string
            where
                text.hasPrefix("hello")
            else { return }

        let response = SlackMessage(to: channel, text: "Hi there 👋")
        try ws.send(response)
    }

    ws.onClose = { ws, _, _, _ in
        print("\n[CLOSED]\n")
    }
}
