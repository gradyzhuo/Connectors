//
//  GZHTTPConnection+FlingyExtension.swift
//  Flingy
//
//  Created by Grady Zhuo on 2014/9/15.
//  Copyright (c) 2014年 Grady Zhuo. All rights reserved.
//

import Foundation

extension GZHTTPConnection {
    

    func connect(#api:String, connectorData:GZHTTPConnectionData, completionHandler:__GZHTTPConnectionCallBackDefaultCompleteHandler, failHandler:__GZHTTPConnectionCallBackDefaultFailHandler)-> NSURLSessionTask?{
        
        var taskObject = self.defaultConnectionByDefaultHostURL(api, connectorData: connectorData, completionHandler: { (obj, response, error) -> Void in
            
            GZDebugLog("(Checking) API:\(response.URL), senderString:\(connectorData.senderString())")
            
            var httpResponse = response as NSHTTPURLResponse
            
            
            if httpResponse.statusCode != 200 && obj != nil {
                
                var errorObj = obj as NSDictionary!
                
                var userInfo = [NSRecoveryAttempterErrorKey:obj, NSLocalizedFailureReasonErrorKey:errorObj["message"]]
                
                var connectionError =  NSError(domain: "Flingy API:", code: httpResponse.statusCode, userInfo: userInfo)
                
                failHandler(response: response, error: connectionError)
                
                if httpResponse.statusCode == 401 {
                    //                    GZDebugLog("httpResponse 401   obj:\(error.localizedFailureReason)")
                    
                    GZDebugLog("(401 error)url:\(httpResponse.URL) server message:\(errorObj)")
                    if GZUser.currentUser.logined {
                        GZUser.currentUser.logout()
                    }
                    
                }
            }else{
                completionHandler(obj: obj, response: response, error: error)
            }
            
            }, failHandler: { (response:NSURLResponse!, error:NSError!) -> Void in
                
                GZDebugLog("(API Error) API:\(response.URL), senderData:\(connectorData.senderString()) ,error:\(error)")
                
                failHandler(response: response, error: error)
        
        })
        
        if let task = taskObject {
            task.resume()
        }

        
        return taskObject
        
    }
    
    
}