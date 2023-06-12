//
//  File.swift
//  
//
//  Created by Kiefer Wiessler on 12/06/2023.
//

import Foundation

func colorSetTemplate(hexString: String) -> String {
    return """
    {
      "colors" : [
        {
          "color" : {
            "color-space" : "srgb",
            "components" : {
              "alpha" : "1.000",
              "blue" : "0x\(Array(hexString)[1])\(Array(hexString)[2])",
              "green" : "0x\(Array(hexString)[3])\(Array(hexString)[4])",
              "red" : "0x\(Array(hexString)[5])\(Array(hexString)[6])"
            }
          },
          "idiom" : "universal"
        }
      ],
      "info" : {
        "author" : "xcode",
        "version" : 1
      }
    }
    """
}
