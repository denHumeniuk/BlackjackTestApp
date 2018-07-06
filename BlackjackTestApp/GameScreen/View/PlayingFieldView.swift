import UIKit

protocol PlayingFieldViewProtocol {
    
    func setCard(_ card: Card)
    func setCards(_ cards: [Card])
    func changeCardsOpenStatus()
    func removeCards()
    
}

class PlayingFieldView: UIView {
    
    @IBOutlet weak var addCardButton: UIButton!
    @IBOutlet weak var passButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var playerHandView: PlayerHandView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUIElement()
    }
    
    private func configUIElement(){
        addCardButton.configProjecButton(title: "Take card")//"Hit")
        passButton.configProjecButton(title: "Skip turn")//"Stand")
        resetButton.configProjecButton(title: "Reset", bgColor: .gray)
        backButton.configProjecButton(title: "Exit", bgColor: .gray)
    }
}

extension PlayingFieldView: PlayingFieldViewProtocol {
    
    func setCard(_ card: Card){
        playerHandView.setCard(card)
    }
    func setCards(_ cards: [Card]){
        playerHandView.setCards(cards)
    }
    func changeCardsOpenStatus(){
        playerHandView.changeCardsOpenStatus()
    }
    func removeCards() {
        playerHandView.removeCards()
    }
    
}


