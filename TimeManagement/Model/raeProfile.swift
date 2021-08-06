//
//  raeProfile.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 8/2/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import CloudKit
import UIKit

struct raeProfile {
    
    static let kFirstName   = "firstName"
    static let kLastName    = "lastName"
    static let kBio         = "bio"
    static let kAvatar      = "avatar"
    static let kIsCheckedIn = "isCheckedIn"
    
    let ckRecordID: CKRecord.ID
    let firstName: String
    let lastName: String
    let bio: String
    let avatar: CKAsset!
    let isCheckedIn: CKRecord.Reference? = nil
    
    init(record: CKRecord) {
        ckRecordID  = record.recordID
        firstName   = record[raeProfile.kFirstName] as? String ?? "N/A"
        lastName    = record[raeProfile.kLastName] as? String ?? "N/A"
        bio         = record[raeProfile.kBio] as? String ?? "N/A"
        avatar      = record[raeProfile.kAvatar] as? CKAsset
    }
    
    func createAvatarImage() -> UIImage {
        guard let avatar = avatar else { return PlaceholderImage.avatar }
        return avatar.convertToUIImage(in: .square)
    }
}
