//
//  Organization.swift
//  MethodistMobile
//
//  Created by Q002 on 22/02/2024.
//

import Foundation

struct OrganizationList:Codable{
    let data: [Organization]
}

struct Organization: Codable, Identifiable{
    let id: String
    let systemOrganizationId: String
    let organizationName: String
    let inauguratedDate: String
    let inauguratedNumber: Int
}
