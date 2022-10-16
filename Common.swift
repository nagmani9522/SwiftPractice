//
//  MDCommon.swift
//  MapNDrive
//
//  Created by Infoicon Technologies on 09/09/19.
//  Copyright © 2019 b. All rights reserved.
//

import UIKit
import CoreData
import SwiftMessages
import Photos
import GoogleMaps
import CoreTelephony


class Common: NSObject {
    

    class func previousDates(index: NSInteger) -> Date
    {
        let calendar = Calendar.current
        let dateFormat = calendar.date(byAdding: .day, value: -index, to: Date())
       return dateFormat!
    }

    // TimeStamp to Date
    class func toDate(_ timestamp: Any?) -> String {
        if let any = timestamp {
            if let str = any as? NSString {
                let dt =  Date(timeIntervalSince1970: str.doubleValue / 1000)
                let dateFormatter = DateFormatter()
                                       //  dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                                         dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                                         dateFormatter.timeZone = .current
                                         let localDate = dateFormatter.string(from: dt)
                       
                return localDate
            } else if let str = any as? NSNumber {
                 let dt =  Date(timeIntervalSince1970: str.doubleValue / 1000)
                 let dateFormatter = DateFormatter()
                                        // dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                                         dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                                         dateFormatter.timeZone = .current
                                         let localDate = dateFormatter.string(from: dt)
                 return localDate
            }
        }
        return ""
    }
    
    // TimeStamp to Time
    class func toTime(_ timestamp: Any?) -> String {
        if let any = timestamp {
            if let str = any as? NSString {
                let dt =  Date(timeIntervalSince1970: str.doubleValue / 1000)
                let dateFormatter = DateFormatter()
                                         dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
                                       //  dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                                         dateFormatter.timeZone = .current
                                         let localDate = dateFormatter.string(from: dt)
                       
                return localDate
            } else if let str = any as? NSNumber {
                 let dt =  Date(timeIntervalSince1970: str.doubleValue / 1000)
                 let dateFormatter = DateFormatter()
                                         dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
                                     //    dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                                         dateFormatter.timeZone = .current
                                         let localDate = dateFormatter.string(from: dt)
                 return localDate
            }
        }
        return ""
    }


    // TimeStamp to Time
    class func toDateTime(_ timestamp: Any?) -> String {
        if let any = timestamp {
            if let str = any as? NSString {
                let dt =  Date(timeIntervalSince1970: str.doubleValue / 1000)
                let dateFormatter = DateFormatter()
                                         dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
                                         dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
                                         dateFormatter.timeZone = .current
                                         let localDate = dateFormatter.string(from: dt)

                return localDate
            } else if let str = any as? NSNumber {
                 let dt =  Date(timeIntervalSince1970: str.doubleValue / 1000)
                 let dateFormatter = DateFormatter()
                                         dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
                                         dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
                                         dateFormatter.timeZone = .current
                                         let localDate = dateFormatter.string(from: dt)
                 return localDate
            }
        }
        return ""
    }

    
        // Request Photo Library
    class func requestPhotoLibrary()
    {
        let status = PHPhotoLibrary.authorizationStatus()

        if status == .notDetermined  {
            PHPhotoLibrary.requestAuthorization({status in

            })
        }
        }
    
    //MARK: - TableView cell presentation Animation
    
    class func animateTable(tableView : UITableView) {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
    
    class func animateBounce(view:UIView){
        
        view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 4.0,
                       options: .allowUserInteraction,
                       animations: {
                        view.transform = .identity
        },
                       completion: nil)
    }
    
    class func showPopUpAnimation(view:UIView){
        
