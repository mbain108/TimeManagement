//
//  raeLocation.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 8/2/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import CloudKit
import UIKit

struct raeLocation: Identifiable {
    static let kName        = "name"
    static let kDescription = "description"
    static let kSquareAsset = "squareAsset"
    static let kBannerAsset = "bannerAsset"
    static let kAddress     = "address"
    static let kLocation    = "location"
    static let kWebsiteURL  = "websiteURL"
    static let kPhoneNumber = "phoneNumber"
    
    let id: CKRecord.ID
    let name: String
    let description: String
    let squareAsset: CKAsset!
    let bannerAsset: CKAsset!
    let address: String
    let location: CLLocation
    let websiteURL: String
    let phoneNumber: String
    
    init(record: CKRecord) {
        id          = record.recordID
        name        = record[raeLocation.kName] as? String ?? "N/A"
        description = record[raeLocation.kDescription] as? String ?? "N/A"
        squareAsset = record[raeLocation.kSquareAsset] as? CKAsset
        bannerAsset = record[raeLocation.kBannerAsset] as? CKAsset
        address     = record[raeLocation.kAddress] as? String ?? "N/A"
        location    = record[raeLocation.kLocation] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        websiteURL  = record[raeLocation.kWebsiteURL] as? String ?? "N/A"
        phoneNumber = record[raeLocation.kPhoneNumber] as? String ?? "N/A"
    }
    
    
    func createSquareImage() -> UIImage {
        guard let asset = squareAsset else { return PlaceholderImage.square }
        return asset.convertToUIImage(in: .square)
    }
    
    
    func createBannerImage() -> UIImage {
        guard let asset = bannerAsset else { return PlaceholderImage.banner }
        return asset.convertToUIImage(in: .banner)
    }
}
