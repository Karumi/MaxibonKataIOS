import Foundation

struct Slack: Chat {
    func send(message: String) {
        print("-------->" + message)
    }
}
