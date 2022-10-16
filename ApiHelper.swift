
//
//  Created by Mac on 02/11/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import Alamofire


class ApiHelper: NSObject {

    
    class func apiCallGet(serviceName: String,param: NSMutableDictionary?, isWithHeader: Bool?, showLoader: Bool? = nil,
                       completionClosure: @escaping(NSDictionary?,Error?) ->())
    {
print("Get1")
        if(isWithHeader ?? false && (!Common.isKeyPresentInUserDefaults(key: "accessToken")))
               {
            Common.logOut(isSessionExpire: true)
                   return
               }

        if Common.isInternetAvailable(){
            
            var isShowLoader=true
            if let show = showLoader{
                
                if show == false{
                    isShowLoader=false
                }else{
                    isShowLoader=true
                }
            }
            
            if isShowLoader {
                
                Common.startLoader(title: "Loading...")
            }
            
           // var paramValues:Parameters?
           // paramValues = param as? Parameters
            
            print("REQUEST URL :: \(BASE_URL+serviceName)")
     //       print("REQUEST PARAMETERS :: \(paramValues!)")
            
            //Header Implementation
            
            var headers: HTTPHeaders = [:]
            if !isWithHeader!{
//                headers = [
//                    "Accept"  : "application/json"
//                ]
            }else{
                headers = [
                    "Accept"  : "application/json",
                     "access_token"  : "\(kdefaults.value(forKey: "accessToken")!)"
                ]
            }

            
            
            // Remove above code if you dont want to Header
            let manager = Alamofire.Session.default
            manager.session.configuration.timeoutIntervalForRequest = 10
            
            manager.request(BASE_URL+serviceName,method:.get,parameters:nil,encoding: JSONEncoding.default,headers:headers).responseJSON { response in
                
                Common.stopLoader()

                switch response.result {

                case let .success(value):
                            print(value)
                   // DispatchQueue.main.async {

                        let responseJson = value as? NSDictionary
                        completionClosure(responseJson, nil)
                        if(responseJson?["status_code"] as! NSInteger == 301)
                        {
                            Common.logOut(isSessionExpire: true)
                        }
                 //   }

                case let .failure(error):
                    print(error)
                    AlertController.alert(message: error.localizedDescription)

//                case .success:
//
//                  //  if let JSON = response.result{
//
//                        //debugPrint("Repsonse::\(JSON)");
//
//
//                    //}
//
//                case .failure(let error):
//                    print(error)
                    //Common.showAlert(message: error.localizedDescription)

                    //completionClosure(JSON as? NSDictionary, nil)
                }
                
            }
            
        }
        
    }
    
    class func apiCallPost(serviceName: String,param: [String:Any], isWithToken: Bool?, showLoader: Bool? = nil,
                       completionClosure: @escaping(NSDictionary?,Error?) ->())
    {
        print("Post1")
        if(isWithToken ?? false && (!Common.isKeyPresentInUserDefaults(key: "accessToken")))
        {
            Common.logOut(isSessionExpire: true)
            return
        }

        if Common.isInternetAvailable(){
            
            var isShowLoader=true
            if let show = showLoader{
                
                if show == false{
                    isShowLoader=false
                }else{
                    isShowLoader=true
                }
            }
            
            if isShowLoader {
                
                Common.startLoader(title: "Loading...")
            }
            
            var paramValues:Parameters?
             paramValues = param as? Parameters
            
            Debug.log("REQUEST URL :: \(BASE_URL+serviceName)")
            Debug.log("REQUEST PARAMS :: \(param)")
            
            //Header Implementation
            
            //            let valueArrayNotToCheckAuth = [API_CONSTANT.kCustomerLogin,API_CONSTANT.kCustomerRegistration]
            var headers: HTTPHeaders = [:]
            
            if isWithToken!{
            
                headers = [
                    "Accept"  : "application/json",
                    "Authorization"  : "\(kdefaults.value(forKey: "accessToken")!)"
                ]
            }else{
            
                headers = [
                    "Accept"  : "application/json"
                ]
            }
            
            print(headers)
            // Remove above code if you dont want to Header
            let manager = Alamofire.Session.default
            manager.session.configuration.timeoutIntervalForRequest = 10
            
            manager.request(BASE_URL+serviceName,method:.post,parameters:paramValues,encoding: JSONEncoding.default,headers:headers).responseJSON { response in
                
                if((serviceName == API_CONSTANTS.kGetAcceptedDrivers || serviceName == API_CONSTANTS.kHome  || !serviceName.contains("is_premium") || !serviceName.contains("check_app_subscription")) && showLoader == false)
                {
                    print("Loader issue")
                }
                else{
                    Common.stopLoader()
                }
                switch response.result {


                case let .success(value):
                            print(value)
                  //  DispatchQueue.main.async {
                        if(value != nil)
                        {
                        let responseJson = value as? NSDictionary
                        completionClosure(responseJson, nil)

                        if(responseJson?["status_code"] as! NSInteger == 301)
                        {
                             Common.logOut(isSessionExpire: true)
                        }
                    //    }
                    }
                        case let .failure(error):
                            print(error)
                            if(!serviceName.contains("home") && !serviceName.contains("is_premium") && !serviceName.contains("check_app_subscription"))
                            {
                            AlertController.alert(message: error.localizedDescription)
                            }

//                case .success:
//
//                 //   if let JSON = response.result.value{
//
//                        //debugPrint("Repsonse::\(JSON)");
//                        //Debug.log("Repsonse::\(JSON)")
//
//                   // }
//
//                case .failure(let error):
//                    print(error)
//                    //Common.showAlert(message: error.localizedDescription)
//                    AlertController.alert(message: error.localizedDescription)
//                    //completionClosure(JSON as? NSDictionary, nil)
                }
                
            }
            
        }
        
    }

