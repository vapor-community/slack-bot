import Vapor

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
