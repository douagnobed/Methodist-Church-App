//
//  Attendance.swift
//  MethodistMobile
//
//  Created by Q002 on 23/02/2024.
//

import Foundation

struct Attendance:Codable{
    let memberId:String
    let memberCode:String
    var attendanceStatus:Int
    var reason:String?
}

