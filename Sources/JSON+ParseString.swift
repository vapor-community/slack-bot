import enum Vapor.JSON

extension JSON {
    // Do not rename `parse`, it will interfere w/ a property declaration
    static func parseString(_ str: String) throws -> JSON {
        return try JSON.parse(Array(str.utf8))
    }
}
