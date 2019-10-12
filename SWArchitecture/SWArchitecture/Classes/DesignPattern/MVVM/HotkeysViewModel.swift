//
//  HotkeysViewModel.swift
//  SWArchitecture
//
//  Created by Alan on 2019/10/11.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotkeysViewModel: ModelProtocal {
    
     //Outputs
    var isRefreshing: ((Bool) -> Void)?
    var requestSucceed: SucceedTypealias?
    
    // Inputs
    func ready(params: NetworkParamsStruct) {
        isRefreshing?(false)
        self.requestData(params: params, isEncrypting: true, success: { [weak self](data) in
            guard let strongSelf  = self else { return }
            strongSelf.isRefreshing?(true)
        }) { [weak self](failure) in
            guard let strongSelf  = self else { return }
            strongSelf.isRefreshing?(true)
        }
    }
    
    func requestData(params: NetworkParamsStruct, isEncrypting: Bool, success: @escaping SucceedTypealias, failure: @escaping ReqFailure) {
        HttpManager.shared.request(method: params.method, path: params.url, parameters: params.dict, isEncrypting: isEncrypting, success: { [weak self] (response) in
            
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
            guard let strongSelf  = self else { return }
            strongSelf.requestSucceed?(SucceedParamsStruct.init(array: array, json: json))
        }) { (error) in
        }
    }
}
