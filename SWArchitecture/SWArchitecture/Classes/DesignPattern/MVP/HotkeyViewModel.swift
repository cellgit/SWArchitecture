//
//  HotkeyViewModel.swift
//  SWArchitecture
//
//  Created by Alan on 2019/10/11.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotkeyViewModel: ModelProtocal {
    func requestData(params: NetworkParamsStruct, isEncrypting: Bool, success: @escaping SucceedTypealias, failure: @escaping ReqFailure) {
        HttpManager.shared.request(method: params.method, path: params.url, parameters: params.dict, isEncrypting: isEncrypting, success: { (response) in
            
            let json = JSON(response!)
            print("json view model======= \(json)")
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
