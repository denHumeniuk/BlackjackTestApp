import UIKit

extension UIButton {
    
    public func configProjecButton(title: String, bgColor: UIColor = .red){
        self.backgroundColor = bgColor
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 8
        self.layer.masksToBounds = false
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = 15
    }
    
}
