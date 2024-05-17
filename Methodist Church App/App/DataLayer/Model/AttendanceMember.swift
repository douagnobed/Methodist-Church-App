//
//  AttendanceMember.swift
//  MethodistMobile
//
//  Created by Q002 on 22/02/2024.
//

import Foundation

struct AttendanceMemberList:Codable{
    let data: [AttendanceMember]
}
struct AttendanceMember:Codable, Identifiable{
    let id:String
    let firstName:String
    let lastName:String
    let username:String
}

