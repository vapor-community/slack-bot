import XCTest
@testable import slack-bot

class slack-botTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(slack-bot().text, "Hello, World!")
    }


    static var allTests : [(String, (slack-botTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
