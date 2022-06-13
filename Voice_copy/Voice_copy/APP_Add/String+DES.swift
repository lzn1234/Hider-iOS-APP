//
//  String+DES.swift
//  Voice_copy
//
//  Created by putao on 2022/6/13.
//

import Foundation
import CommonCrypto

extension String {
    // MARK: 字典转字符串
    init(_ dic:[String : Any]) {
        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
        self = String(data: data!, encoding: String.Encoding.utf8) ?? ""
    }
    
    func desEncrypt(key: String) -> String {
        guard key.count >= kCCKeySizeDES else {
            return ""
        }
        guard let inputData = self.data(using: .utf8) else {
            return ""
        }
        var desKey = key
        if desKey.count > kCCKeySizeDES {
            desKey = String(desKey[desKey.startIndex..<desKey.index(desKey.startIndex, offsetBy: kCCKeySizeDES)])
        }
        
        guard let keyData = desKey.data(using: .utf8, allowLossyConversion: false) else {
            return ""
        }
        let keyBytes = keyData.bytes
        let ivBytes = keyData.bytes
        
        let inputLength = inputData.count
        let inputBytes = inputData.bytes
        
        let outputLength = inputLength + kCCBlockSizeDES
        let outputBytes = UnsafeMutablePointer<UInt8>.allocate(capacity: outputLength)
        
        var bytesEncrypted: Int = 0
        let cryptStatus = CCCrypt(CCOperation(kCCEncrypt),
                                  CCAlgorithm(kCCAlgorithmDES),
                                  CCOptions(kCCOptionPKCS7Padding),
                                  keyBytes,
                                  kCCKeySizeDES,
                                  ivBytes,
                                  inputBytes,
                                  inputLength,
                                  outputBytes,
                                  outputLength,
                                  &bytesEncrypted)
        if cryptStatus == kCCSuccess && bytesEncrypted <= outputLength {
            let outputString = Data(bytes: outputBytes, count: bytesEncrypted).toHexString()
            return outputString
        } else {
            outputBytes.deallocate()
        }
        return ""
    }
    
    func desDecrypt(key: String) -> String {
        if let keyData = key.data(using: .utf8),
           let data = Data(fromHexEncodedString: self) {
            var numBytesDecrypted: size_t = 0
            var result = Data(count: data.count)
            
            let ivBytes = keyData.bytes
            let err = result.withUnsafeMutableBytes { (resultBytes) in
                data.withUnsafeBytes {(dataBytes) in
                    keyData.withUnsafeBytes {(keyBytes) in
                        CCCrypt(CCOperation(kCCDecrypt),
                                CCAlgorithm(kCCAlgorithmDES),
                                CCOptions(kCCOptionPKCS7Padding|kCCModeECB),
                                keyBytes,
                                kCCKeySizeDES,
                                ivBytes,
                                dataBytes,
                                data.count,
                                resultBytes,
                                data.count,
                                &numBytesDecrypted)
                    }
                }
            }
            if err != CCCryptorStatus(kCCSuccess) {
                NSLog("Decryption failed! Error: \(err.description)")
            }
            
            result.count = numBytesDecrypted
            return String(data: result, encoding: .utf8) ?? "???"
        }
        return "???"
    }
}

extension Data {
    
    init?(fromHexEncodedString string: String) {
        
        // Convert 0 ... 9, a ... f, A ...F to their decimal value,
        // return nil for all other input characters
        func decodeNibble(u: UInt16) -> UInt8? {
            switch(u) {
            case 0x30 ... 0x39:
                return UInt8(u - 0x30)
            case 0x41 ... 0x46:
                return UInt8(u - 0x41 + 10)
            case 0x61 ... 0x66:
                return UInt8(u - 0x61 + 10)
            default:
                return nil
            }
        }
        
        self.init(capacity: string.utf16.count/2)
        var even = true
        var byte: UInt8 = 0
        for c in string.utf16 {
            guard let val = decodeNibble(u: c) else { return nil }
            if even {
                byte = val << 4
            } else {
                byte += val
                self.append(byte)
            }
            even = !even
        }
        guard even else { return nil }
    }
    
    
    
    
    
}

