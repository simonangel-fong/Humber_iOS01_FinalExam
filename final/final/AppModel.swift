//
//  AppModel.swift
//  final
//
//  Created by Simon Fong on 15/12/2023.
//

import Foundation
import UIKit

class characterData:Codable{
    var characterName: String?
    var actorName: String?
    var characterImageThumb: String?
}

class AppModel{

    /// Function to decode Json into target type
    func decodeJson(data:Data)-> [characterData]{
        return try! JSONDecoder().decode([characterData].self, from: data)
    }
  
}
