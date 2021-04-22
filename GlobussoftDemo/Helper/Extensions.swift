//
//  Extensions.swift
//  GlobussoftDemo
//
//  Created by Kriti Agarwal on 21/04/21.
//

import UIKit


extension UIImageView {
    public func imageFromServerURL(urlString: String , completion: @escaping (_ image : UIImage) -> Void) {
        guard urlString.count > 0 else {
            return
        }
        let url = urlString.replacingOccurrences(of: "http://", with: "https://")
        self.image = nil
        self.sd_setImage(with: URL(string: url), placeholderImage: nil)
        completion(image ?? UIImage())
    }
}

extension String {
public func imageFromServerURL(urlString: String , completion: @escaping (_ image : UIImage) -> Void) {
    guard urlString.count > 0 else {
        return
    }
    URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
        
        if error != nil {
            print(error)
            return
        }
        DispatchQueue.main.sync(execute: { () -> Void in
            let image = UIImage(data: data!)
            completion(image ?? UIImage())
        })
        
    }).resume()
}}


extension UIView {
    func roundCornerWithShadow(shadowColor:UIColor,radius:CGFloat,borderWidth:CGFloat,borderColor:UIColor,shadowOpacity:Float,shadowRadius:CGFloat,shadowOffsetWidth:CGFloat,shadowOffsetHeight:CGFloat,clipsbounds : Bool = false){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height:shadowOffsetHeight)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.clipsToBounds = clipsbounds
    }
}

extension Date {
    
    func getElapsedInterval() -> String {
                                                                                    
        let interval = Calendar.current.dateComponents([.year, .month, .day,.hour,.minute,.second], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + k.kYearAgo :
                "\(year)" + " " + k.kYearsAgo
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + k.kMonthAgo :
                "\(month)" + " " + k.kMonthsAgo
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + k.kDayAgo :
                "\(day)" + " " + k.kDaysAgo
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + k.kHourAgo :
                "\(hour)" + " " + k.kHoursAgo
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + k.kMinAgo :
                "\(minute)" + " " + k.kMinsAgo
        } else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + k.kSecAgo :
                "\(second)" + " " + k.kSecsAgo
        }
        else {
            return k.kMomentAgo
            
        }
        
    }
    
}


extension String {

    func stringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-DD'T'hh:mm:ss TZTD"
        dateFormatter.timeZone = TimeZone.current
        let datee = dateFormatter.date(from: self)
        
        return datee
    }
}

extension UITextField {

   func addInputViewDatePicker(target: Any, selector: Selector) {

    let screenWidth = UIScreen.main.bounds.width

    //Add DatePicker as inputView
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
    datePicker.datePickerMode = .date
    self.inputView = datePicker

    //Add Tool Bar as input AccessoryView
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
    let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
    toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

    self.inputAccessoryView = toolBar
 }

   @objc func cancelPressed() {
     self.resignFirstResponder()
   }
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
