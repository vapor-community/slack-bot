import Vapor

extension WebSocket {
    func send(_ node: NodeRepresentable) throws {
        let json = try node.converted(to: JSON.self)
        let message = try json.makeBytes()
        // json MUST send as string
        try send(message.string)
    }
}
