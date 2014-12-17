//
//  GZHTTPConnection<<PushNotification.swift
//  Flingy
//
//  Created by skylying on 2014/11/13.
//  Copyright (c) 2014年 Grady Zhuo. All rights reserved.
//

import Foundation


extension GZHTTPConnection {
    
    func setDeviceToken(connectorData:GZDeviceTokenConnectionData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject, failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        self.connect(api: "member/ios_device_token", connectorData: connectorData, completionHandler: { (obj, response, error) -> Void in
            completionHandler(obj: obj, response: response, error: nil)
            }) { (response, error) -> Void in
                failHandler(obj: nil, response: response, error: error)
        }
        
    }
    
    func operateBadgeNumber(connectorData:GZBadgeNumberOperatingConnectionData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject, failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        self.connect(api: "mail/push_notification/badge", connectorData: connectorData, completionHandler: { (obj, response, error) -> Void in
            
            completionHandler(obj: obj, response: response, error: nil)
            
            }) { (response, error) -> Void in
                failHandler(obj: nil, response: response, error: error)
        }
        
    }
    
    
    
    
}
