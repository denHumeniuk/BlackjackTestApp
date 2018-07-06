import Foundation

enum GameActionType {
    case playerInitial([Card]), addCard(Card), stand, win(String), reset
}

class GameModel {
    
    private let maxScore = 21
    
    private var croupier: Croupier!
    
    private var player1:Player!
    private var player2: Player!
    
    private var currentPlayer: Player!
    
    public var moveCompletion: ((GameActionType) -> ())?
    
    init() {
        self.croupier = Croupier()
        guard croupier.deckCount > 4 else { fatalError("start init, a deck of cards must have 52 cards") }
        self.player1 = Player(cards:croupier.getCards()!, name: "Player 1")
        self.player1.updateScore()
        self.player2 = Player(cards: croupier.getCards()!, name: "Player 2")
        self.player2.updateScore()
        self.currentPlayer = player1
    }

    private func changeNextStep(cards: [Card]){
        let totalScore = CardsAnalyzer.getTotalScore(cards: currentPlayer.getHandCards())
        switch totalScore {
        case 0..<maxScore:
            print("\(totalScore) < \(maxScore)")
        case maxScore:
            saveToHistory(isCurrentPlayer: true)
            moveCompletion?(.win(getWinPlayerName(isCurrent: true)))
        default:
            saveToHistory(isCurrentPlayer: false)
            moveCompletion?(.win(getWinPlayerName(isCurrent: false)))
        }
    }
    
    private func getWinPlayerName(isCurrent: Bool)->String{
        if isCurrent {
            return currentPlayer.name
        } else {
            switch currentPlayer {
            case player1:
                return player2.name
            case player2:
                return player1.name
            default:
                print("default")
                return currentPlayer.name
            }
        }
    }
    
    private func comparisonOfScore(){
        let player1Sscore = CardsAnalyzer.getTotalScore(cards: player1.getHandCards())
        let player2Sscore = CardsAnalyzer.getTotalScore(cards: player2.getHandCards())
        let winPlayer: Player = player1Sscore > player2Sscore ? player1 : player2
        saveToHistory(isCurrentPlayer: winPlayer == currentPlayer)
        moveCompletion?(.win(winPlayer.name))
    }
    
    private func saveToHistory(isCurrentPlayer: Bool){
        let historyObject = HistoryObject(player1Name: player1.name, player2Name: player2.name, player1Cards: player1.getCardsDescription(), player2Cards: player2.getCardsDescription(), player1Score: player1.score, player2Score: player2.score, player1Win: getWinPlayerName(isCurrent: isCurrentPlayer) == player1.name ? true : false)
        ProjectDataBase.shared.addHistoryObject(historyObject)
    }

}
    //MARK: - Public interface
extension GameModel {
    
    public func playerInitial(){
        moveCompletion?(.playerInitial(currentPlayer.getHandCards()))
        changeNextStep(cards: currentPlayer.getHandCards())
    }
    
    public func addCard(){
        guard let card = croupier.getCard() else { return }
        guard !currentPlayer.isCardLimit, CardsAnalyzer.getTotalScore(cards: currentPlayer.getHandCards()) < maxScore else { return }
        currentPlayer.addNewCard(card)
        moveCompletion?(.addCard(card))
        changeNextStep(cards: currentPlayer.getHandCards())
    }
    
    public func standAction(){
        guard currentPlayer.score < maxScore else { return }
        switch currentPlayer {
        case player1:
            moveCompletion?(.stand)
        default:
           comparisonOfScore()
        }
    }
    
    public func changePlayer(){
        currentPlayer = player2
        moveCompletion?(.playerInitial(player2.getHandCards()))
        changeNextStep(cards: currentPlayer.getHandCards())
    }
    
    public func resetGame(){
        moveCompletion?(.reset)
        croupier.resetCardDeck()
        player1.newGameConfig(cards: croupier.getCards()!)
        player2.newGameConfig(cards: croupier.getCards()!)
        self.currentPlayer = player1
        moveCompletion?(.playerInitial(currentPlayer.getHandCards()))
        changeNextStep(cards: currentPlayer.getHandCards())
    }
    
}




