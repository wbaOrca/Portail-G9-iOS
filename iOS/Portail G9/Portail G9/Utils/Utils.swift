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
    public static let SHARED_PREFERENCE_PERIMETRE_DR = "SHARED_PREFERENCE_PERIMETRE_DR"
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
    
    
    
    public convenience init?(name: String) {
        let allColors = [
            "aliceblue": "#F0F8FFFF",
            "antiquewhite": "#FAEBD7FF",
            "aqua": "#00FFFFFF",
            "aquamarine": "#7FFFD4FF",
            "azure": "#F0FFFFFF",
            "beige": "#F5F5DCFF",
            "bisque": "#FFE4C4FF",
            "black": "#000000FF",
            "blanchedalmond": "#FFEBCDFF",
            "blue": "#0000FFFF",
            "blueviolet": "#8A2BE2FF",
            "brown": "#A52A2AFF",
            "burlywood": "#DEB887FF",
            "cadetblue": "#5F9EA0FF",
            "chartreuse": "#7FFF00FF",
            "chocolate": "#D2691EFF",
            "coral": "#FF7F50FF",
            "cornflowerblue": "#6495EDFF",
            "cornsilk": "#FFF8DCFF",
            "crimson": "#DC143CFF",
            "cyan": "#00FFFFFF",
            "darkblue": "#00008BFF",
            "darkcyan": "#008B8BFF",
            "darkgoldenrod": "#B8860BFF",
            "darkgray": "#A9A9A9FF",
            "darkgrey": "#A9A9A9FF",
            "darkgreen": "#006400FF",
            "darkkhaki": "#BDB76BFF",
            "darkmagenta": "#8B008BFF",
            "darkolivegreen": "#556B2FFF",
            "darkorange": "#FF8C00FF",
            "darkorchid": "#9932CCFF",
            "darkred": "#8B0000FF",
            "darksalmon": "#E9967AFF",
            "darkseagreen": "#8FBC8FFF",
            "darkslateblue": "#483D8BFF",
            "darkslategray": "#2F4F4FFF",
            "darkslategrey": "#2F4F4FFF",
            "darkturquoise": "#00CED1FF",
            "darkviolet": "#9400D3FF",
            "deeppink": "#FF1493FF",
            "deepskyblue": "#00BFFFFF",
            "dimgray": "#696969FF",
            "dimgrey": "#696969FF",
            "dodgerblue": "#1E90FFFF",
            "firebrick": "#B22222FF",
            "floralwhite": "#FFFAF0FF",
            "forestgreen": "#228B22FF",
            "fuchsia": "#FF00FFFF",
            "gainsboro": "#DCDCDCFF",
            "ghostwhite": "#F8F8FFFF",
            "gold": "#FFD700FF",
            "goldenrod": "#DAA520FF",
            "gray": "#808080FF",
            "grey": "#808080FF",
            "green": "#008000FF",
            "greenyellow": "#ADFF2FFF",
            "honeydew": "#F0FFF0FF",
            "hotpink": "#FF69B4FF",
            "indianred": "#CD5C5CFF",
            "indigo": "#4B0082FF",
            "ivory": "#FFFFF0FF",
            "khaki": "#F0E68CFF",
            "lavender": "#E6E6FAFF",
            "lavenderblush": "#FFF0F5FF",
            "lawngreen": "#7CFC00FF",
            "lemonchiffon": "#FFFACDFF",
            "lightblue": "#ADD8E6FF",
            "lightcoral": "#F08080FF",
            "lightcyan": "#E0FFFFFF",
            "lightgoldenrodyellow": "#FAFAD2FF",
            "lightgray": "#D3D3D3FF",
            "lightgrey": "#D3D3D3FF",
            "lightgreen": "#90EE90FF",
            "lightpink": "#FFB6C1FF",
            "lightsalmon": "#FFA07AFF",
            "lightseagreen": "#20B2AAFF",
            "lightskyblue": "#87CEFAFF",
            "lightslategray": "#778899FF",
            "lightslategrey": "#778899FF",
            "lightsteelblue": "#B0C4DEFF",
            "lightyellow": "#FFFFE0FF",
            "lime": "#00FF00FF",
            "limegreen": "#32CD32FF",
            "linen": "#FAF0E6FF",
            "magenta": "#FF00FFFF",
            "maroon": "#800000FF",
            "mediumaquamarine": "#66CDAAFF",
            "mediumblue": "#0000CDFF",
            "mediumorchid": "#BA55D3FF",
            "mediumpurple": "#9370D8FF",
            "mediumseagreen": "#3CB371FF",
            "mediumslateblue": "#7B68EEFF",
            "mediumspringgreen": "#00FA9AFF",
            "mediumturquoise": "#48D1CCFF",
            "mediumvioletred": "#C71585FF",
            "midnightblue": "#191970FF",
            "mintcream": "#F5FFFAFF",
            "mistyrose": "#FFE4E1FF",
            "moccasin": "#FFE4B5FF",
            "navajowhite": "#FFDEADFF",
            "navy": "#000080FF",
            "oldlace": "#FDF5E6FF",
            "olive": "#808000FF",
            "olivedrab": "#6B8E23FF",
            "orange": "#FFA500FF",
            "orangered": "#FF4500FF",
            "orchid": "#DA70D6FF",
            "palegoldenrod": "#EEE8AAFF",
            "palegreen": "#98FB98FF",
            "paleturquoise": "#AFEEEEFF",
            "palevioletred": "#D87093FF",
            "papayawhip": "#FFEFD5FF",
            "peachpuff": "#FFDAB9FF",
            "peru": "#CD853FFF",
            "pink": "#FFC0CBFF",
            "plum": "#DDA0DDFF",
            "powderblue": "#B0E0E6FF",
            "purple": "#800080FF",
            "rebeccapurple": "#663399FF",
            "red": "#FF0000FF",
            "rosybrown": "#BC8F8FFF",
            "royalblue": "#4169E1FF",
            "saddlebrown": "#8B4513FF",
            "salmon": "#FA8072FF",
            "sandybrown": "#F4A460FF",
            "seagreen": "#2E8B57FF",
            "seashell": "#FFF5EEFF",
            "sienna": "#A0522DFF",
            "silver": "#C0C0C0FF",
            "skyblue": "#87CEEBFF",
            "slateblue": "#6A5ACDFF",
            "slategray": "#708090FF",
            "slategrey": "#708090FF",
            "snow": "#FFFAFAFF",
            "springgreen": "#00FF7FFF",
            "steelblue": "#4682B4FF",
            "tan": "#D2B48CFF",
            "teal": "#008080FF",
            "thistle": "#D8BFD8FF",
            "tomato": "#FF6347FF",
            "turquoise": "#40E0D0FF",
            "violet": "#EE82EEFF",
            "wheat": "#F5DEB3FF",
            "white": "#FFFFFFFF",
            "whitesmoke": "#F5F5F5FF",
            "yellow": "#FFFF00FF",
            "yellowgreen": "#9ACD32FF"
        ]
        
        let cleanedName = name.replacingOccurrences(of: " ", with: "").lowercased()
        
        if let hexString = allColors[cleanedName] {
            self.init(hexString: hexString)
        } else {
            self.init(hexString: "#000000FF")
        }
    }
}


// ++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++
struct CustomLanguage {
    
    func createBundlePath () -> Bundle {
        
        //recover the language chosen by the user (in my case, from UserDefaults)
        var lang = "en-GB"
        let preferences = UserDefaults.standard
        let langueData_ = preferences.data(forKey: Utils.SHARED_PREFERENCE_PERIMETRE_LANGUE);
        if(langueData_ != nil){
            if let langue_ = NSKeyedUnarchiver.unarchiveObject(with: langueData_!)  {
                
                let langue = langue_ as! Langue
                lang = langue.languageCode;
                
            }
        }
        lang = lang.replacingOccurrences(of: "_", with: "-")
        let selectedLanguage = lang
        let path = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj")
        return Bundle(path: path!)!
    }
}
