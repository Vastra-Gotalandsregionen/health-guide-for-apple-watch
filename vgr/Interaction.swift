import Foundation

enum InteractionType {
    case throat
    case foot
    case generic
}

struct Interaction {
    let keyword: String
    let answer: String
    let type: InteractionType
}
