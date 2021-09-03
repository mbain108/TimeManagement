//
//  CKRecord+Ext.swift
//  Rae Time Management
//
//  Created by Melissa Bain on 8/2/21.
//  Copyright © 2021 MB Consulting. All rights reserved.
//

import CloudKit

extension CKRecord {
    func convertToraeLocation() -> raeLocation { raeLocation(record: self) }
    func convertToraeMoon() -> raeMoon { raeMoon(record: self) }
    func convertToraeProfile() -> raeProfile { raeProfile(record: self) }
}
