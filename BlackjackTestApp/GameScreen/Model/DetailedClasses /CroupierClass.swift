import Foundation

class Croupier {
    private var cardDeck : [Card]
    
    init() {
        var cards = [Card]()
        for index in 1...13 {
            cards.append(Card(suit: .spades, rank: Rank.init(rawValue: index) ?? Rank.ace ))
            cards.append(Card(suit: .diamonds, rank: Rank.init(rawValue: index) ?? Rank.ace ))
            cards.append(Card(suit: .clubs, rank: Rank.init(rawValue: index) ?? Rank.ace ))
            cards.append(Card(suit: .hearts, rank: Rank.init(rawValue: index) ?? Rank.ace ))
        }
        cards.shuffle()
        self.cardDeck = cards
    }
    
    public var deckCount: Int {
        return cardDeck.count
    }
    
    func getCard()->Card? {
        guard cardDeck.count > 1 else { return nil }
        let card = cardDeck.removeLast()
        return card
    }
    
    func getCards(_ number: Int = 2)-> [Card]? {
        guard cardDeck.count >= number else { return nil }
        var result = [Card]()
        for _ in 0..<number {
            result.append(cardDeck.removeLast())
        }
        return result
    }
    
    public func resetCardDeck(){
        var cards = [Card]()
        for index in 1...13 {
            cards.append(Card(suit: .spades, rank: Rank.init(rawValue: index) ?? Rank.ace ))
            cards.append(Card(suit: .diamonds, rank: Rank.init(rawValue: index) ?? Rank.ace ))
            cards.append(Card(suit: .clubs, rank: Rank.init(rawValue: index) ?? Rank.ace ))
            cards.append(Card(suit: .hearts, rank: Rank.init(rawValue: index) ?? Rank.ace ))
        }
        cards.shuffle()
        self.cardDeck = cards
    }

}
