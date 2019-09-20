//
//  UserModel.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit

var UserInfo = NSKeyedUnarchiver.unarchiveObject(withFile: FilePath.filePath(.documentDirectory, senderPath: "/loginUserInfo.archiver")) as? UserModel

class UserModel: NSObject {
    var userId : String = ""        // 用户id
    var phone : String = ""         // 注册手机号
    var token : String = ""
    var nickName : String = ""      // 用户昵称
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.userId, forKey: "userId")
        aCoder.encode(self.phone, forKey: "phone")
        aCoder.encode(self.token, forKey: "token")
        aCoder.encode(self.nickName, forKey: "nickName")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.userId = aDecoder.decodeObject(forKey: "userId") as! String
        self.phone = aDecoder.decodeObject(forKey: "phone") as! String
        self.token = aDecoder.decodeObject(forKey: "token") as! String
        self.nickName = aDecoder.decodeObject(forKey: "nickName") as! String
    }
    
    override init() {}
}

class FilePath: NSObject {
    
    class func filePath(_ path: FileManager.SearchPathDirectory, senderPath: String?) -> String{
        if senderPath == ""{
            return ""
        }
        
        return NSSearchPathForDirectoriesInDomains(path, .userDomainMask, true)[0].appending(senderPath!)
    }
    
    class func isFileExistWithFilePath(filePath: String) -> Bool{
        if filePath == ""{
            return false
        }
        return FileManager.default.fileExists(atPath: filePath)
    }
    
}
