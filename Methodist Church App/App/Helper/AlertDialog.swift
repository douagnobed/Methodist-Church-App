//
//  AlertDialog.swift
//  MethodistMobile
//
//  Created by Q002 on 23/02/2024.
//

import Foundation
import SwiftUI

struct AlertDialog{
   static let tokenAlert = AlertItem(
        id: 1,
        title: "Authentication", message: "Your LOGIN authorization token has expired", button: Alert.Button.cancel(Text("Authenticate")), action: AlertItemActionType.unauthenticate)
    
    static let unauthorized = AlertItem(
        id: 1,
        title: "UnAuthorized", message: "Your LOGIN authorization token has expired. Go back and login", button: .default(Text("Authenticate")), action: AlertItemActionType.unauthenticate)
    
    
}
