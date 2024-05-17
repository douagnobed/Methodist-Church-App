//
//  SocietyEvent.swift
//  MethodistMobile
//
//  Created by Q002 on 22/02/2024.
//

import Foundation

struct SocietyEventList:Codable{
    let data: [SocietyEvent]
}

struct SocietyEvent:Codable, Identifiable{
    let id:String
    let eventTitle:String
    let content:String
    let location:String
    let eventDays:String
    let eventTime: String
    let isPublished: Bool
    let isBroadcasted:Bool
    let fileId:String
    let startDate: String
    let endDate:String
}

