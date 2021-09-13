import Foundation
@testable import MaxibonKataIOS

class MockChat: Chat {

    var messageSent: String?

    func send(message: String) {
        messageSent = message
    }
}
