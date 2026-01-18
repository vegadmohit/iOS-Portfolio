import Foundation

import Foundation

enum TransactionType: String, Codable {
    case income
    case expense
}

struct Transaction: Codable {
    let id: UUID
    let amount: Decimal
    let date: Date
    let title: String
    let type: TransactionType
}
