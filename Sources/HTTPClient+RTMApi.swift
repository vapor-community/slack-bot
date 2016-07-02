import Vapor
import VaporSSL

extension HTTPClient where ClientStreamType: SSLClientStream {
    static func loadRealtimeApi(token: String, simpleLatest: Bool = true, noUnreads: Bool = true) throws -> HTTPResponse {
        let headers: Headers = ["Accept": "application/json; charset=utf-8"]
        let query: [String: StructuredDataRepresentable] = [
            "token": token,
            "simple_latest": Int(simpleLatest), // bool => 1/0
            "no_unreads": Int(noUnreads)
        ]
        return try get("https://slack.com/api/rtm.start",
                       headers: headers,
                       query: query)
    }
}
