//
//  TCCrypto.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/20/20.
//

import Foundation
import CommonCrypto

/**
 * Example MD5 Has using CommonCrypto
 * CC_MD5 API exposed from CommonCrypto-60118.50.1:
 * https://opensource.apple.com/source/CommonCrypto/CommonCrypto-60118.50.1/include/CommonDigest.h.auto.html
 **/
public func md5Hash (str: String) -> String? {
    if let strData = str.data(using: String.Encoding.utf8) {
        /// #define CC_MD5_DIGEST_LENGTH    16          /* digest length in bytes */
        /// Creates an array of unsigned 8 bit integers that contains 16 zeros
        var digest = [UInt8](repeating: 0, count:Int(CC_MD5_DIGEST_LENGTH))

        /// CC_MD5 performs digest calculation and places the result in the caller-supplied buffer for digest (md)
        /// Calls the given closure with a pointer to the underlying unsafe bytes of the strData’s contiguous storage.
        strData.withUnsafeBytes {
            // CommonCrypto
            // extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md) --|
            // OpenSSL                                                                          |
            // unsigned char *MD5(const unsigned char *d, size_t n, unsigned char *md)        <-|
            CC_MD5($0.baseAddress, UInt32(strData.count), &digest)
        }

        var md5String = ""
        /// Unpack each byte in the digest array and add them to the md5String
        for byte in digest {
            md5String += String(format:"%02x", UInt8(byte))
        }

        return md5String.uppercased()
    }

    return nil
}


public func sha_256(str: String) -> String? {

    if let strData = str.data(using: String.Encoding.utf8) {
        /// #define CC_SHA256_DIGEST_LENGTH     32
        /// Creates an array of unsigned 8 bit integers that contains 32 zeros
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))

        /// CC_SHA256 performs digest calculation and places the result in the caller-supplied buffer for digest (md)
        /// Takes the strData referenced value (const unsigned char *d) and hashes it into a reference to the digest parameter.
        strData.withUnsafeBytes {
            // CommonCrypto
            // extern unsigned char *CC_SHA256(const void *data, CC_LONG len, unsigned char *md)  -|
            // OpenSSL                                                                             |
            // unsigned char *SHA256(const unsigned char *d, size_t n, unsigned char *md)        <-|
            CC_SHA256($0.baseAddress, UInt32(strData.count), &digest)
        }

        var sha256String = ""
        /// Unpack each byte in the digest array and add them to the sha256String
        for byte in digest {
            sha256String += String(format:"%02x", UInt8(byte))
        }

        return sha256String.uppercased()
    }
    return nil
}
