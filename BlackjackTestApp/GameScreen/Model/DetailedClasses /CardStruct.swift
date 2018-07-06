import UIKit

enum Suit: String {
    case spades, hearts, diamonds, clubs
    
    var description: String {
        switch self {
        case .spades:
            return "♠️"
        case .hearts:
            return "♥️"
        case .diamonds:
            return "♦️"
        case .clubs:
            return "♣️"
        }
    }
}

enum Rank: Int {
    case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
    
    var gameValue : Int {
        switch self {
        case .ace:
            return 11
        case .jack, .queen, .king:
            return 10
        default:
            return rawValue
        }
    }
    
    var description: String {
        switch self {
        case .jack:
            return "J"
        case .queen:
            return "Q"
        case .king:
            return "K"
        case .ace:
            return "A"
        default:
            return String(describing: rawValue)
        }
    }
}

struct Card: Equatable {
    let suit: Suit
    let rank:  Rank
    
    var description: String {
        return "\(rank.description)\(suit.description)"
    }
    
    var image: UIImage {
        let imageString = "\(rank.rawValue)_of_\(suit.rawValue)"
        return UIImage(named: imageString) ?? UIImage()
    }
}

func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.rank == rhs.rank
}
func !=(lhs: Card, rhs: Card) -> Bool {
    return lhs.suit != rhs.suit && lhs.rank != rhs.rank
}
