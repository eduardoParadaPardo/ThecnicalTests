//
//  Base64Helper.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 24/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class MD5Helper {
    
    class func MD5(string: String) -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        guard let messageData = string.data(using: .utf8) else {
            print("data is nil - MD5")
            return nil
        }
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        
        let md5Hex =  digestData.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex
    }
}
