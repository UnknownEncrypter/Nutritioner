//
//  NutritionerExtensions.swift
//  Nutritioner
//
//  Created by Josiah Agosto on 11/30/20.
//

import Foundation

extension String {
    /// Retrieves current time as String, HH:MM AM/PM.
    static func getCurrentStringTime() -> Self {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let timeString = formatter.string(from: date)
        return timeString
    }
    
    /// Retrieves current Day as String.
    static func getCurrentDay() -> Self {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayString = dateFormatter.string(from: date)
        return dayString
    }
    
    /// Retrieves current Day from a date as String.
    static func getCurrentDay(_ from: Date) -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayString = dateFormatter.string(from: from)
        return dayString
    }
    
    /// Retrieves current date in Month/Day/Year format.
    static func getCurrentStringDate() -> Self {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dayString = dateFormatter.string(from: date)
        return dayString
    }
    
    /// Retrieves inputed date in Month/Day/Year format.
    static func getInputedDate(_ from: Date) -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dayString = dateFormatter.string(from: from)
        return dayString
    }
    
    /// Retrieves inputed date in Long Day of Week, Long Month, Day and Year.
    static func getInputedDateLongFormat(_ from: Date) -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        let dayString = dateFormatter.string(from: from)
        return dayString
    }
    
    /// Returns full date formatted, ex: FullDay, FullMonth,Day, Year, Hour:Minute:Second am/pm.
    static func getFullFormattedDateString() -> Self {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "MMMM dd,yyyy 'at' h:mm:s a"
        let fullDate = dateFormatter.string(from: date)
        return fullDate
    }
    
    /// Takes String date and makes it show day of week.
    static func convertStringDateToDayOfWeek(_ from: String) -> Self {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        if let date = formatter.date(from: from) {
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = "EEEE"
            let newFormatterString = newFormatter.string(from: date)
            return newFormatterString
        }
        return "Unavailable"
    }
    
    /// Multiplies inputed calories by servings.
    static func multiplyCalories(_ of: String, _ fromServings: String) -> Self {
        let calories = Int(String.checkForPercent(of)) ?? 0
        let servings = Int(fromServings) ?? 1
        let caloriesAfterServings = calories * servings
        let stringCalories = "\(caloriesAfterServings)"
        return stringCalories
    }
    
    ///
    static func checkForPercent(_ input: String) -> String {
        let inputedInput = input
        if inputedInput.contains("%") {
            let checkForNonNumber = inputedInput.replacingOccurrences(of: "%", with: "")
            guard let safeInput = Double(checkForNonNumber) else { return "" }
            let decimal = safeInput / 100
            let includingDailyPercentValue = Int(decimal * 2000)
            let stringNumber = "\(includingDailyPercentValue)"
            return stringNumber
        }
        return inputedInput
    }
    
}



extension Date {
    /// Retrieves a date and formats it, then returns it ex: Hour:Minute am/pm.
    static func getCurrentFullDate() -> Self {
        let date = Self()
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = TimeZone.current
        let timeString = formatter.string(from: date)
        let dateString = formatter.date(from: timeString)!
        return dateString
    }
    
    /// Retrieves current date in Month/Day/Year format.
    static func getCurrentStringDate() -> Self {
        let date = Self()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dayString = dateFormatter.string(from: date)
        let dayDate = dateFormatter.date(from: dayString)!
        return dayDate
    }
    
    // Converts a string date format to actual Date with the same format.
//    static func convertToDate(_ input: String) -> Self {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZ"
//        let newFormatter = DateFormatter()
//        newFormatter.dateFormat = "MM/dd/yyyy"
//        let inputedDate = newFormatter.date(from: input)!
//        let stringInputDate = newFormatter.string(from: inputedDate)
//        return Date()
//    }
    
    /// Retrieves current Day.
    static func getCurrentDay() -> Self {
        let date = Self()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayString = dateFormatter.string(from: date)
        let dayDate = dateFormatter.date(from: dayString)!
        return dayDate
    }
    
    /// Returns full date formatted, ex: FullDay, FullMonth,Day, Year, Hour:Minute:Second am/pm.
    static func getFullFormattedDate() -> Self {
        let date = Self()
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "EEEE,MMMM,dd,y h:mm:s a"
        let fullDate = dateFormatter.string(from: date)
        guard let dateFromString = dateFormatter.date(from: fullDate) else { return Date() }
        return dateFromString
    }
}



extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}



extension Calendar {
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(startingAfter: interval.start, matching: components, matchingPolicy: .nextTime) { (date, _, stop) in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
}



extension Double {
    /// Converts String value to Double.
    static func convertToDouble(_ from: String) -> Self {
        let input = from
        guard input.isEmpty != true else { return 0.0 }
        guard let inputInt = Double(input) else { return 0.0 }
        return inputInt
    }
    
    /// Converts number to daily percent value.
    static func calculateDailyPercentValue(_ input: String) -> Self {
        let inputLocal = input
        let checkForNonNumber = inputLocal.replacingOccurrences(of: "%", with: "")
        guard let safeInput = Double(checkForNonNumber) else { return 0 }
        let decimal = safeInput / 100
        let includingDailyPercentValue = decimal * 2000
        return includingDailyPercentValue
    }
}



extension Int16 {
    //
    static func convertStringToSafeInt16(_ from: Int16, _ with: String) -> Self {
        let convert = Int16(with) ?? 0
        let input = from
        let combined = input + convert
        return combined
    }
}
