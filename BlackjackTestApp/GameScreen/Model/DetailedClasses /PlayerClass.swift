import Foundation

class Player: NSObject {
    
    private var cards: [Card] {
        didSet {
            guard cards != oldValue else { return }
            updateScore()
        }
    }
    var score: Int = 0
    
    var name: String!
    
    init(cards: [Card] = [], name: String) {
        self.cards = cards
        self.name = name
    }
    override init() {
        self.cards = []
        self.name = ""
    }
    
    public func addNewCard(_ card: Card){
        cards.append(card)
    }
    public func getHandCards()->[Card]{
        return cards
    }
    
    public var isCardLimit: Bool {
        return cards.count >= 5
    }
    
    public func newGameConfig(cards: [Card]){
        self.cards = cards
    }
    public func getCardsDescription()->[String]{
        let result = cards.map{ $0.description }
        return result
    }
    
    public func updateScore(){
        self.score = CardsAnalyzer.getTotalScore(cards: cards)
    }

}



