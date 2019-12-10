//
//  Version.swift
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
class Version: NSObject {
    
    //"com.orcaformation.ios.r7.Portail-G9"
    //"com.orcaformation.ios.pp.Portail-G9"
    //"com.orcaformation.ios.prod.Portail-G9"

    public static let VERSION =  "R7" //"PP"
    
    public static let URL_PORTAIL_G9 = "https://driverg9-recette.orcaformation.com" //"https://driverg9.dcs2.renault.com" //"https://driverg9-pp.orcaformation.com"
    public static let URL_WS_PORTAIL_G9 = "https://driverg9-recette.orcaformation.com/api" //"https://driverg9-pp.orcaformation.com/api" //"https://driverg9.dcs2.renault.com/api" // //
    
    public static let URL_PREFIX_IMAGES_PORTAIL_G9 =  "https://driverg9-recette.orcaformation.com/assets/icons/" // "https://driverg9-pp.orcaformation.com/assets/icons/"
    
    public static let URL_INSTALL_PORTAIL_G9 = "https://app.orcaformation.com/Renault/portailG9/r7/ios/portail_g9_r7.plist" //"https://app.orcaformation.com/Renault/portailG9/pp/ios/portail_g9_pp.plist"
    
    public static let subscriptionTopic =  "global_R7" // "global_PP" //"global_PROD"
    
    
    public static let KEY_FCM = "AIzaSyAkGHPHvqJZAzpmBw-ge4b8jH1DyWsPVc4"
    public static let KEY_FCM_LONG = "AAAAGkSdWZM:APA91bEX8CyMshxjrjIP8ENqyt4G4qFkLq0LSfs06pdtxeSZ9UkdXHfFg7AHGTpcRxU4_udA2StVywT3ubjvSnKpdaH3KUCVlcMYoTtLdKkf8RehTkeHQHGu9f0jv9UxcyS0_iGSLGXX"
    
    
}
