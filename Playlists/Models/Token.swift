//
//  Token.swift
//  Playlists
//
//  Created by Kaleb Page on 12/29/20.
//

import Foundation
import SwiftJWT



struct myClaims: Claims {
    let iss: String
    let iat: TimeInterval
    let exp: TimeInterval
}
    
  
    let currentTime = NSDate().timeIntervalSince1970

    let header = Header(kid: "5H3UJXKWMD")

    let claims = myClaims(iss: "M65GZQ2PZA", iat: currentTime, exp: currentTime+900)

    var myJWT = JWT(header: header, claims: claims)

    let privateKeyPath = Bundle.main.url(forResource: "AuthKey_5H3UJXKWMD", withExtension: "p8")!

    let privateKey: Data = try! Data(contentsOf: privateKeyPath, options: .alwaysMapped)
                
    //let jwtSigner = JWTSigner.es256(privateKey: privateKey)

    let signedJWT = try! myJWT.sign(using: JWTSigner.es256(privateKey: privateKey))
    

    
    
    

    
    
    
    

    



    



