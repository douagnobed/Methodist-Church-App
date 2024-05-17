//
//  Church.swift
//  MethodistMobile
//
//  Created by Q002 on 26/02/2024.
//

import Foundation

struct Churches:Codable{
    let data: [Church]
}

struct Church:Codable, Identifiable{
    let id:String
    let churchCode:String
    let dateEstablished:String
    let societyName:String
    let foundationStone:String
    let postalAddress:String
    let gpsAddress:String?
    let smsQuantity:Int?
    let town:String
    let region:String
    let callContact:String?
    let email:String?
    let latitude:String?
    let longitude:String?
    let publicKey:String?
    let secretKey:String?
    let paystackStatus:String?
    let paystackCallback:String?
    let paystackWebhook:String?
    let churchPassword:String?
    
}

