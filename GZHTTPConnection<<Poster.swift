//
//  GZHTTPConnection<<Upload.swift
//  Flingy
//
//  Created by Grady Zhuo on 2014/10/16.
//  Copyright (c) 2014年 Grady Zhuo. All rights reserved.
//

import Foundation

extension GZHTTPConnection {
    
    func uploadImage(connectorData:GZPostUploadConnectorData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject, failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        self.connect(api: "image", connectorData: connectorData, completionHandler: { (obj, response, error) -> Void in
            completionHandler(obj: obj, response: response, error: nil)
        }) { (response, error) -> Void in
            failHandler(obj: nil, response: response, error: error)
        }
        
    }
    
    
    func attatchInfoToPost(connectorData:GZPostFlingTwoImageConnectorData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject, failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        self.connect(api: "fling/post", connectorData: connectorData, completionHandler: { (obj, response, error) -> Void in
            completionHandler(obj: obj, response: response, error: nil)
            }) { (response, error) -> Void in
                failHandler(obj: nil, response: response, error: error)
        }
        
    }
    
    
}