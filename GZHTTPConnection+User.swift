//
//  UserConnector.swift
//  Flingy
//
//  Created by Grady Zhuo on 2014/9/25.
//  Copyright (c) 2014年 Grady Zhuo. All rights reserved.
//

import Foundation

extension GZHTTPConnection {
    
    //MARK: - Login
    func login(connectorData:GZLoginConnectorData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject, failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        var loginType = connectorData.loginType?.keyString
        
        self.connect(api: "login/\(loginType!)", connectorData: connectorData, completionHandler: { (obj, response, error) -> Void in
            completionHandler(obj: obj, response: response, error: nil)
            }) { (response, error) -> Void in
                failHandler(obj: nil, response: response, error: error)
                
        }
        
    }

    func getInstagramLoginURL(connectorData:GZHTTPConnectionData, completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject, failHandler:GZHTTPConnectionCallBackDefaultFailHandler){
        
        
//        self.connect(api: "login/\(loginType!)", connectorData: connectorData, completionHandler: { (obj, response, error) -> Void in
//            completionHandler(obj: obj, response: response, error: nil)
//            }) { (response, error) -> Void in
//                failHandler(obj: nil, response: response, error: error)
//                
//        }
        
    }
    
    
}

//    func logout(completionHandler:GZHTTPConnectionCompleteHandlerCallBackObject){
//
//        var connectorData = GZHTTPConnectionData()
//
//        self.connect(api: "logout", connectorData: connectorData, completionHandler: { (obj, response) -> Void in
//            completionHandler(obj: obj, response: response, error: nil)
//            }) { (originalData, response, error) -> Void in
//                completionHandler(obj: nil, response: response, error:  error)
//        }
//
//    }
//