//
//  SWNetworkStruct.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


struct NetworkParamsStruct {
    var url: String = ""
    var dict = [String : Any]()
    var method = HTTPMethod.post
}
/// 数据解析成功后传递数据时用到的 Struct
/// 用法：success(SucceedParamsStruct.init(array: array, json: json))
/// 注:array或json不需要传递可以设置为nil, array设置为 nil,在遵守协议时不要强行解包
struct SucceedParamsStruct<T> {
    var array = [T]()
    var json: JSON = JSON()
}

/// 需要解析多个模型的用这个 Struct
/// 用法: success(SucceedMultiParamsStruct.init(array: [array, infoArray], json: json))
struct SucceedMultiParamsStruct<T> {
    var array = [[T]()]
    var json: JSON = JSON()
}
