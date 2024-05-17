//
//  News.swift
//  MethodistMobile
//
//  Created by Q002 on 23/02/2024.
//

import Foundation

// MARK: - News
struct News:Codable {
    let data: [NewsDatum]
    let meta: NewsMeta
}

// MARK: - NewsDatum
struct NewsDatum:Codable, Identifiable {
    let id: Int
    let attributes: PurpleAttributes
}

// MARK: - PurpleAttributes
struct PurpleAttributes:Codable {
    let title, content, date: String
    let author: String?
//    let location: NSNull
    let createdAt, updatedAt, publishedAt: String
    let defaultImage: DefaultImage
    let categories: Categories
    let moreImages: MoreImages
}

// MARK: - Categories
struct Categories:Codable {
    let data: [CategoriesDatum]
}

// MARK: - CategoriesDatum
struct CategoriesDatum:Codable {
    let id: Int
    let attributes: FluffyAttributes
}

// MARK: - FluffyAttributes
struct FluffyAttributes:Codable {
    let name: String?
    let createdAt: String?
    let updatedAt: String?
    let publishedAt: String?
}


enum Name: String {
    case education
    case entertainment
    case health
    case otherNews
    case religious
    case socialServices
}





// MARK: - DefaultImage
struct DefaultImage:Codable {
    let data: DAT
}

// MARK: - DAT
struct DAT:Codable {
    let id: Int
    let attributes: NewsDataAttributes
}

// MARK: - DataAttributes
struct NewsDataAttributes:Codable {
    let name: String
    let alternativeText, caption: String?
    let width, height: Int
    let formats: NewsFormats
    let hash: String
//    let ext: EXT
//    let mime: MIME
    let size: Double
    let url: String
    let previewURL: String?
//    let provider: Provider
    let providerMetadata: String?
    let createdAt, updatedAt: String
}



// MARK: - Formats
struct NewsFormats:Codable {
    let large, small, medium: NewsLarge?
    let thumbnail: NewsLarge
}

// MARK: - Large
struct NewsLarge:Codable {
//    let ext: EXT
    let url: String
    let hash: String
//    let mime: MIME
    let name: String
    let path: String?
    let size: Double
    let width, height: Int
}





// MARK: - MoreImages
struct MoreImages:Codable {
    let data: [DAT]?
}

// MARK: - Meta
struct NewsMeta:Codable {
    let pagination: NewsPagination
}

// MARK: - Pagination
struct NewsPagination:Codable {
    let page, pageSize, pageCount, total: Int
}
