//
//  HttpManager.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CommonCrypto


typealias ReqSuccess = (_ response: AnyObject?)->Void
typealias ReqFailure = (_ failure: FailureStruct)->Void

/// 请求出现错误时传递error或json给视图或控制器,让其处理错误
struct FailureStruct {
    var error: Error?
    var json: JSON?
}


struct CType {
    static let json = "application/json"
    static let form = "application/x-www-form-urlencoded"
}

struct HeaderKey {
    static let contentType = "Content-Type"
    static let token = "KY-TOKEN"
    static let visitorToken = "KY-VISITOR-TOKEN"
    static let time = "timestamp"
    static let sign = "sign"
    static let version = "KY-VERSION"
    static let appType = "KY-APPTYPE"
}

struct HttpManager {
    static let shared = HttpManager()
    
    public func request(method: HTTPMethod, path: String, parameters: [String : Any], isEncrypting : Bool, success: @escaping ReqSuccess, failure: @escaping ReqFailure){
        let headers = self.headers(method, isEncrypting)
        print(headers)
        
        AF.request(path, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers, interceptor: .none).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.value {
                    success(value as AnyObject)
                }
            case .failure:
                if let error = response.error {
                    let f = FailureStruct.init(error: error, json: nil)
                    failure(f)
                }
            }
        }
    }
}

extension HttpManager {
    /// 这是没有token的写法,项目中具体参数根据后端的设置传递
    private func headers(_ method: HTTPMethod, _ isEncrypting: Bool) -> HTTPHeaders {
        var headers = [String:String]()
        headers = [HeaderKey.contentType: CType.json,
                   HeaderKey.version: Bundle.appVersion(),
                   HeaderKey.appType: "1"]
        return HTTPHeaders.init(headers)
    }
    private func TimeInterval() -> String{
        let date = Date()
        let timeInterval = date.timeIntervalSince1970 * 1000
        return String(format: "%.0f", timeInterval)
    }
    //MAPK : MD5加密
    private func MD5Action(_ sender: Any, _ token: String)-> String {
        let strDic = (sender as! String) +  "&" + token +  "&" + "12345"
        let str = self.md5String(strDic)
        return str.uppercased()
    }
    private func md5String(_ str:String) -> String{
        let cStr = str.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
}

extension Bundle {
    static func appVersion() -> String {
        var versionStr = ""
        if let info = Bundle.main.infoDictionary {
            let appVersion = info["CFBundleShortVersionString"] as? String ?? "Unknown"
            let appBuild = info[kCFBundleVersionKey as String] as? String ?? "Unknown"
            versionStr = (appVersion == "Unknown") ? appVersion : appBuild
        }
        return versionStr
    }
}
