//
//  OrganizationMember.swift
//  MethodistMobile
//
//  Created by Q002 on 22/02/2024.
//

import Foundation

struct OrganizationMember:Codable{
    let memberId:String
    let organizationId:String
    let positionId:String
    let joinDate:String
    let organizationMemberStatus:Int
}

