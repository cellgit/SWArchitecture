//
//  HotkeyModel.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import Foundation
import SwiftyJSON

struct HotkeyModel {
    /// id
    var id: String = ""
    /// 快捷键
    var hotkey: String = ""
    /// 功能描述
    var function: String = ""
}

extension HotkeyModel : ModelProtocal {
    func requestData(params: NetworkParamsStruct, isEncrypting: Bool, success: @escaping SucceedTypealias, failure: @escaping ReqFailure){
        
        HttpManager.shared.request(method: params.method, path: params.url, parameters: params.dict, isEncrypting: isEncrypting, success: { (response) in
            
            let json = JSON(response!)
            print("json ======= \(json)")
            var array = [HotkeyModel]()
            let dataArray = json.arrayValue
            for item in dataArray {
                var model = HotkeyModel()
                model.id = item["id"].stringValue
                model.hotkey = item["hotkey"].stringValue
                model.function = item["function"].stringValue
                array.append(model)
            }
            success(SucceedParamsStruct.init(array: array, json: json))
            
        }) { (error) in
        }
    }
}

