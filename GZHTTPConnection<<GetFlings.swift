//
//  GetFlingsConnector.swift
//  Flingy
//
//  Created by Grady Zhuo on 2014/9/25.
//  Copyright (c) 2014年 Grady Zhuo. All rights reserved.
//

import Foundation

extension GZHTTPConnection {
    
    func convertToFlingsArray(obj: AnyObject!,progressHandler:((fling:GZFling)->Void)?)->[GZFling]{
        
        var dict = obj as [NSObject:AnyObject]
        
        var flingObject: AnyObject? = dict["flings"]
        
        var flings:[GZFling] = []
        
        //為了 "0" : {fling}  做處理 --- start
        if flingObject is [NSObject:AnyObject]{
            
            var dicts:[AnyObject] = [AnyObject]()
            
            var key:String?
            var value:AnyObject?
            
            if let flingDictDicts:[NSObject:AnyObject] = flingObject as? [NSObject:AnyObject]{
                
                for (key, value) in flingDictDicts{
                    
                    if value is AnyTypeDictionary {
                        dicts += [value]
                    }
                    

                }
                
            }
            
            flingObject = dicts
        }
        //為了 "0" : {fling}  做處理 --- end
        
        if flingObject is [AnyObject]{
            
            if let flingDicts:[AnyTypeDictionary] = flingObject as? [AnyTypeDictionary] {
                
                flings = flingDicts.map{
                    
                    var fling = GZFling.flingObjectFromDataDict($0)
                    if let progressHandler = progressHandler{
                        progressHandler(fling: fling)
                    }
                    return fling
                }
                
            }
        }

        
        return flings
    }
    
    func getFlingsOfVote(connectorData:GZFlingsOfVoteConnectorData, progressHandler:((fling:GZFling)->Void)?, completionHandler:GZHTTPConnectionCompleteHandlerCallBackArray, failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        self.connect(api: "fling/new", connectorData: connectorData, completionHandler: { (obj: AnyObject!, response:NSURLResponse!, error:NSError!) -> Void in
            
            var resultObject = JSON(obj)
            
            if !resultObject["success"].boolValue {
                failHandler(obj: obj, response: response, error: error)
            }else{
                
                var flings = self.convertToFlingsArray(obj, progressHandler: progressHandler)
                completionHandler(array: flings, response: response, error: nil)

            }
            
            
            

            }) { (response, error) -> Void in
                failHandler(obj: nil, response: response, error: error)
        }
        
        
    }
    
    func getFlingsOfPublic(connectorData:GZGetFlingsConnectorData, progressHandler:((fling:GZFling)->Void)?, completionHandler:GZHTTPConnectionCompleteHandlerCallBackArray, failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
    
        self.connect(api: "fling", connectorData: connectorData, completionHandler: { (obj: AnyObject!, response:NSURLResponse!, error:NSError!) -> Void in
            
            var flings = self.convertToFlingsArray(obj, progressHandler:progressHandler)
            
            completionHandler(array: flings, response: response, error: nil)
            
            }) { (response, error) -> Void in
                failHandler(obj: nil, response: response, error: error)
        }
        
        
    }
    
    
    
    //FIXME: 還沒完成 還差fling變成Object的處理
    func getSpecificFlingOfPublic(connectorData:GZGetFlingConnectorData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject,failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        self.connect(api: "fling/\(connectorData.flingHash)", connectorData: connectorData, completionHandler: { (obj:AnyObject!, response:NSURLResponse!, error:NSError!) -> Void in
            
            completionHandler(obj: GZFling(dataDict: obj), response: response, error: nil)
            
            
            }) { (response, error) -> Void in
                
                failHandler(obj: nil, response: response, error: error)
                
        }
        
    }
    
    func getFlingsOfMember(connectorData:GZGetMemberFlingsConnectorData, progressHandler:((fling:GZFling)->Void)?, completionHandler:GZHTTPConnectionCompleteHandlerCallBackArray,failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        self.connect(api: "fling/member", connectorData: connectorData, completionHandler: { (obj:AnyObject!, response:NSURLResponse!, error:NSError!) -> Void in
            
            completionHandler(array: self.convertToFlingsArray(obj, progressHandler:progressHandler), response: response, error: nil)
            
            }) { (response, error) -> Void in
                failHandler(obj: nil, response: response, error: error)
        }
        
    }
    
    //FIXME: 還沒完成 還差fling變成Object的處理
    func getSpecificFlingOfMember(connectorData:GZGetMemberFlingConnectorData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject,failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        self.connect(api: "fling/member/\(connectorData.flingHash)", connectorData: connectorData, completionHandler: { (obj:AnyObject!, response:NSURLResponse!, error:NSError!) -> Void in
            
            completionHandler(obj: obj, response: response, error: nil)
            
            }) { (response, error) -> Void in
                
                failHandler(obj: nil, response: response, error: error)
                
        }
        
        
        
    }
    
    
}