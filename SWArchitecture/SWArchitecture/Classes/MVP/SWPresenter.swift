//
//  SWPresenter.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit
import Foundation

/// M: model, V: view或者vc
class SWPresenter<M: ModelProtocal, V: ViewProtocol>: NSObject {
    var model: M!
    var containerView: V!
    
    override init() {
        super.init()
    }
    convenience init(model: M, containerView: V) {
        self.init()
        self.model = model
        self.containerView = containerView
    }
    func request(_ params: NetworkParamsStruct) {
        self.model.requestData(params: params, isEncrypting: true, success: { (data) in
            self.containerView.display(data: data)
        }) { failure  in
            print("数据请求失败error===\(String(describing: failure.error))")
            self.containerView.failure(failure: failure)
        }
    }
}

/// M: model, V: view或者vc
//class AIPresenter<M: ModelProtocal, V: ViewProtocol>: NSObject {
//    var model: M!
//    var containerView: V!
//
//    override init() {
//        super.init()
//    }
//    convenience init(model: M, containerView: V) {
//        self.init()
//        self.model = model
//        self.containerView = containerView
//    }
//    func gotoRequestData(params: NetworkParamsStruct) {
//        self.model.requestData(params: params, isEncrypting: true, success: { (data) in
//            self.containerView.display(data: data)
//        }) { failure  in
//            print("数据请求失败error===\(String(describing: failure.error))")
//            self.containerView.failure(failure: failure)
//        }
//    }
//}

/// M: model, V: view或者vc
class AIPresenterSecond<M: ModelProtocal, V: ViewSecondProtocol>: NSObject {
    var model: M!
    var containerView: V!
    
    override init() {
        super.init()
    }
    convenience init(model: M, containerView: V) {
        self.init()
        self.model = model
        self.containerView = containerView
    }
    func request(_ params: NetworkParamsStruct) {
        self.model.requestData(params: params, isEncrypting: true, success: { (data) in
            self.containerView.displaySecond(data: data)
        }) { failure  in
            print("数据请求失败error===\(String(describing: failure.error))")
            //            self.containerView.failure(failure: failure)
            self.containerView.failureSecond(failure: failure)
        }
    }
}


//class AIPresenter2: NSObject {
//    var model: ModelProtocal!
//    var containerView: ExampleBaseContainer!
//    override init() {
//        super.init()
//    }
//    convenience init(model: ExampleModel, containerView: ExampleBaseContainer) {
//        self.init()
//        self.model = model
//        self.containerView = containerView
//    }
//    func gotoRequestData(params: NetworkParamsStruct) {
//        self.model.requestData(params: params, isEncrypting: true, success: { (data) in
//            self.containerView.display(data: data)
//
//        }) { failure  in
//            print("数据请求失败error===\(String(describing: failure.error))")
//            self.containerView.failure(failure: failure)
//        }
//    }
//}
