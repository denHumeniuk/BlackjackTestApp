import UIKit


class PlayerHandView: UIView {
    
    @IBOutlet private var placesForCard: [PlaceForCardView]!
    
    private var borderColor: UIColor = .yellow
    
    //MARK: - Init and setup FUNC
    private var nibName = "PlayerHandView"
    private var nibView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func loadFromNib()-> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    private func setup() {
        nibView = loadFromNib()
        nibView.frame = bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(nibView)
        nibView.layer.borderWidth = 4
        nibView.layer.borderColor = borderColor.cgColor
        nibView.layer.cornerRadius = 8
        nibView.clipsToBounds = true
    }
    
}
//MARK: - Public interface
extension PlayerHandView {
    
    public func setCard(_ card: Card){
        var needUpdate = true
        placesForCard.forEach{
            if !$0.cardInPlace, needUpdate {
                $0.setCard(card)
                needUpdate = false
            }
        }
    }
    
    public func setCards(_ cards: [Card]){
        var newCards = cards
        placesForCard.forEach{
            if !$0.cardInPlace, newCards.count > 0 {
                $0.setCard(newCards.removeFirst())
            }
        }
        
    }
    
    public func changeCardsOpenStatus(){
        placesForCard.forEach{
            $0.changeCardOpenStatus()
        }
    }
    
    public func removeCards(){
        placesForCard.forEach{
            $0.removeCard()
        }
    }
}

