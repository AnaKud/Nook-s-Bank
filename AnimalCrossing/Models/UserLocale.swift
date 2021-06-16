//
//  UserLocale.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 14.06.2021.
//

import Foundation
import Firebase

struct UserLocale {
    let uid: String
    let email: String
    
    init?(user: User) {
        self.uid = user.uid
        guard let userEmail = user.email else { return nil }
        self.email = userEmail
    }
}
