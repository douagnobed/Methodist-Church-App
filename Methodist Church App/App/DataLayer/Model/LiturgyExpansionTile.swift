//
//  LiturgyExpansionTile.swift
//  NativeMethodist
//
//  Created by Q002 on 06/02/2024.
//

import Foundation

struct LiturgyExpansionTile: Identifiable{
    var id: Int?
    var emoji:String?
    var title:String
    var liturgyContent:[LiturgyContent]?
}