        view.layer.opacity = 0.5
        view.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
        /* Anim */
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                
                view.layer.opacity = 1
                view.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
        )
    }
    
    class func hidePopUpAnimation(view:UIView)  {
        
        let currentTransform = view.layer.transform
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [],
            animations: {
                
                view.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                view.layer.opacity = 0
                
        }) { (finished) in
            
            view.removeFromSuperview()//.isHidden = true
        }
    }
    
    /*
     * Set label on Tableview if no record found
     */
    
    class func setLabelOnTableviewBackgroud(tableView:UITableView,title:String){
        
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text          = title
        noDataLabel.textColor     = .blue
        noDataLabel.textAlignment = .center
        noDataLabel.font          = UIFont(name: noDataLabel.font.fontName, size: 20)
        tableView.backgroundView  = noDataLabel
        tableView.separatorStyle  = .none
        
    }
    
    class func setLabelOnViewBackgroud(view:UIView,title:String){
        
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        noDataLabel.text          = title
        noDataLabel.textColor     = .blue
        noDataLabel.textAlignment = .center
        noDataLabel.font          = UIFont(name: noDataLabel.font.fontName, size: 20)
        
    }
    
    /*
     *  Check internet connection
     */
    
    class func showStatusBarNotification(title:String,color:UIColor){
        
        BPStatusBarAlert(duration: 0.3, delay: 2, position: .statusBar)
            .message(message: title)
            .messageColor(color: .white)
            .bgColor(color: color)
            .completion { print("completion closure will called") }
            .show()
    }
    
    class func isInternetAvailable()->Bool
    {
        let reach = Reachability()!
        if(!reach.isReachable)
        {
            self.showStatusBarNotification(title: "No Internet Connection",color: .red)
        }
        
        return reach.isReachable
    }
    
    //MARK:- Navigation Configuration
    
    class func navigationBackgroundTransparent(navigationBar:UINavigationBar){
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
    class func navigationBackgroundColor(navigationBar:UINavigationBar){
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor  = self.setColorWithHex(hex:COLOR_HEX.kNavigationBar)
    }
    
    /*
     * Set color with hex
     */
    class func setColorWithHex(hex:String)->UIColor{
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //Make two corners radius
    class func createCornerRadius(view: UIView,cornerRadius: CGFloat, cornerOne: CACornerMask, cornerTwo: CACornerMask) {
        view.clipsToBounds = false
        view.layer.cornerRadius = cornerRadius
        view.layer.maskedCorners = [cornerOne, cornerTwo]
    }
    
    //Error message view
    class func showError(_ theme: Theme,_ title: String,_ message: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(theme)
        view.configureDropShadow()
        view.button?.isHidden = true
        let iconText = (theme == .error) ? "😢" : "😀"
        view.configureContent(title: title, body: message, iconText: "")
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        SwiftMessages.show(view: view)
    }
    
    //MARK:- TextField placeholder color
    class func txtFieldPlaceholder(placeholderTitle: String, placeholderColor: UIColor) -> NSAttributedString {
        let placeholderString = NSAttributedString.init(string: placeholderTitle, attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
        return placeholderString
    }




    //MARK:- Check Premium Date Expired

  class func checkPremiumDateExpired(premiumDate  : String) -> Bool
  {
    if(premiumDate != ""){
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    print(dateFormatter.date(from: premiumDate)!)
    if Date() < dateFormatter.date(from: premiumDate) ?? Date() {
        print("Not Yet expiryDate")
        return true
    } else {
        print("expiryDate has passed")
        return false
    }
    }
    return false
  }

      //MARK:- COonvert Date to String

    class func convertDateToString(selectedDate  : Date) -> String
    {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        let now = df.string(from: selectedDate)
         return now
        //df.dateFormat = "MM-dd-yyyy hh:mm a"
    }
    //MARK:- COonvert Time to String
    class func convertTimeToString(currentTime  : Date) -> String
    {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "\(TimeZone.current.abbreviation()!)") //Current time zone
        formatter.dateFormat = "hh:mm a"
        let currentTime: String = formatter.string(from: currentTime)
         return currentTime
    }
    //MARK:- Methods for loader
    class func startLoaderWithoutTitle() {
        ACProgressHUD.shared.hideHUD()
    }
    
    class func startLoader(title:String) {
        ACProgressHUD.shared.indicatorColor = self.setColorWithHex(hex: "#2e3086")
        ACProgressHUD.shared.showHUD(withStatus: title)
        ACProgressHUD.shared.enableBackground = true
    }
    
    class func stopLoader() {
        ACProgressHUD.shared.hideHUD()
    }

   class func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    //MARK:- Save and get data from UserDefaults

    class func saveTrafficStatus(currentValue : Bool)
    {

        UserDefaults.standard.set(currentValue, forKey: USER_DEFAULT_CONSTANT.kTrafficStatus)
        UserDefaults.standard.synchronize()
    }
    class func getTrafficStatus() -> Bool
    {
        let currentValue = UserDefaults.standard.object(forKey: USER_DEFAULT_CONSTANT.kTrafficStatus)
        return currentValue as! Bool
    }

    class func saveAuthKeyInDefault(auth_key:String) {
        UserDefaults.standard.set(auth_key, forKey: USER_DEFAULT_CONSTANT.kAuthKey)
        UserDefaults.standard.synchronize()
    }
    
    class func getAuthKeyFromUserDefault() -> String {
        let auth_key = UserDefaults.standard.object(forKey: USER_DEFAULT_CONSTANT.kAuthKey)
        return auth_key as! String
    }
    
    class func separateFirstTerm(completeString: String) -> (String,String) {
        var components = completeString.components(separatedBy: " ")
        var firstTerm = ""
        var lastTerm = ""
        if(components.count > 0)
        {
         firstTerm = components.removeFirst()
         lastTerm = components.joined(separator: " ")
         debugPrint(firstTerm)
         debugPrint(lastTerm)
        }
        return (firstTerm,lastTerm)
    }
    
    class  func resizeImage(image: UIImage) -> UIImage {
        let actualHeight: Float = Float(image.size.height)
        let actualWidth: Float = Float(image.size.width)
        var maxHeight: Float = Float(image.size.height)
        var maxWidth: Float = Float(image.size.width)
        if actualHeight > 1080.0 {
            maxHeight = 1080.0
            let ratio = actualHeight/maxHeight
            maxWidth = actualWidth/ratio
        }
        let compressionQuality: Float = 1.0
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(maxWidth), height:  CGFloat(maxHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        let imageData = image.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }
    
    class func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height *      widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    class func splitFirstAndLastName(fullName: String) -> (String,String) {
        var components = fullName.components(separatedBy: " ")
        var firstName = ""
        var lastName = ""
        if components.count > 0 {
            firstName = components.removeFirst()
            lastName = components.joined(separator: " ")
            debugPrint(firstName)
            debugPrint(lastName)
        }
        return(firstName,lastName)
    }
    
    // Call Phone Number
    class func callNumber(phoneNumber:String) {
        
      if let phoneCallURL = URL(string: "tel://\(phoneNumber.filter({$0 != " "}))") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }

    class func removeSpaceAndSpecialCharacters(text:String) -> String
    {
        let okayChars : Set<Character> =
            Set("+1234567890")
        return String(text.filter {okayChars.contains($0) })
    }
    
    // Logout
    class func logOut(isSessionExpire : Bool)
    {
        Common.saveTrafficStatus(currentValue: false)
        UIApplication.shared.applicationIconBadgeNumber = 0
        if(Common.isKeyPresentInUserDefaults(key: "userId"))
        {
            let toId = "U-\(kdefaults.value(forKey: "userId") as! String)"
            let ref = firebaseReference.child("users/\(toId)")
            if !isSessionExpire {
                let userOfflineDict = ["onlineStatus" : 0, "logOutStatus" : 1, "lastOnlineTime": Int(CurrentTimestamp), "fcmToken":""] as [String : Any]
                ref.updateChildValues(userOfflineDict)
            }
            
            kdefaults.removeObject(forKey: "isLoggedIn")
            kdefaults.removeObject(forKey: "accessToken")
            kdefaults.removeObject(forKey: "expiresIn")
            kdefaults.removeObject(forKey: "refreshToken")
            kdefaults.removeObject(forKey: "username")
            kdefaults.removeObject(forKey: "driverAvailability")
            kdefaults.removeObject(forKey: "driverImageUrl")
            kdefaults.removeObject(forKey: "userId")
            kdefaults.removeObject(forKey: "followMarkerId")
            kdefaults.removeObject(forKey: "profile")
            kdefaults.removeObject(forKey: "subusertype")
            kdefaults.removeObject(forKey: "accesslevel")
            kdefaults.removeObject(forKey: "is_premium")
            APP_DELEGATE.navigateToRootScreen()
        }
    }


    class func reverseGeocodeCoordinate(lat: Double, long: Double, requestingPlaceId: Bool?, completionClosure: @escaping(String) ->())
    {

    ApiHelper.apiCallGetGoogle(route_URL: String(format:"https://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&key=AIzaSyCLm_iDG0KcEvUsVxdvFpcAh3-RBJ7LAgc",lat,long), param: nil, withAccess: false) { (responseJSON, error) in
        if(error == nil && responseJSON != nil)
        {
            if((responseJSON?["results"] as! Array<Any>).count > 0)
            {
            //print(((responseJSON?["results"] as! Array<Any>).first as! Dictionary<String, Any>)["formatted_address"])
                if(requestingPlaceId ?? false)
                {
                    completionClosure((((responseJSON?["results"] as! Array<Any>).first as! Dictionary<String, Any>)["place_id"]) as! String)
                }
                else
                {
                completionClosure((((responseJSON?["results"] as! Array<Any>).first as! Dictionary<String, Any>)["formatted_address"]) as! String)
                }
            }
            else{
                completionClosure("Loading...")
            }
        }
        else{
            completionClosure("Loading...")
        }
    }




//        let geocoder = GMSGeocoder()
//        let coordinate = CLLocationCoordinate2DMake(lat,long)
//
//
//        var currentAddress = String()
//
//        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
//             if(response?.results()?.count ?? 0 >= 0)
//             {
//            if let address = response?.firstResult() {
//                let lines = address.lines! as [String]
//
//                currentAddress = lines.joined(separator: " ")
//
//               completionClosure(currentAddress)
//            }
//            }
//        }
    }


   class func getCoordinateFromFirebase(driverModel : ManageDriverModel)
    {
        let ref = firebaseReference.child("locationTracking").child("D-\(driverModel.driverId)").child("currentLocation").observeSingleEvent(of: .value) { (snapshot) in

             guard let dictionary = snapshot.value as? [String: AnyObject] else {

                                         return
                                     }


          UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(dictionary["lat"] as! NSNumber),\(dictionary["long"] as! NSNumber)&zoom=14&views=traffic&q=\(dictionary["lat"] as! NSNumber),\(dictionary["long"] as! NSNumber)")!, options: [:], completionHandler: nil)


        }
    }
    class func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("1234567890")
        return String(text.filter {okayChars.contains($0) })
    }

    class func previousDates(index: NSInteger) -> String
       {
           let calendar = Calendar.current
           let dateFormat = calendar.date(byAdding: .day, value: -index, to: Date())
           let stringDate = getStringFromDate(date: dateFormat!)
           return stringDate
       }


    class func updateUnreadMessageCount()
    {

        let values = ["messageUnreadCount" : 0]

        let ref = firebaseReference.child("users").child(("U-\(kdefaults.value(forKey:"userId") as! String)"))
        ref.updateChildValues(values)
    }


    class func getDirection(heading : Double) -> String
    {
        var geoDirectionString = ""
        if heading > 22.5 && heading <= 67.5 {
            geoDirectionString = "NE"
        } else if heading > 67.5 && heading <= 112.5 {
            geoDirectionString = "E"
        } else if heading > 112.5 && heading <= 157.5 {
            geoDirectionString = "SE"
        } else if heading > 157.5 && heading <= 202.5 {
            geoDirectionString = "S"
        } else if heading > 202.5 && heading <= 247.5 {
            geoDirectionString = "SW"
        } else if heading > 248 && heading <= 293 {
            geoDirectionString = "W"
        } else if heading > 247.5 && heading <= 337.5 {
            geoDirectionString = "NW"
        } else if heading >= 337.5 || heading <= 22.5 {
            geoDirectionString = "N"
        }

        return geoDirectionString

    }

    class func saveMyAccountDetails(dict : [String : Any])
    {

        UserDefaults.standard.set(dict, forKey: "profile")
    }

    class func getMyAccountDetails() -> [String : Any]
    {
        if(isKeyPresentInUserDefaults(key: "profile"))
        {
        let dict = UserDefaults.standard.object(forKey: "profile")
        return dict as! [String : Any]
        }
        return [:]
    }
//    class func removeMyAccountDetails()
//    {
//        UserDefaults.standard.removeObject(forKey: "profile")
//    }

    //MARK:- Show Payment Popup

    class func checkPaymentPopUp(statusCode : NSInteger, navObj : UINavigationController, message : String)
    {
        if(statusCode == 0)
        {
        AlertController.alert(title: APPNAME, message: message, buttons: ["Yes", "No"]) { (alert, selectedIndex) in
            if(selectedIndex == 0)
            {
                let nextVC = IDUViewControllerAccessors.paymentSelectionVC
                navObj.pushViewController(nextVC, animated: true)
            }
            else{

        }
        }
        }
    }

    //MARK:- GET BASE URL

    class func getBaseUrl()
    {
        let ref = firebaseReference.child("appSettings").child("baseURL").observe(.value) { (snapshot) in
            guard let updatedBaseUrl = snapshot.value as? String else {

            return
            }
            BASE_URL =  updatedBaseUrl

        }
    }

    class func getCountryCode() -> String {
        guard let carrier = CTTelephonyNetworkInfo().subscriberCellularProvider, let countryCode = carrier.isoCountryCode else { return "1" }
        let prefixCodes = ["AF": "93", "AE": "971", "AL": "355", "AN": "599", "AS":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]
        let countryDialingCode = prefixCodes[countryCode.uppercased()] ?? ""
        return countryDialingCode
    }


}


