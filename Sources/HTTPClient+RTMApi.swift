import Vapor
import HTTP
import TLS
import Transport

func setupClient() {
    defaultClientConfig = {
        return try TLS.Config(context: try Context(mode: .client), certificates: .none, verifyHost: false, verifyCertificates: false, cipher: .compat)
    }
}


extension HTTP.Client {
    static func loadRealtimeApi(token: String, simpleLatest: Bool = true, noUnreads: Bool = true) throws -> HTTP.Response {
        let headers: [HeaderKey: String] = ["Accept": "application/json; charset=utf-8"]
        let query: [String: CustomStringConvertible] = [
            "token": token,
            "simple_latest": simpleLatest.queryInt,
            "no_unreads": noUnreads.queryInt
        ]
        return try get(
            "https://slack.com/api/rtm.start",
            headers: headers,
            query: query
        )
    }
}

extension Bool {
    fileprivate var queryInt: Int {
        // slack uses 1 / 0 in their demo
        return self ? 1 : 0
    }
}
