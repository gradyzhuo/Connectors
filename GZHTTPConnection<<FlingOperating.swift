//
//  FlingOperatingConnector.swift
//  Flingy
//
//  Created by Grady Zhuo on 2014/9/25.
//  Copyright (c) 2014年 Grady Zhuo. All rights reserved.
//

import Foundation

extension GZHTTPConnection {
    
    func voteFling(connectorData:GZFlingVoteConnectorData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject,failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        self.connect(api: "fling/vote", connectorData: connectorData, completionHandler: { (obj, response, error) -> Void in
            
            var dict = obj as AnyTypeDictionary
            
            completionHandler(obj: GZFling(dataDict: dict), response: response, error: nil)
            
            }) { (response, error) -> Void in
                
                failHandler(obj: nil, response: response, error: error)
                
        }
        
    }
    
    func deleteFling(connectorData:GZDeleteFlingConnnectionData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackBoolean,failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        var defaultHash = connectorData.flingHash ?? "-1"
        
        self.connect(api: "fling/member/\(defaultHash)", connectorData: connectorData, completionHandler: { (obj, response, error) -> Void in
            
            var json:JSON = JSON(obj)
            var success = json["success"].boolValue
            
            completionHandler(success: success, response:response, error:error)
            
            }) { (response, error) -> Void in
                
                failHandler(obj: nil, response: response, error: error)
                
        }
        
    }
    
}