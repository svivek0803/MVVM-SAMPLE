//
//  Date+Extension.swift
//  ExpatLand
//
//  Created by User on 04/01/22.
//  Copyright © 2022 cypress. All rights reserved.
//

import Foundation

extension Date {
    
    func getDateStringMonthFromUTC() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func getShortDateStringFromUTC() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: self)
    }
    
    func getTimeStringFromUTC() -> String {
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = locale
      //  dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
    }
    func getFullTimeStringFromUTC() -> String {
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "en_US_POSIX")
     //   dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = locale
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self)
    }
    
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = locale
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self).capitalized
    }
    
    func dayNumberOfWeek() -> Int {
        return Calendar.current.dateComponents([.weekday], from: self).weekday!
    }
    func monthNumber() -> Int {
        return Calendar.current.dateComponents([.month], from: self).month!
    }
    func yearNumber() -> Int {
        return Calendar.current.dateComponents([.year], from: self).year!
    }
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        }
        else if let hours = interval.hour, hours > 0 {
            return hours == 1 ? "\(hours)" + " " + "hour ago" :
                "\(hours)" + " " + "hours ago"
        }
        else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute ago" :
                "\(minute)" + " " + "minutes ago"
        }
        else {
            return "few seconds ago"
            
        }
        
    }
    
    
    func timeAgoSinceDateShort(_ date:Date, numericDates:Bool = false) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!)yr"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1yr"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!)mo"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1mo"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!)wk"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1wk"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!)d"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1d"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!)hr"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1hr"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!)mins "
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1min"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!)secs "
        } else {
            return "now"
        }
        
    }
    
    /// Returns the amount of years from another date
        func years(from date: Date) -> Int {
            return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
        }
        /// Returns the amount of months from another date
        func months(from date: Date) -> Int {
            return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
        }
        /// Returns the amount of weeks from another date
        func weeks(from date: Date) -> Int {
            return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
        }
        /// Returns the amount of days from another date
        func days(from date: Date) -> Int {
            return Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date()).day ?? 0
        }
        /// Returns the amount of hours from another date
        func hours(from date: Date) -> Int {
            return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
        }
        /// Returns the amount of minutes from another date
        func minutes(from date: Date) -> Int {
            return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
        }
        /// Returns the amount of seconds from another date
        func seconds(from date: Date) -> Int {
            return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
        }
        /// Returns the a custom time interval description from another date
        func offset(from date: Date) -> String {
            if years(from: date)   > 0 { return "\(years(from: date))y"   }
            if months(from: date)  > 0 { return "\(months(from: date))M"  }
            if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
            if days(from: date)    > 0 { return "\(days(from: date))d"    }
            if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
            if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
            if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
            return ""
        }
}
