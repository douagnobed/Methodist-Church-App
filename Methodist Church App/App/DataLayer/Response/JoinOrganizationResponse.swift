//
//  JoinOrganizationResponse.swift
//  MethodistMobile
//
//  Created by Q002 on 22/02/2024.
//

import Foundation

struct JoinOrganizationResponse:Codable, Identifiable{
    let id: String
    let societyId:String
    let societyName:String
    let memberId:String
    let memberName:String
    let organization:String
    let position:String
    let joinDate:String
    let isAMember:Bool
    let organizationMemberStatus:Int
}

