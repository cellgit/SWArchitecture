//
//  SWNetworkProtocol.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import Foundation

/// 显示视图的协议: 数据请求成功后，通过此协议传递请求的数据，然后再视图显示
/*
 用法：
 1. presenter的请求成功的回调处: self.view.showView(data: data)
 2. view 的 extension 中遵守 ZSViewProtocol
 3. view 协议方法内获取数据 let array = data.array as! [Model] 或 let json = data.json
 */
protocol ViewProtocol {
    func display(data: SucceedParamsStruct<Any>)
    
    func failure (failure: FailureStruct)
}
/// 显示视图的协议: 如果同一个View已经使用了 ViewProtocol, 则再次使用展示协议时用 ZSViewSecondProtocol ... ...
protocol ViewSecondProtocol {
    func displaySecond(data: SucceedParamsStruct<Any>)
    func failureSecond (failure: FailureStruct)
}
protocol ViewThirdProtocol {
    func displayThird(data: SucceedParamsStruct<Any>)
    func failureThird (failure: FailureStruct)
}
protocol ViewFourthProtocol {
    func displayFourth(data: SucceedParamsStruct<Any>)
    func failureFourth (failure: FailureStruct)
}
protocol ViewFifthProtocol {
    func displayFifth(data: SucceedParamsStruct<Any>)
    func failureFifth (failure: FailureStruct)
}
protocol ViewSixthProtocol {
    func displaySixth(data: SucceedParamsStruct<Any>)
    func failureSixth (failure: FailureStruct)
}
protocol ViewSeventhProtocol {
    func displaySeventh(data: SucceedParamsStruct<Any>)
    func failureSeventh (failure: FailureStruct)
}

/// 不需要解析的数据用此协议,通过设置标识符区分即可服用presenter
protocol ViewUnparseProtocol {
    func displayUnparse(data: SucceedParamsStruct<Any>)
}

