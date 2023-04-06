//
//  LocalizedString.swift
//  Sloth
//
//  Created by JAEHA JU on 2023/04/06.
//

import Foundation

class LocalizedString {
    
    class Main {
        
        static var warmingUp = "Warming up".localized
        static var start = "Start".localized
        static var finish = "Finish".localized
    }
}

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}