    class func apiCallPostArray(serviceName: String,param: [[String:Any]], isWithToken: Bool?, showLoader: Bool? = nil,
                       completionClosure: @escaping(NSDictionary?,Error?) ->())
    {
        print("Post1")
        if(isWithToken ?? false && (!Common.isKeyPresentInUserDefaults(key: "accessToken")))
        {
            Common.logOut(isSessionExpire: true)
            return
        }

        if Common.isInternetAvailable(){

            var isShowLoader=true
            if let show = showLoader{

                if show == false{
                    isShowLoader=false
                }else{
                    isShowLoader=true
                }
            }

            if isShowLoader {

                Common.startLoader(title: "Loading...")
            }

            var paramValues:Parameters?
            paramValues = param as? Parameters

            Debug.log("REQUEST URL :: \(BASE_URL+serviceName)")
            Debug.log("REQUEST PARAMS :: \(param)")

            //Header Implementation

            //            let valueArrayNotToCheckAuth = [API_CONSTANT.kCustomerLogin,API_CONSTANT.kCustomerRegistration]
            var headers: HTTPHeaders = [:]

            if isWithToken!{

                headers = [
                    "Accept"  : "application/json",
                    "Authorization"  : "\(kdefaults.value(forKey: "accessToken")!)"
                ]
            }else{

                headers = [
                    "Accept"  : "application/json"
                ]
            }

            print(headers)
            // Remove above code if you dont want to Header
            let manager = Alamofire.Session.default
            manager.session.configuration.timeoutIntervalForRequest = 10

            manager.request(BASE_URL+serviceName,method:.post,parameters:paramValues,encoding: JSONEncoding.default,headers:headers).responseJSON { response in

                Common.stopLoader()
                switch response.result {


                case let .success(value):
                            print(value)
                  //  DispatchQueue.main.async {
                        if(value != nil)
                        {
                        let responseJson = value as? NSDictionary
                        completionClosure(responseJson, nil)

                        if(responseJson?["status_code"] as! NSInteger == 301)
                        {
                             Common.logOut(isSessionExpire: true)
                        }
                  //      }
                    }
                        case let .failure(error):
                            print(error)
                            if(!serviceName.contains("home"))
                            {
                            AlertController.alert(message: error.localizedDescription)
                            }

//                case .success:
//
//                 //   if let JSON = response.result.value{
//
//                        //debugPrint("Repsonse::\(JSON)");
//                        //Debug.log("Repsonse::\(JSON)")
//
//                   // }
//
//                case .failure(let error):
//                    print(error)
//                    //Common.showAlert(message: error.localizedDescription)
//                    AlertController.alert(message: error.localizedDescription)
//                    //completionClosure(JSON as? NSDictionary, nil)
                }

            }

        }

    }
    
