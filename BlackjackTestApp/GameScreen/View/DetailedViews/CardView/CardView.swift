import UIKit


class CardView: UIView {
    
    @IBOutlet private weak var cardImageView: UIImageView!
    
    private var frontCardImage: UIImage!
    private var backCardImage: UIImage! = #imageLiteral(resourceName: "back")
    
    private var isOpen: Bool = false {
        didSet{
            guard isOpen != oldValue else { return }
            let image = isOpen ? frontCardImage : backCardImage
            let option: UIViewAnimationOptions = isOpen ? .transitionFlipFromRight : .transitionFlipFromLeft
            UIView.transition(with: cardImageView,
                              duration: 0.4,
                              options: option,
                              animations: {
                                  self.cardImageView.image = image
                              },
                              completion: nil)
        }
    }
    
    
    
    //MARK: - Init and setup FUNC
    private var nibName = "CardView"
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
        startConfig()
    }
    
    private func startConfig(){
        cardImageView.image = backCardImage
        cardImageView.layer.cornerRadius = 8
        cardImageView.clipsToBounds = true
    }
}

//MARK: - Public interface
extension CardView {
    
    public func configCardView(with card: Card){
        self.frontCardImage = card.image
    }
    public func openCard(){
        guard !isOpen else { return }
        isOpen = true
    }
    public func changeStatus(){
        self.isOpen = !isOpen
    }
   
}
