//
//  Utils.swift
//  Portail G9
//
//  Created by WBA_ORCA on 29/01/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
class Utils: NSObject {
    
    public static let NUMBERS_ONLY = "1234567890." ;
    public static let INTEGER_NUMBER_ONLY = "1234567890"
    public static let EMAIL_CHARACTER_ONLY = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@._-0123456789"
    public static let ALPHABET_ONLY = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 'éèêàùçÀÇÉÈÙ"
    
    public static let SHARED_PREFERENCE_USER = "SHARED_PREFERENCE_USER"
    public static let SHARED_PREFERENCE_USER_PROFIL = "SHARED_PREFERENCE_USER_PROFIL"
    public static let SHARED_PREFERENCE_USER_CONNECTED = "SHARED_PREFERENCE_USER_CONNECTED"
    public static let SHARED_PREFERENCE_USER_TOKEN = "SHARED_PREFERENCE_USER_TOKEN"
    public static let SHARED_PREFERENCE_USER_NOM = "SHARED_PREFERENCE_USER_NOM"
    public static let SHARED_PREFERENCE_USER_PRENOM = "SHARED_PREFERENCE_USER_PRENOM"
    public static let SHARED_PREFERENCE_USER_LOGIN = "SHARED_PREFERENCE_USER_LOGIN"
    public static let SHARED_PREFERENCE_USER_PASSWORD = "SHARED_PREFERENCE_USER_PASSWORD"
    
    public static let SHARED_PREFERENCE_DATA_PERIMETRE = "SHARED_PREFERENCE_DATA_PERIMETRE"
    public static let SHARED_PREFERENCE_LANGUAGES = "SHARED_PREFERENCE_LANGUAGES"
    
    public static let SHARED_PREFERENCE_PERIMETRE_LANGUE = "SHARED_PREFERENCE_PERIMETRE_LANGUE"
    public static let SHARED_PREFERENCE_PERIMETRE_PAYS = "SHARED_PREFERENCE_PERIMETRE_PAYS"
    public static let SHARED_PREFERENCE_PERIMETRE_ZONE = "SHARED_PREFERENCE_PERIMETRE_ZONE"
    public static let SHARED_PREFERENCE_PERIMETRE_GROUPE = "SHARED_PREFERENCE_PERIMETRE_GROUPE"
    public static let SHARED_PREFERENCE_PERIMETRE_AFFAIRE = "SHARED_PREFERENCE_PERIMETRE_AFFAIRE"
    
    public static let NUMBER_DEMANDE_BY_PAGE = 100 ;
    
    public static let SHARED_PREFERENCE_LAST_DOCUMENT = "SHARED_PREFERENCE_LAST_DOCUMENT"
    
