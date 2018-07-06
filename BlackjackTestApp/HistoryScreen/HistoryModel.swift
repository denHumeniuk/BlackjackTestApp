import Foundation


class HistoryModel {
    
    private var historyArray : [HistoryObject] {
        return ProjectDataBase.shared.historyArray
    }
    
    public var winnerName: String? = nil
    
    public var historyCount : Int {
        return historyArray.count
    }
    public func historyObject(at index: Int)->HistoryObject{
        return historyArray[index]
    }
    
}

