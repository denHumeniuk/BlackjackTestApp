import UIKit

class GameViewController: UIViewController {
    
   let gameModel = GameModel()
    
    var customView: PlayingFieldViewProtocol{
        return self.view as! PlayingFieldViewProtocol
    }
    
    private var isWaitTransition : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameModel.moveCompletion = {[weak self] in self?.moveCompletion($0) }
        gameModel.playerInitial()
    }

    public func moveCompletion(_ actionType: GameActionType) {
        switch actionType{
        case .win(let userName):
            isWaitTransition = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.performSegue(withIdentifier: "playToHistory", sender: userName)
            }
        case .addCard(let card):
            customView.setCard(card)
        case .stand:
            customView.removeCards()
            openHelpViewController()
        case .playerInitial(let cards):
            customView.setCards(cards)
        case .reset:
            customView.removeCards()
        }
    }
    
    //MARK: -Button Action
    
    @IBAction func addCardAction(_ sender: UIButton) {
        guard isWaitTransition == false else { return }
        gameModel.addCard()
    }
    
    @IBAction func passAction(_ sender: UIButton) {
        guard isWaitTransition == false else { return }
        gameModel.standAction()
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        guard isWaitTransition == false else { return }
        gameModel.resetGame()
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        guard isWaitTransition == false else { return }
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Navigation func
    
    func openHelpViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChangeUser") as! ChangePlayerHelpViewController
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "playToHistory" else { return }
        let vc = segue.destination as! HistoryViewController
        vc.model.winnerName = sender as? String
        vc.resetDelegate = self
    }
    
}
    //MARK: - ChangePlayerViewControllerDelegate
extension GameViewController : ChangePlayerViewControllerDelegate {
    
    func tapAction() {
        gameModel.changePlayer()
    }
    
}
    //MARK: - ResetDelegate
extension GameViewController : ResetDelegate {
    
    func resetGame() {
        isWaitTransition = false
        gameModel.resetGame()
    }
    
}



