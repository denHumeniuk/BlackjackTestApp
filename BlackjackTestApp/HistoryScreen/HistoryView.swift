import UIKit

protocol HistoryViewDataSource: class {
    var numberOfRow: Int {get}
    var isNeedSelect: Bool {get}
    func historyObject(at index: Int)->HistoryObject
}

class HistoryView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var loserPlayerLabel: UILabel!
    
    weak var viewDataSource: HistoryViewDataSource?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUIElement()
    }

    private func configUIElement(){
        resetButton.configProjecButton(title: "Play again", bgColor: .red)
        backButton.configProjecButton(title: "Home", bgColor: .gray)
        tableView.layer.borderColor = UIColor.yellow.cgColor
        tableView.layer.borderWidth = 3
        tableView.layer.cornerRadius = 8
        tableView.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HistoryView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewDataSource?.numberOfRow ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as? HistoryTableViewCell
        guard cell != nil else { return UITableViewCell() }
        cell!.configCell(with: viewDataSource!.historyObject(at: indexPath.row), row: indexPath.row, selected: viewDataSource?.isNeedSelect ?? false)
        
        return cell!
    }
    
}
extension HistoryView {
    
    public func setWinersName(name: String?){
        guard name != nil else {
            resetButton.isHidden = true
            return
        }
        //winnerPlayerLabel.text = "\(name!) win !!!"
        
        let loserName = name! == "Player 1" ? "Player 2" : "Player 1"
        loserPlayerLabel.text = "\(loserName) lost ((((("
        
        UIView.animate(withDuration: 0.4) {
            self.loserPlayerLabel.alpha = 1
        }
    }
    
}
