//
//  raeMoon.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 8/2/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import CloudKit
import UIKit

struct raeMoon: Identifiable {
    static let kMoonNumber          = "moonNumber"
    static let kMoonPhase           = "moonPhase"
    static let kSecondaryName       = "secondaryName"
    static let kPositiveDescription = "positiveDescription"
    static let kPositiveWhy         = "positiveWhy"
    static let kAvoidDescription    = "avoidDescription"
    static let kAvoidWhy            = "avoidWhy"
    static let kGeneralWhy          = "generalWhy"
    static let kAgileAsset          = "agileAsset"
    
    let id: CKRecord.ID
    let moonNumber: String
    let moonPhase: String
    let secondaryName: String
    let positiveDescription: String
    let positiveWhy: String
    let avoidDescription: String
    let avoidWhy: String
    let generalWhy: String
    let agileAsset: CKAsset!
    
    init(record: CKRecord) {
        id                  = record.recordID
        moonNumber          = record[raeMoon.kMoonNumber] as? String ?? "N/A"
        moonPhase           = record[raeMoon.kMoonPhase] as? String ?? "N/A"
        secondaryName       = record[raeMoon.kSecondaryName] as? String ?? "N/A"
        positiveDescription = record[raeMoon.kPositiveDescription] as? String ?? "N/A"
        positiveWhy         = record[raeMoon.kPositiveWhy] as? String ?? "N/A"
        avoidDescription    = record[raeMoon.kAvoidDescription] as? String ?? "N/A"
        avoidWhy            = record[raeMoon.kAvoidWhy] as? String ?? "N/A"
        generalWhy          = record[raeMoon.kGeneralWhy] as? String ?? "N/A"
        agileAsset          = record[raeMoon.kAgileAsset] as? CKAsset
    }
    
    
    func createAgileImage() -> UIImage {
        guard let asset = agileAsset else { return PlaceholderImage.banner }
        return asset.convertToUIImage(in: .banner)
    }
}
