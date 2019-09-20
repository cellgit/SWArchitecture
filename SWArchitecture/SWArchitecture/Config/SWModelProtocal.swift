//
//  SWModelProtocal.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//
import UIKit
import Foundation


protocol ModelProtocal {
    func requestData(params: NetworkParamsStruct, isEncrypting: Bool, success: @escaping SucceedTypealias, failure:@escaping ReqFailure)
}
protocol ModelSecondProtocal {
    func requestSecondData(params: NetworkParamsStruct, isEncrypting: Bool, success: @escaping SucceedTypealias, failure:@escaping ReqFailure)
}


protocol MultiModelProtocal {
    func requestData(params: NetworkParamsStruct, isEncrypting: Bool, success: @escaping SucceedMultiTypealias, failure:@escaping ReqFailure)
}

/// 模型的协议
protocol UploadImageModelProtocal {
    func requestData(params: NetworkParamsStruct, imgParams: [UIImage], isEncrypting: Bool, success: @escaping SucceedTypealias, failure:@escaping FailureTypealias)
}

