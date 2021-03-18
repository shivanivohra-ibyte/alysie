//
//  UIColor.swift
//  VisitorManagementSystem
//
//  Created by MacBook 1 on 26/10/19.
//  Copyright © 2019 CodeAegis. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  
  public convenience init(hex: String) {
    
    let r, g, b, a: CGFloat
    if hex.hasPrefix("#") {
      let start = hex.index(hex.startIndex, offsetBy: 1)
      let hexColor = String(hex[start...])
      
      if hexColor.count == 8 {
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
          r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
          g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
          b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
          a = CGFloat(hexNumber & 0x000000ff) / 255
          
          self.init(red: r, green: g, blue: b, alpha: a)
        } else {
          self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
      } else {
        self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      }
    } else {
      self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
  }
}
