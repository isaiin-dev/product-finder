//
//  Log.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 19/04/22.
//

import Foundation

enum LogEvent: String {
   case e = "[âŧī¸]" // error
   case i = "[âšī¸]" // info
   case d = "[đŦ]" // debug
   case v = "[đŦ]" // verbose
   case w = "[â ī¸]" // warning
   case s = "[đĨ]" // severe
}

enum EventDomain: String {
    case APIManager = "APIManager"
}

enum EventSubDomain: String {
    case BadResponse = "bad_response"
    case DecodingError = "decoding_error"
    case CastError = "cast_error"
    case RequestError = "request_error"
}

struct DebugPath {
    let fileName, funcName: String
    let line, column: Int
}

class Log {
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    static var enabled = true
    
    fileprivate static func getFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    fileprivate static func Log(tag: String, strToLog: String) {
        print("")
        print("đ°đ°đ°đ°đ°đ°đ°đ°đ°đ° Log Start: \(tag) đ°đ°đ°đ°đ°đ°đ°đ°đ°đ°")
        print(strToLog)
        print("đ°đ°đ°đ°đ°đ°đ°đ°đ°đ° Log End: \(tag)  đ°đ°đ°đ°đ°đ°đ°đ°đ°đ°")
        print("")
    }
    
    fileprivate static var canLog: Bool {
        return enabled
    }
    
    class func toConsole(
        type: LogEvent,
        tag: String, _ object: Any,
        filename: String = #file,
        line: Int = #line, column:
        Int = #column,
        funcName: String = #function) {
            
            guard canLog else { return }
            
            Log(
                tag: tag,
                strToLog: """
                    - Date:     \(Date().toString())
                    - File:     \(type.rawValue)[\(getFileName(filePath: filename))]
                    - Line:     \(line)
                    - Column:   \(column)
                    - Function: \(funcName)
                    - Data:     \(object)
                """)
    }
}

extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }
}
