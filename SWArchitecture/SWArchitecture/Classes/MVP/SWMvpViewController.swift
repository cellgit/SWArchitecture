//
//  SWMvpViewController.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit

class SWMvpViewController: UIViewController {
    let KHotkeyCell = "HotkeyCell"
    var tableView: UITableView!
    var datalist = [HotkeyModel]()
    
    var presenter: SWPresenter<HotkeyModel, SWMvpViewController>!

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
//            self.view.backgroundColor = .secondarySystemBackground
        } else {
            // Fallback on earlier versions
        }
        
        self.title = "MVP"
        self.presenter = SWPresenter.init(model: HotkeyModel(), containerView: self)
        
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
        tableView = UITableView.init(frame: self.view.frame, style: .grouped)
        self.view.addSubview(tableView)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        let arrayM = [KHotkeyCell]
        for str in arrayM {
            tableView!.register(UINib(nibName:str, bundle:nil), forCellReuseIdentifier:str)
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SWMvpViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datalist.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section > datalist.count - 1 {
            return UITableViewCell()
        }
        let cell: HotkeyCell = tableView.dequeueReusableCell(withIdentifier: KHotkeyCell, for: indexPath) as! HotkeyCell
        cell.selectionStyle = .none
        cell.model = datalist[indexPath.section]
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

extension SWMvpViewController: ViewProtocol {
    func display(data: SucceedParamsStruct<Any>) {
        print("req succeed === \(data.json)")
        self.datalist = data.array as! [HotkeyModel]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func failure(failure: FailureStruct) {
        print("req failure ==== \(String(describing: failure.error))")
    }
}


