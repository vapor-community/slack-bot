import Vapor
import VaporSSL

extension HTTPClient where ClientStreamType: SSLClientStream {
    static func loadRealtimeApi(token: String, simpleLatest: Bool = true, noUnreads: Bool = true) throws -> HTTPResponse {
        let headers: Headers = ["Accept": "application/json; charset=utf-8"]
        let query: [String: StructuredDataRepresentable] = [
            "token": token,
            "simple_latest": simpleLatest.queryInt,
            "no_unreads": noUnreads.queryInt
        ]
        return try get("https://slack.com/api/rtm.start",
                       headers: headers,
                       query: query)
    }
}

extension Bool {
    private var queryInt: Int {
        // slack uses 1 / 0 in their demo
        return self ? 1 : 0
    }
}