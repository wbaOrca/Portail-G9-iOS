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
    
}
