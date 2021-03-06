//
//  PowerMode.swift
//  PowerMode
//
//  Created by YiSeungyoun on 2017. 12. 9..
//  Copyright © 2017년 Seungyounyi. All rights reserved.
//

import UIKit

public class PowerMode: NSObject {
    public class var sparkColors: [UIColor] {
        get {
            if let hexArray = UserDefaults.standard.stringArray(forKey: "PowerModeColors") {
                let colors = hexArray.map { UIColor(hexString: $0) }
                return colors
            } else {
                return [UIColor.black]
            }
        }

        set(newValue) {
            print(newValue)
            let hexArray = newValue.map { $0.toHexString() }
            UserDefaults.standard.set(hexArray, forKey: "PowerModeColors")
        }
    }
    
    public class var isSparkActionEnabled: Bool {
        get {
            if let value = UserDefaults.standard.object(forKey: "PowerModeIsSparkActionEnabled") as? Bool {
                return value
            } else {
                return true
            }
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "PowerModeIsSparkActionEnabled")
        }
    }
    
    public class var isShakeActionEnabled: Bool {
        get {
            if let value = UserDefaults.standard.object(forKey: "PowerModeIsShakeActionEnabled") as? Bool {
                return value
            } else {
                return true
            }
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "PowerModeIsShakeActionEnabled")
        }
    }
    
    public class var shakeTranslationX: CGFloat {
        get {
            if let value = UserDefaults.standard.object(forKey: "PowerModeShakeTranslationX") as? CGFloat {
                return value
            } else {
                return 0
            }
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "PowerModeShakeTranslationX")
        }
    }
    
    public class var shakeTranslationY: CGFloat {
        get {
            if let value = UserDefaults.standard.object(forKey: "PowerModeShakeTranslationY") as? CGFloat {
                return value
            } else {
                return 2
            }
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "PowerModeShakeTranslationY")
        }
    }



    
    class func animate(in textInput: UITextInput, with range: NSRange) -> CGRect? {
        let beginning = textInput.beginningOfDocument
        let start = textInput.position(from: beginning, offset: range.location)
        
        guard let _start = start else { return nil }
        let end = textInput.position(from: _start, offset: range.length)
        
        guard let _end = end else { return nil }
        let textRange = textInput.textRange(from: _start, to: _end)
        
        guard let _textRange = textRange else { return nil }
        let rect = textInput.firstRect(for: _textRange)
        
        return rect
    }
}

extension UIColor {
    convenience init(hexString:String) {
        let hexString          = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner            = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}

