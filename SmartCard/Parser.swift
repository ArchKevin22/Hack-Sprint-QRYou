//
//  Parser.swift
//  SmartCard
//
//  Created by Kevin Kou on 6/4/17.
//
//

import Foundation

//String to ContactInfoStruct
func parse(str: String) -> ContactInfoStruct {
    let c = ContactInfoStruct()
    let f = str.components(separatedBy: ",")
    c.name = f[0]
    c.phoneNum = f[1]
    c.email = f[2]
    c.fbName = f[3]
    c.instagram = f[4]
    c.linkedin = f[5]
    
    return c
}

//ContactInfoStruct to String
func parse(obj: ContactInfoStruct) -> String {
    var s = obj.name
    s += ","
    s += obj.phoneNum
    s += ","
    s += obj.email
    s += ","
    s += obj.fbName
    s += ","
    s += obj.instagram
    s += ","
    s += obj.linkedin
    
    return s
}

//formatted phone number for US numbers
func parsePhoneNumber(usPhone: String) -> String {
    let strSize = usPhone.characters.count
    var startIndex = 0
    if strSize > 3 && usPhone[usPhone.startIndex] != "(" {
        var s = ""
        let substr = usPhone as NSString
        if usPhone[usPhone.startIndex] == "1" {
            s = "1 "
            startIndex = 1
        }
        let areacode = substr.substring(with: NSRange(location: 0 + startIndex, length: 3))
        s = s + "(" + areacode + ") "
        if strSize > 6 {
            let exchangecode = substr.substring(with: NSRange(location: 3 + startIndex, length: 3))
            s = s + exchangecode + "-"
            let subscribernum = usPhone.substring(from: usPhone.index(usPhone.startIndex, offsetBy: 6 + startIndex))
            s = s + subscribernum
        }
        else {
            let restofnumber = usPhone.substring(from: usPhone.index(usPhone.startIndex, offsetBy: 3 + startIndex))
            s = s + restofnumber
        }
        return s
    }
    else {
        return usPhone
    }
}
