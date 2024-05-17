//
//  Evangelism.swift
//  MethodistMobile
//
//  Created by Q002 on 18/02/2024.
//

import Foundation

struct Evangelism:Identifiable{
    var id: Int
    var imageUrl:String
    var title:String
    var subTitle:String
    var content: [EvangelismContent]? 
}

struct EvangelismContent:Identifiable{
    var id: Int
    var title:String
    var subContent: [EvangelismSubContent]?
}

struct EvangelismSubContent:Identifiable{
    var id: Int
    var title: String
    var content:String
}