    class func apiCallWithImage(serviceName: String,image:Data,imageName:String,param: Any?,showLoader: Bool?,
                                completionClosure: @escaping(NSDictionary?,Error?) ->())
    {
        var fileType = imageName.components(separatedBy: ".")
        if Common.isInternetAvailable(){
            
            if showLoader! {
                Common.startLoader(title: "Loading...")
            }
            
            print("REQUEST URL :: \(BASE_URL+serviceName)")
            print("REQUEST PARAMETERS :: \(String(describing: param))")
            
            var paramString:String?
            
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: param!,
                options: []) {
                
                let theJSONText = String(data: theJSONData,
                                         encoding: .utf8)!
                
                paramString = theJSONText as String
                print("JSON string = \(theJSONText)")
            }
            
            var headers: HTTPHeaders = [:]
            headers = [
                "Accept"  : "application/json",
                "Authorization"  : "\(kdefaults.value(forKey: "accessToken")!)"
            ]
            
            let manager = Alamofire.Session.default
                        
            manager.upload(multipartFormData: { (multipartFormData) in
                for (key,value) in param as! NSDictionary {
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key as! String)
                }
                if imageName == "profileImage.png" {
                    if let uploadImage = UIImage(data: image) {
                        multipartFormData.append(image, withName:"profile_image",fileName: "file.\(fileType[fileType.count-1])", mimeType: "file/\(fileType[fileType.count-1])")
                    }
                }
                
                
            }, to: BASE_URL+serviceName,headers: headers).responseJSON { response in
                print(response.result)
                Common.stopLoader()
                
                switch response.result
                {
                case let .success(value):
                    // var json = JSON(data: value!)
                    completionClosure(value as! NSDictionary,nil)
                    
                case let .failure(error):
                    completionClosure(nil,error)
                    
                }
                
            }
        }
        
    }
    
    class func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
   // class func apiCallWithImages(serviceName: String,imageDict:[String: Any],imageNameDict:[String: Any],param: NSMutableDictionary?, isWithToken: Bool?,showLoader: Bool? = nil,
 //                                completionClosure: @escaping(NSDictionary?,Error?) ->())
//    {
//        //var fileType = imageName.components(separatedBy: ".")
//        if Common.isInternetAvailable(){
//
//            var isShowLoader=true
//            if let show = showLoader{
//
//                if show == false{
//                    isShowLoader=false
//                }else{
//                    isShowLoader=true
//                }
//            }
//
//            if isShowLoader {
//
//                Common.startLoader(title: "Loading...")
//            }
//            print("REQUEST URL :: \(BASE_URL+serviceName)")
//            print("REQUEST PARAMETERS :: \(String(describing: param))")
//
//            var paramString:String?
//
//            if let theJSONData = try? JSONSerialization.data(
//                withJSONObject: param!,
//                options: []) {
//
//                let theJSONText = String(data: theJSONData,
//                                         encoding: .utf8)!
//
//                paramString = theJSONText as String
//                print("JSON string = \(theJSONText)")
//            }
//
//            var headers: HTTPHeaders = [:]
//            if isWithToken!{
//                headers = [
//                    "Accept"  : "application/json",
//                    "access_token"  : "\(kdefaults.value(forKey: "accessToken")!)"
//                ]
//            }else{
////                headers = [
////                    "Accept": "application/json"
////                ]
//            }
//
//            let manager = Alamofire.Session.default
//
//            //let imageData = UIImageJPEGRepresentation(image, 0.6)
//
//            manager.upload(multipartFormData: { multipartFormData in
//                // import image to request
//                for (key, value) in imageNameDict {
//                    multipartFormData.append(imageDict[key] as! Data, withName: value as! String, fileName: "\(key).jpeg", mimeType: "image/jpeg")
//                }
//                for (key, value) in param!{
//                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key as! String)
//                }
//
//            }, to: BASE_URL+serviceName,headers: headers, encodingCompletion: { (result) in
//
//                switch result {
//                case .success(let upload, _, _):
//
//                    upload.responseJSON { response in
//
//                        print("File upload:\(response)")
//                        if let JSON = response.result.value{
//
//                            //debugPrint("Repsonse::\(JSON)");
//
//                            DispatchQueue.main.async {
//
//                                let responseJson=JSON as? NSDictionary
//
//                                Common.stopLoader()
//                                completionClosure(responseJson, nil)
//                                if(responseJson?["status_code"] as! NSInteger == 301)
//                                {
//                                     Common.logOut(isSessionExpire: true)
//                                }
//                            }
//                        }
//                    }
//                case .failure(let encodingError):
//                    Common.stopLoader()
//
//                    AlertController.alert(message: encodingError.localizedDescription)
//                    //Common.showAlert(message: encodingError.localizedDescription)
//                    print("encodingError:\(encodingError)")
//                }
//            })
//        }
//    }
    
    class func apiCallGetGoogle(route_URL: String,param: NSMutableDictionary?, withAccess: Bool?,showLoader: Bool? = nil,
                                completionClosure: @escaping(NSDictionary?,Error?) ->())
    {
        if Common.isInternetAvailable(){
            
            var isShowLoader=false
            if let show = showLoader{
                
                if show == false{
                    isShowLoader=false
                }else{
                    isShowLoader=true
                }
            }
            
            if isShowLoader {
                
                Common.startLoader(title: "Loading...")
            }
            
            
            
            // Remove above code if you dont want to Header
            let manager = Alamofire.Session.default
            manager.session.configuration.timeoutIntervalForRequest = 10
            
            manager.request(route_URL,method:.get,parameters:nil,encoding: JSONEncoding.default,headers:nil).responseJSON { response in
                
                Common.stopLoader()
                switch response.result {
                case let .success(value):
                    
                   // if let JSON = response.result.value{
                        
                        //debugPrint("Repsonse::\(JSON)");
                        
                       // DispatchQueue.main.async {
                          //  print(value)
                            //let jsonDictionary = convertToDictionary(text: response)
                        //    let responseJson = response as? NSDictionary
                            completionClosure(value as! NSDictionary, nil)
                      //  }
                 //   }
                    
                case .failure(let error):
                    print(error)
                    AlertController.alert(message: error.localizedDescription)
                    //Common.showAlert(message: error.localizedDescription)
                    //completionClosure(JSON as? NSDictionary, nil)
                }
                
            }
            
        }
        
    }
    
  //  class func apiCallWithDocument(serviceName: String,image:Data,imageName:String,param: Any?,showLoader: Bool? = nil,
   //                             completionClosure: @escaping(NSDictionary?,Error?) ->())
