//
//  MockData.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 8/2/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import CloudKit

struct MockData {
    
    static var location: CKRecord {
        let record                          = CKRecord(recordType: RecordType.location)
        record[raeLocation.kName]           = "Sean's Bar and Grill"
        record[raeLocation.kAddress]        = "123 Main Street"
        record[raeLocation.kDescription]    = "This is a test decription. Isn't it awesome. Not sure how long to make it to test the 3 lines."
        record[raeLocation.kWebsiteURL]     = "https://seanallen.co"
        record[raeLocation.kLocation]       = CLLocation(latitude: 37.331516, longitude: -121.891054)
        record[raeLocation.kPhoneNumber]    = "111-111-1111"
        
        return record
    }
    
    static var profile: CKRecord {
        let record                          = CKRecord(recordType: RecordType.profile)
        record[raeProfile.kFirstName]       = "Anandhi"
        record[raeProfile.kLastName]        = ""
        record[raeProfile.kCompanyName]     = "MB Consulting"
        record[raeProfile.kBio]             = "This is my bio. I hope it's not too long. I cannot check the character count."
        
        return record
    }
    
    static var moon: CKRecord {
        let record = CKRecord(recordType: RecordType.moon)
        
        record[raeMoon.kMoonNumber]             = "3rd"
        record[raeMoon.kMoonPhase]              = "waning"
        record[raeMoon.kSecondaryName]          = "tritiyai"
        record[raeMoon.kPositiveDescription]    = "Mock Data: This is a day for education and growing. Teach a class or workshop; use improv; tell others how your services could benefit them."
        record[raeMoon.kPositiveWhy]            = "The energy today is about education, developing creative skills, and working with other people."
        record[raeMoon.kAvoidDescription]       = "Mock Data: You may find it harder than usual to work with abrasive individuals or confront someone about their “bad” behavior."
        record[raeMoon.kAvoidWhy]               = "Today is a time of harmoniously expanding people’s skills, not challenging anyone"
        record[raeMoon.kGeneralWhy]             = "general why"
        record[raeMoon.kAgileAsset]             = "agile asset"
        
        return record
    }
}
