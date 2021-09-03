//
//  raeProfile.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 8/2/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import CloudKit
import UIKit

struct raeProfile: Identifiable {

    static let kFirstName           = "firstName"
    static let kLastName            = "lastName"
    static let kCompanyName         = "companyName"
    static let kBio                 = "bio"
    static let kAvatar              = "avatar"
    static let kIsCheckedIn         = "isCheckedIn"
    static let kIsCheckedInNilCheck = "isCheckedInNilCheck"
    
    let id: CKRecord.ID
    let firstName: String
    let lastName: String
    let companyName: String
    let bio: String
    let avatar: CKAsset!
    let isCheckedIn: CKRecord.Reference?
    
    init(record: CKRecord) {
        id          = record.recordID
        firstName   = record[raeProfile.kFirstName] as? String ?? "N/A"
        lastName    = record[raeProfile.kLastName] as? String ?? "N/A"
        companyName = record[raeProfile.kCompanyName] as? String ?? "N/A"
        bio         = record[raeProfile.kBio] as? String ?? "N/A"
        avatar      = record[raeProfile.kAvatar] as? CKAsset
        isCheckedIn = record[raeProfile.kIsCheckedIn] as? CKRecord.Reference
    }
    
    
    func createAvatarImage() -> UIImage {
        guard let avatar = avatar else { return PlaceholderImage.avatar }
        return avatar.convertToUIImage(in: .square)
    }
}
