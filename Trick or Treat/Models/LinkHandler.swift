//
//  LinkHandler.swift
//  Trick or Treat
//
//  Created by Joshua Hoffman on 10/9/20.
//

import Foundation

struct Candy {
    var id: String
}

extension URL {
  var isDeeplink: Bool {
    return scheme == "trickortreat" // matches my-url-scheme://<rest-of-the-url>
  }

var receivedCandy: Candy? {
    guard isDeeplink else { return nil }

    if pathComponents.count > 1 {
        let receivedCandy = Candy(id: pathComponents[1])
        print(receivedCandy)
        return receivedCandy
    }

    return nil
    
  }
}
