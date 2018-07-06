import UIKit


class PlaceForCardView: UIView {
    
    @IBOutlet private weak var cardView: CardView!
    
    private var borderColor: UIColor = .white
    
    public var cardInPlace: Bool = false {
        didSet {
            changeCardViewAlpha(isHidden: !cardInPlace)
        }
    }
    
    //MARK: - Init and setup FUNC
    private var nibName = "PlaceForCardView"
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
        nibView.layer.borderWidth = 2
        nibView.layer.borderColor = borderColor.cgColor
        nibView.layer.cornerRadius = 8
        nibView.clipsToBounds = true
        setupView()
       
    }
    
    private func setupView(){
        cardView.alpha = 0
    }
    
}
//MARK: - Public interface
extension PlaceForCardView {
    
    public func setCard(_ card: Card){
        guard cardInPlace == false else { return }
        cardView.configCardView(with: card)
        cardInPlace = !cardInPlace
    }
    
    public func changeCardOpenStatus(){
        cardView.changeStatus()
    }
    
    public func removeCard(){
        guard cardInPlace == true else { return }
        cardView.changeStatus()
        cardInPlace = !cardInPlace
    }
    
}

//MARK: - Help func

extension PlaceForCardView {
    
    private func changeCardViewAlpha(isHidden: Bool){
        let newValue: CGFloat = isHidden ? 0 : 1
        guard newValue != cardView.alpha else { return }
        UIView.animate(withDuration: 0.4, animations: {
            self.cardView.alpha = newValue
        }, completion: {(bool) in
            guard bool else { return }
            if !isHidden {
                self.cardView.changeStatus()
            }
        })
    }
    
}
