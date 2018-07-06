import UIKit

protocol HistoryTableViewCellProtocol {
    func configCell(with historyObj: HistoryObject, row: Int, selected: Bool)
}

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player1CardsLabel: UILabel!
    @IBOutlet weak var player1PointLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player2CardsLabel: UILabel!
    @IBOutlet weak var player2PointLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configCell(){
        player1NameLabel.text = "Player1"
        player1CardsLabel.text = "7♥️9♥️8♥️"
        player1PointLabel.text = "24"
        player2NameLabel.text = "Player2"
        player2CardsLabel.text = "7♦️9♠️8♣️"
        player2PointLabel.text = "24"
    }
}

extension HistoryTableViewCell: HistoryTableViewCellProtocol {
    
    func configCell(with historyObj: HistoryObject, row: Int, selected: Bool){
        self.backgroundColor = (row == 0 && selected) ? .yellow : .white
        player1NameLabel.text = historyObj.player1Name
        player1CardsLabel.text = historyObj.player1Cards.joined(separator: " ")
        player1PointLabel.text = String(historyObj.player1Score)
        player2NameLabel.text = historyObj.player2Name
        player2CardsLabel.text = historyObj.player2Cards.joined(separator: " ")
        player2PointLabel.text = String(historyObj.player2Score)
        switch historyObj.player1Win {
        case true:
            player1NameLabel.font = UIFont.boldSystemFont(ofSize: 13)
            player1PointLabel.font = UIFont.boldSystemFont(ofSize: 14)
            player2NameLabel.font = UIFont.systemFont(ofSize: 13)
            player2PointLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.thin)

        default:
            player1NameLabel.font = UIFont.systemFont(ofSize: 13)
            player1PointLabel.font = UIFont.systemFont(ofSize: 13, weight:  UIFont.Weight.thin)
            player2NameLabel.font = UIFont.boldSystemFont(ofSize: 13)
            player2PointLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }
    }
    
}



