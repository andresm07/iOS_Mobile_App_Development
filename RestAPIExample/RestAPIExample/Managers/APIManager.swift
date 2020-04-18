//
//  APIManager.swift
//  RestAPIExample
//
//  Created by admin on 4/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static let rootURL = "http://alpha-meme-maker.herokuapp.com"
    
    class func getAllMemes(completionHandler: @escaping (_ error: MemeAPIErrors?, _ memes: [Meme]?) -> Void) {
        guard let isNetworkReachable = NetworkReachabilityManager()?.isReachable else {
            completionHandler(MemeAPIErrors.noInternetConnection, nil)
            return
        }
        
        if isNetworkReachable {
            makeRequestToGetAllMemesToAPI(completionHandler: completionHandler)
        } else {
            completionHandler(MemeAPIErrors.noInternetConnection, nil)
        }
    }
    
    private class func makeRequestToGetAllMemesToAPI(completionHandler: @escaping (_ error: MemeAPIErrors?, _ memes: [Meme]?) -> Void) {
        guard let request = AlamofireHelper.createRequest(parameters: nil, requestPath: APIManager.rootURL, httpMethod: HTTPMethod.get) else {
            return completionHandler(MemeAPIErrors.invalidURL, nil)
        }
        AF.request(request).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                guard let jsonAnswer = response.value as? [String: Any], let memeData = jsonAnswer["data"] as? [[String: Any]] else {
                    completionHandler(MemeAPIErrors.wrongAnswer, nil)
                    return
                }
                var memeList = [Meme]()
                for meme in memeData {
                    memeList.append(Meme(dictionary: meme))
                }
                completionHandler(nil, memeList)
            case .failure:
                completionHandler(MemeAPIErrors.serverError, nil)
            }
        }
    }
}