//    {
//        var fileType = imageName.components(separatedBy: ".")
//        if Common.isInternetAvailable(){
//
//            var isShowLoader=true
//            if let show = showLoader{
//
//                if show == false{
//                    isShowLoader=false
//                }else{
//                    isShowLoader=true
//                }
//            }
//            if isShowLoader {
//
//                Common.startLoader(title: "Loading...")
//            }
//
//            print("REQUEST URL :: \(BASE_URL+serviceName)")
//            print("REQUEST PARAMETERS :: \(String(describing: param))")
//
//            var paramString:String?
//
//            if let theJSONData = try? JSONSerialization.data(
//                withJSONObject: param!,
//                options: []) {
//
//                let theJSONText = String(data: theJSONData,
//                                         encoding: .utf8)!
//
//                paramString = theJSONText as String
//                print("JSON string = \(theJSONText)")
//            }
//
//            var headers: HTTPHeaders = [:]
//            headers = [
//                "Accept"  : "application/json",
//                "access_token"  : "\(kdefaults.value(forKey: "accessToken")!)"
//            ]
//
//            let manager = Alamofire.Session.default
//
//            //let imageData = UIImageJPEGRepresentation(image, 0.6)
//
//            manager.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append(image, withName:"mapfile",fileName: "drive.kmz", mimeType: "kmz")
//
//            debugPrint(multipartFormData)
//            }, to: BASE_URL+serviceName,headers: headers, encodingCompletion: { (result) in
//
//                switch result {
//                case .success(let upload, _, _):
//
//                    upload.responseString { response in
//
//                        print("File upload:\(response)")
//
//                        if let JSON = response.result.value{
//
//                            //debugPrint("Repsonse::\(JSON)");
//                            let jsonDictionary = convertToDictionary(text: JSON)
//                            DispatchQueue.main.async {
//
//                                let responseJson=jsonDictionary as NSDictionary?
//
//                                Common.stopLoader()
//                                completionClosure(responseJson, nil)
//                            }
//                        }
//                    }
//                case .failure(let encodingError):
//                    Common.stopLoader()
//                    AlertController.alert(message: encodingError.localizedDescription)
//                    //Common.showAlert(message: encodingError.localizedDescription)
//                    print("encodingError:\(encodingError)")
//                }
//            })
//        }
//
//    }
    
}
