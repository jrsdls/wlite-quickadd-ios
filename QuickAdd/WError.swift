//
//  WError.swift
//  QuickAdd
//
//  Created by Pinuno Fuentes on 7/22/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation

enum WErrorAuthentication : String {
    case Missing = "missing"
    case Undefined = ""
}

enum WErrorMessage : String {
    case UnknownServerError = "An unknown server error occurred"
    case Undefined = ""
}

enum WErrorTranslationKey : String {
    case APIErrorUnknown = "api_error_unknown"
    case Undefined = ""
}

enum WErrorType : String {
    case ServerError = "server_error"
    case Undefined = ""
}

class WError {
    var authentication = [WErrorAuthentication]()
    var translationKey = WErrorTranslationKey.Undefined
    var message = WErrorMessage.Undefined
    var type = WErrorType.Undefined
    
    var isAuthenticationError : Bool {
        get {
            return (authentication.first == WErrorAuthentication.Missing
                && translationKey == WErrorTranslationKey.APIErrorUnknown
                && message == WErrorMessage.UnknownServerError
                && type == WErrorType.ServerError )
        }
    }
    
    init(authentication:[WErrorAuthentication], translationKey:WErrorTranslationKey, message:WErrorMessage, type:WErrorType){
        self.authentication = authentication
        self.translationKey = translationKey
        self.message = message
        self.type = type
    }
    
    convenience init(rawError:[String:AnyObject]){
        let rawauthentication = rawError["authentication"] as! NSArray
        var authentication = [WErrorAuthentication]()
        for auth in rawauthentication {
            authentication.append((auth as! String == "missing" ? .Missing : .Undefined))
        }
            
        let rawtranslationKey = rawError["translation_key"] as! NSString
        let translationKey = (rawtranslationKey as! String == "api_error_unknown" ? WErrorTranslationKey.APIErrorUnknown : WErrorTranslationKey.Undefined)
        
        let rawmessage = rawError["message"] as! NSString
        let message = (rawmessage as! String == "An unknown server error occurred" ? WErrorMessage.UnknownServerError : WErrorMessage.Undefined)
        
        let rawtype = rawError["type"] as! NSString
        let type = (rawtype as! String == "server_error" ? WErrorType.ServerError : WErrorType.Undefined)
        
        self.init(authentication:authentication, translationKey:translationKey, message:message, type:type)
    }
}
