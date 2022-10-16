import Foundation
final class FeedModel {

    private let controlWord = "Password"
    var checkWord: String?

    func check(word: String) {
        if word == controlWord {
            NotificationCenter.default.post(name: Notification.Name("Correct"), object: nil)
        } else {NotificationCenter.default.post(name: Notification.Name("Incorrect"), object: nil)}
    }
}
