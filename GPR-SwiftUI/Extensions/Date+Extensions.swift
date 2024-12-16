//
//  Date+String.swift
//  GPR-SwiftUI
//
//  Created by Tommy Fernandez on 16/12/2024.
//

import Foundation

extension Date {
    /// Date to string to functions with specific format
    /// - Parameter format: Format in which the date must be written
    /// - Returns: String formatted date
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /// Returns the week of year of the date
    var weekOfYear: Int {
        var calender = Calendar(identifier: .gregorian)
        calender.firstWeekday = 2
        let weekOfYear = calender.component(.weekOfYear, from: self)
        return weekOfYear
    }
    
    /// Returns the year of the date
    var year: Int {
        var calender = Calendar(identifier: .gregorian)
        calender.firstWeekday = 2
        let weekOfYear = calender.component(.year, from: self)
        return weekOfYear
    }
    
    /// Retrieve the first day of the week in which the current date appears with the week starting from Monday
    /// - Returns: Date of the first day
    func getFirstDayOfWeek() -> Date? {
        let components = DateComponents(weekOfYear: weekOfYear, yearForWeekOfYear: year)
        var calender = Calendar(identifier: .gregorian)
        calender.firstWeekday = 2
        return calender.date(from: components)
    }
}
