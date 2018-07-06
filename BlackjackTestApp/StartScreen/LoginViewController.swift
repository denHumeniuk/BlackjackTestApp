import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var toPlayButton: UIButton!
    @IBOutlet weak var toHistoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toPlayButton.configProjecButton(title: "Play")
        toHistoryButton.configProjecButton(title: "History")
    }
    
    @IBAction func playButtonAction(_ sender: UIButton){
        performSegue(withIdentifier: "toPlayView", sender: nil)
    }
    
    @IBAction func historyButtonAction(_ sender: UIButton){
        performSegue(withIdentifier: "startToHistory", sender: nil)
    }
    
}
