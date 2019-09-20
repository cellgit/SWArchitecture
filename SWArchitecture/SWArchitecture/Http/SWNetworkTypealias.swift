//
//  SWNetworkTypealias.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias SucceedTypealias = (_ model: SucceedParamsStruct<Any>) -> Void
typealias FailureTypealias = (_ json : JSON) -> Void

typealias SucceedMultiTypealias = (_ model: SucceedMultiParamsStruct<Any>) -> Void
