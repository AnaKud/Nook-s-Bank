//
//  KeychainService.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 12.07.2021.
//

import Foundation
import Security

protocol IKeychainService {
    func savePassword(account: String, password: String)
    func loadPassword(account: String) -> String?
    func removePassword(account: String)
}

class KeychainService: NSObject, IKeychainService {
    static let shared = KeychainService()

    private let service = "userLogin"
    
    func savePassword(account: String, password: String) {
        if let passwordData = password.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            let keychainQuery: NSMutableDictionary = [kSecClass as String: kSecClassGenericPassword,
                                                      kSecAttrService as String: service,
                                                      kSecAttrAccount as String: account,
                                                      kSecValueData as String: passwordData]
            let status = SecItemAdd(keychainQuery as CFDictionary, nil)
            
            switch status {
            case errSecSuccess:
                print("PasswordSaved")
                break
            default:
                print("Write failed: \(status)")
            }
        }
    }
    
    func loadPassword(account: String) -> String? {
        let keychainQuery: NSMutableDictionary = [kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true]
        
        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String?
        
        guard status != errSecItemNotFound,
              status != errSecSuccess,
              let retrievedData = dataTypeRef as? Data
        else {
            print("Write failed: \(status)")
            return nil
        }
        contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
        return contentsOfKeychain
    }
    
    func removePassword(account: String) {
        let keychainQuery: NSMutableDictionary =  [kSecClass as String: kSecClassGenericPassword,
                                                   kSecAttrAccount as String: account,
                                                   kSecAttrService as String: service,
                                                   kSecMatchLimit as String: kSecMatchLimitOne,
                                                   kSecReturnAttributes as String: true,
                                                   kSecReturnData as String: true]
        let status = SecItemDelete(keychainQuery as CFDictionary)
        switch status {
        case errSecSuccess:
            print("success")
        default:
            print("Remove failed: \(SecCopyErrorMessageString(status, nil))")
        }
    }
}
