//
//  Log.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 19/04/22.
//

import Foundation

enum LogEvent: String {
   case e = "[‼️]" // error
   case i = "[ℹ️]" // info
   case d = "[💬]" // debug
   case v = "[🔬]" // verbose
   case w = "[⚠️]" // warning
   case s = "[🔥]" // severe
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
    
    fileprivate static func getFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    fileprivate static func Log(tag: String, strToLog: String) {
        print("")
        print("🀰🀰🀰🀰🀰🀰🀰🀰🀰🀰 Log Start: \(tag) 🀰🀰🀰🀰🀰🀰🀰🀰🀰🀰")
        print(strToLog)
        print("🀰🀰🀰🀰🀰🀰🀰🀰🀰🀰 Log End: \(tag)  🀰🀰🀰🀰🀰🀰🀰🀰🀰🀰")
        print("")
    }
    
    fileprivate static var canLog: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
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
