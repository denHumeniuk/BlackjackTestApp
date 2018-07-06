import UIKit

protocol ResetDelegate: class {
    func resetGame()
}


class HistoryViewController: UIViewController {
    
    weak var resetDelegate: ResetDelegate?
    
    let model = HistoryModel()
    
    var cutomView: HistoryView {
        return self.view as! HistoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cutomView.viewDataSource = self
        cutomView.setWinersName(name: model.winnerName)
    }
    
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        resetDelegate?.resetGame()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func homeButtonAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}

extension HistoryViewController: HistoryViewDataSource {
    
    var isNeedSelect: Bool {
        return model.winnerName != nil
    }
    
    var numberOfRow: Int {
        return model.historyCount
    }
    
    func historyObject(at index: Int) -> HistoryObject {
        return model.historyObject(at: index)
    }
    
    
}