    // *****************************************
    // *****************************************
    // ****** disconnectUser
    // *****************************************
    // *****************************************
    public static func disconnectUser(goBackAnimated : Bool)
    {
        let preferences = UserDefaults.standard
        
        preferences.set(false, forKey: Utils.SHARED_PREFERENCE_USER_CONNECTED)
        
        preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_USER)
        preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_USER_TOKEN)
        preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_USER_PROFIL)
        preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_USER_NOM)
        preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_USER_PRENOM)
        preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_USER_LOGIN)
        preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_USER_PASSWORD)
        
        
        preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_DATA_PERIMETRE)
        preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_LANGUAGES)
        
        preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE)
         preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_PAYS)
         preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_ZONE)
         preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_GROUPE)
         preferences.setValue(nil, forKey: Utils.SHARED_PREFERENCE_PERIMETRE_AFFAIRE)
        //  Save to disk
        preferences.synchronize()
        
        print("disconnectUserAction")
        DispatchQueue.main.async {
            let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController ;
            navigationController.popToRootViewController(animated: goBackAnimated);
        }
    }
    
    
    // *****************************************
    // *****************************************
    // ****** commaEvery3Digit
    // *****************************************
    // *****************************************
    public static func commaEvery3Digit(numberToFormat: Double) -> String
    {
        let largeNumber = numberToFormat
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.groupingSeparator = " "
        numberFormatter.locale = Locale(identifier: "fr_FR")
        
        var numberAsString = numberFormatter.string(from: NSNumber(value: largeNumber))!;
        numberAsString = numberAsString.replacingOccurrences(of: ",", with: ".");
        return numberAsString;
    }
    
    
    // *****************************************
    // *****************************************
    // ****** chiffrerPassword
    // *****************************************
    // *****************************************
    public static func chiffrerPassword (password : String) -> String
    {
        var passwordChiffre = "";
        
        let password_1 = Utils.randomStringWithLength(len: password.count)
        let password_3 = Utils.randomStringWithLength(len: (password.count - 3))
        
        passwordChiffre = password_1 + password + password_3
        
        if(password.count > 9)
        {
            passwordChiffre = passwordChiffre + String(password.count)
        }
        else
        {
            passwordChiffre = passwordChiffre + "0" + String(password.count)
        }
        
        passwordChiffre = Data(passwordChiffre.utf8).base64EncodedString()
        
        return passwordChiffre;
    }
    
    // *****************************************
    // *****************************************
    // ****** randomStringWithLength
    // *****************************************
    // *****************************************
    public static func randomStringWithLength (len : Int) -> String
    {
        
        if(len < 1)
        {
            return "";
        }
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in  (0 ..< len)
        {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return String(randomString);
    }
    
    
    // *****************************************
    // *****************************************
    // ****** getDocumentsDirectory
    // *****************************************
    // *****************************************
    public static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    // *****************************************
    // *****************************************
    // ****** readFile
    // *****************************************
    // *****************************************
    public static func readFile(path: String) -> Data {
        
        do {
            
            let fileManager = FileManager()
            if fileManager.fileExists(atPath: path){
                //print("fileExists " + path)
                
            }
            
            let contents:String = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let data = contents.data(using: .utf8)
            
            return data!;
        }
        catch let error as NSError {
            print("Failed reading from URL: \(path), Error: " + error.localizedDescription)
            return Data()
        }
        
    }
    // *****************************************
    // *****************************************
    // ****** deleteFile
    // *****************************************
    // *****************************************
    public static func deleteFile(fileName: String)  {
        
        let filePath = "documents_img/" + fileName;
        
        let path = Utils.getDocumentsDirectory();
        let fileURLasString = path.appendingPathComponent(filePath)
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: fileURLasString.path){
            try! fileManager.removeItem(atPath: fileURLasString.path)
            
            print("document supprimé")
        }else{
            print("pas de document à supprimer")
        }
        
        
    }
    
    // *****************************************
    // *****************************************
    // ****** saveImageToDocuments
    // *****************************************
    // *****************************************
    public static func saveImageToDocuments(imageToSave : UIImage) -> String
    {
        // *** load image  *** //
        let imageData = imageToSave.jpegData(compressionQuality: 0.8)
        
        let fileName = "documents_img/" + Utils.randomString(length:15);
        
        let path = Utils.getDocumentsDirectory();
        let fileURL = path.appendingPathComponent(fileName).appendingPathExtension("jpg")
        
        Utils.createDocumentsDirectory();
        
        do{
            // *** Write video file data to path *** //
            try imageData?.write(to: fileURL, options: .atomic)
            
            return fileURL.lastPathComponent;
        } catch {
            print(error)
            return "";
        }
    }
    // *****************************************
    // *****************************************
    // ****** createDocumentsDirectory
    // *****************************************
    // *****************************************
    public static func createDocumentsDirectory()
    {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent("documents_img")
        
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
        }
    }
    // *****************************************
    // *****************************************
    // ****** randomString
    // *****************************************
    // *****************************************
    public static func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}


// ++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++
extension UIColor {
    
    // *********************
    // *********************
    // *********************
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
    
    // *********************
    // *********************
    // *********************
    // MARK: - Initialization
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.characters.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    // MARK: - Computed Properties
    
    var toHex: String? {
        return toHex()
    }
    
    // MARK: - From UIColor to String
    
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}


// ++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++

