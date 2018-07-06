import Foundation

    
final class ProjectDataBase {
    
    private init() {}
        
    static let shared = ProjectDataBase()
    
    let defaults = UserDefaults.standard
    
    private let historyKey = "historyArray"
    private(set) var historyArray: [HistoryObject]  {
        set(newValue){
            updateDataFor(key: historyKey, newValue : newValue)
        }
        get {
            return returnValueFor(key: historyKey)
        }
    }
    
    
    public func addHistoryObject(_ obj: HistoryObject){
        var array = returnValueFor(key: historyKey)
        array.insert(obj, at: 0)
        if array.count > 20 { array.removeLast(1) }
        historyArray = array
    }
    
    private func updateDataFor(key: String, newValue : [HistoryObject] ){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(newValue) {
             defaults.set(encoded, forKey: key)
        }
    }
    
    private func returnValueFor(key: String) -> [HistoryObject] {
        let decoder = JSONDecoder()
        guard let savedObj = defaults.object(forKey: historyKey) as? Data, let objArray = try? decoder.decode([HistoryObject].self, from: savedObj) else {
            return [HistoryObject]()
        }
        return objArray
    }
    
}



