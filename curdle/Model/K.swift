

import Foundation
import UIKit


enum matchType {
case notyet, no, imperfect, perfect
}

struct Colors {
    static private let perfectMatchColor = UIColor.purple
    static private let imperfectMatchColor = UIColor.orange
    static private let notMatchColor = UIColor.darkGray
    static private let unMatchColor = UIColor.lightGray
    
    static func matchColor(matchtype: matchType) -> UIColor {
        switch matchtype {
        case .notyet:
            return unMatchColor
        case .no:
            return notMatchColor
        case .imperfect:
            return imperfectMatchColor
        case .perfect:
            return perfectMatchColor
        }
    }
}


struct K {
    static let maxLengthOfWord = 5
    static let maxNumberOfAttempts = 6

    static let appName = "Curdle"
    static let largeTitle = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 40), scale: .large)
    static let defaultTile = "square.dashed"
    static let letterTile = ".square.fill"
    static let filledTile = "square.fill"
    static let defaultTileImage = UIImage(systemName: K.defaultTile, withConfiguration: K.largeTitle)!
    static let filledTileImage = UIImage(systemName: K.filledTile, withConfiguration: K.largeTitle)!
    
    
    static func getNumberPosition(i: Int) -> String {
        let a = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String(a[i])
    }
    
    
    static func getAlphabetPosition(s: String) -> Int {
        return ("ABCDEFGHIJKLMNOPQRSTUVWXYZ".firstIndex(of: Character(s.uppercased()))?.utf16Offset(in: "ABCDEFGHIKLMNOPQRSTUVWXYZ"))!
    }
    
       
    
}

