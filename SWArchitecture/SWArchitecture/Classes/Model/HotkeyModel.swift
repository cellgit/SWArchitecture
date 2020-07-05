//
//  HotkeyModel.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import Foundation
import SwiftyJSON

struct HotkeyModel: Decodable {
    /// id
    var id: String = ""
    /// 快捷键
    var hotkey: String = ""
    /// 功能描述
    var function: String = ""
}

