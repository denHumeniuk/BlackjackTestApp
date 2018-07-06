import UIKit

protocol ChangePlayerViewControllerDelegate: class {
    func tapAction()
}

class ChangePlayerHelpViewController: UIViewController {
    
    @IBOutlet weak var animatedView: UIView!
    
    weak var delegate: ChangePlayerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        animatedView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeAlphaAnimation(view: animatedView, newAlpha: 0.85)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        changeAlphaAnimation(view: animatedView, newAlpha: 0)
    }
    
    private func changeAlphaAnimation(view: UIView, newAlpha: CGFloat){
        UIView.animate(withDuration: 0.5, animations: {
            view.alpha = newAlpha
        })
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        delegate?.tapAction()
        self.dismiss(animated: false, completion: nil)
    }
    
}

