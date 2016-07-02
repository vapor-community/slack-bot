import Vapor
import VaporSSL

extension JSON {
    static func parse(_ str: String) throws -> JSON {
        return try JSON.parse(Array(str.utf8))
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
        let event = try JSON.parse(text)
        print("[event] - \(event)")
    }

    ws.onClose = { ws, _, _, _ in
        print("\n[CLOSED]\n")
    }
}
