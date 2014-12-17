//
//  GZHTTPConnection<<SocialMedia.swift
//  Flingy
//
//  Created by Grady Zhuo on 2014/11/3.
//  Copyright (c) 2014年 Grady Zhuo. All rights reserved.
//

import Foundation


extension GZHTTPConnection {
    
    func getSocialToken(connectorData:GZGetSocialTokenConnectionData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject, failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        self.connect(api: "social/\(connectorData.type.keyString)/token", connectorData: connectorData, completionHandler: { (obj:AnyObject!, response, error) -> Void in
            
            
            var dict = JSON(obj)
            
            var token = dict[[connectorData.type.resultKey]]
            
            var resultObject:AnyObject? = token.object
            
            if resultObject is Bool {
                resultObject = nil
            }
            
            completionHandler(obj: resultObject, response: response, error: nil)
            
            }) { (response, error) -> Void in
                failHandler(obj: nil, response: response, error: error)
        }
        
    }
    
    func setSocialToken(connectorData:GZSetSocialTokenConnectionData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject, failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        self.connect(api: "social/\(connectorData.type.keyString)/token", connectorData: connectorData, completionHandler: { (obj:AnyObject!, response, error) -> Void in
            
            var dict = JSON(obj)
            
            var token = dict[[connectorData.type.resultKey]]
            
            var resultObject:AnyObject? = token.object
            
            if resultObject is Bool {
                resultObject = nil
            }
            
            completionHandler(obj: resultObject, response: response, error: nil)
            
            }) { (response, error) -> Void in
                println("set toke error:\(error)")
                println("connectorData.senderString():\(connectorData.senderString())")
                failHandler(obj: nil, response: response, error: error)
        }
        
    }
    
    
    func postToSocialMedia(connectorData:GZPostSocialConnectionData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject, failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        self.connect(api: "social/\(connectorData.type.keyString)/post", connectorData: connectorData, completionHandler: { (obj:AnyObject!, response, error) -> Void in
            
            completionHandler(obj: obj, response: response, error: nil)
            
            }) { (response, error) -> Void in
                println("connectorData.senderString():\(connectorData.senderString())")
                failHandler(obj: nil, response: response, error: error)
        }
        
    }
    
    func shareToSocialMedia(connectorData:GYShareFlingConnectionData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackBoolean, failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        
        self.connect(api: "social/\(connectorData.type.keyString)/share/fling", connectorData: connectorData, completionHandler: { (obj:AnyObject!, response, error) -> Void in
            
            var json = JSON(obj)
            
            completionHandler(success: json["success"].boolValue, response: response, error: error)
            
            }) { (response, error) -> Void in
                
                failHandler(obj: nil, response: response, error: error)
        }
        
    }
    
    
    
    
}