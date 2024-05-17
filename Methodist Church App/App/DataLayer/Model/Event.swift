//
//  Event.swift
//  MethodistMobile
//
//  Created by Q002 on 17/02/2024.
//

import Foundation



// MARK: - Event
struct Event:Codable {
    let data: [Datum]
    let meta: Meta
}

// MARK: - Datum
struct Datum:Codable {
    let id: Int
    let attributes: DatumAttributes
}

// MARK: - DatumAttributes
struct DatumAttributes:Codable {
    let title, startDate, endDate, startTime: String
    let location: String?
    let createdAt, updatedAt, publishedAt: String
    let eventImage: EventImage
}

// MARK: - EventImage
struct EventImage:Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass:Codable {
    let id: Int
    let attributes: DataAttributes
}

// MARK: - DataAttributes
struct DataAttributes:Codable {
    let name: String
//    let alternativeText:NSNull
//    let caption: NSNull
    let width, height: Int
    let formats: Formats
    let hash: String
//    let ext: EXT
//    let mime: MIME
    let size: Double
    let url: String
//    let previewURL: NSNull
//    let provider: Provider
//    let providerMetadata: NSNull
    let createdAt, updatedAt: String
}

enum EXT: String {
    case jpeg
    case jpg
}

// MARK: - Formats
struct Formats:Codable {
    let small, thumbnail: Large
    let large, medium: Large?
}

// MARK: - Large
struct Large:Codable {
//    let ext: EXT
    let url: String
    let hash: String
//    let mime: MIME
    let name: String
//    let path: NSNull
    let size: Double
    let width, height: Int
}

enum MIME: String {
    case imageJPEG
}

enum Provider: String {
    case ntegralStrapiProviderUploadAzureStorageBlob
}

// MARK: - Meta
struct Meta:Codable {
    let pagination: Pagination
}

// MARK: - Pagination
struct Pagination:Codable {
    let page, pageSize, pageCount, total: Int
}

