import Foundation
final class UserStoreService {

    static let shared = UserStoreService()

    let users: [User] = [
        User(id: UUID(), name: "Alex"),
        User(id: UUID(), name: "Sarah"),
        User(id: UUID(), name: "John"),
        User(id: UUID(), name: "Emma"),
        User(id: UUID(), name: "David"),
        User(id: UUID(), name: "Olivia"),
        User(id: UUID(), name: "Michael"),
        User(id: UUID(), name: "Sophia"),
        User(id: UUID(), name: "Daniel"),
        User(id: UUID(), name: "Jessica")
    ]
}
