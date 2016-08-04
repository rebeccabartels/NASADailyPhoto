//
//  NASA_API_CLIENT.swift
//  NASA_API
//
//  Created by Rebecca Bartels on 8/3/16.
//  Copyright © 2016 Rebecca Bartels. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NasaAPI {
    
    //by placing class infront of a func (making it no longer an instance func), you don't have to create a different instance of it in another file you can just call it. This is important with a datastore.
    //a class defines a group of funcs and objects that all share a characteristic or attribute. 
        //Anytime we call on UiView class, everything within there (all properties and funcs) are all related to the UIView. 
    
    //single responsibility principle -- each func has purpose -- each class has funcs that serve one greater purpose.
    
    //when this is done the func runs but the completion blocks run after the func returns and it can't return an image yet so we have to tell the program that.
    
    class func getAPOD (completion: UIImage -> ())   {
        
        
        var finalImage = UIImage()
        
        Alamofire.download(.GET, Secrets.nasaURL) { temporaryURL, response in
            let fileManager = NSFileManager.defaultManager()
            let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let pathComponent = response.suggestedFilename
            
            return directoryURL.URLByAppendingPathComponent(pathComponent!)
        }
        
        Alamofire.request(.GET, Secrets.nasaURL).validate().responseJSON { response in
            switch response.result {
            case.Success:
                if let value = response.result.value {
                    let json = JSON(value) //the value can be any object. Swifty json pls parse into json.
                    print("JSON:/(json)")
                    let imageURL = json["url"].stringValue   //turns the object into a string value
                    print("Image URL: \(imageURL)")
                    
                    
                    Alamofire.request(.GET, imageURL)
                        .responseImage { response in
                            debugPrint(response)
                            
                            print(response.request)
                            print(response.response)
                            debugPrint(response.result)
                            
                            if let image = response.result.value {
                                print("image downloaded: \(image)")
                                completion(image)   //that image is going into the class func getAPOD
                                
                                
                            }
                          
                            
                        }
                

                    }
                
            case.Failure(let error):
                print(error)
                            }
            
                    }
        
        
            }
    
    }


