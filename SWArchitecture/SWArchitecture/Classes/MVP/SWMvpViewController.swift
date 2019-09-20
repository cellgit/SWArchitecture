//
//  SWMvpViewController.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit

class SWMvpViewController: UIViewController {
    
    var presenter: SWPresenter<HotkeyModel, SWMvpViewController>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.title = "MVP"
        
        setupUI()
        request()
    }
    
    func request() {
        let dict = ["":""]
        let url = APIManager.baseUrl + API.SKETCH
        print("url === \(url)")
        let params = NetworkParamsStruct.init(url: url, dict: dict, method: .post)
        self.presenter.request(params)
    }
    
    func setupUI() {
        self.presenter = SWPresenter.init(model: HotkeyModel(), containerView: self)
    }
}


extension SWMvpViewController: ViewProtocol {
    func display(data: SucceedParamsStruct<Any>) {
        //
        print("req succeed === \(data.json)")
    }
    func failure(failure: FailureStruct) {
        print("req failure ==== \(String(describing: failure.error))")
    }
}
