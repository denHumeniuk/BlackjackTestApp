import Foundation

struct HistoryObject: Codable {
    
    var player1Name : String
    var player2Name : String
    
    var player1Cards : [String]
    var player2Cards : [String]
    
    var player1Score : Int
    var player2Score : Int
    
    var player1Win: Bool
    
}
