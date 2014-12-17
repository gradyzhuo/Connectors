//
//  GZHTTPConnection<<GoogleImageSearch.swift
//  Flingy
//
//  Created by Grady Zhuo on 2014/10/21.
//  Copyright (c) 2014年 Grady Zhuo. All rights reserved.
//

import Foundation

extension GZHTTPConnection {
    
    
    func getGoogleSearchedImage(connectorData:GZGoogleImageSearchConnectorData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackArray,failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        var dataTask = self.defaultConnection(url: GOOGLE_CUSTOM_SEARCH_URL!, connectorData: connectorData, completionHandler: { (obj, response, error) -> Void in
            
            
            var resultDict = obj as [String:AnyObject]
            
            var itemsObject:AnyObject! = resultDict["items"] as AnyObject!
            
            var items:[NSURL] = []
            
            if itemsObject != nil {
                
                var itemsArray = itemsObject as [[String:AnyObject]]
                
                items = itemsArray.map {
                    
                    var value: AnyObject! = $0["link"] as AnyObject!
                    
                    if value != nil {
                        return NSURL(string: "\(value)")!
                    }
                    return NSURL(string: "")!
                }
                
                
            }else{
                GZDebugLog("obj:\(obj)")
            }
            
            completionHandler(array: items, response: response, error: error)
//            completionHandler(obj: obj, response: response, error: error)
            
        }) { (response, error) -> Void in
            GZDebugLog("searched Image Error:\(error)")
            
            failHandler(obj: nil, response: response, error: error)
            
        }
        
        if let dataTask = dataTask {
            dataTask.resume()
        }
        
    }
    
    
    
}