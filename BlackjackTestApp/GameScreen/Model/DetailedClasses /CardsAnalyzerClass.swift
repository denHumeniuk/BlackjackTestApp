import Foundation

class CardsAnalyzer {
    
    class func getTotalScore(cards: [Card]) -> Int {
        let maxSum = 21
        var acesNumber = 0
        var sum = 0
        cards.forEach{
            switch $0.rank.gameValue {
            case 11:
                acesNumber += 1
            default:
                sum += $0.rank.gameValue
            }
        }
        guard acesNumber != 0 else { return sum }
        guard acesNumber == 1 else { return sum + acesNumber }
        if sum + 11 > maxSum {
            return sum + 1
        } else {
            return sum + 11
        }
    }
    
}
