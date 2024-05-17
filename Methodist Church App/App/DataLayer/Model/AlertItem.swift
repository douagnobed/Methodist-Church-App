//
//  AlertItem.swift
//  MethodistMobile
//
//  Created by Q002 on 22/02/2024.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable{
    var id: Int
    let title: String
    let message: String
    let button: SwiftUI.Alert.Button?
    var action: AlertItemActionType? = AlertItemActionType.nothing
}

enum AlertItemActionType {
    case nothing
    case unauthenticate
    
}
