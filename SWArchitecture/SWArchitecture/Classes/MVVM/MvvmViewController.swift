//
//  MvvmViewController.swift
//  SWArchitecture
//
//  Created by Alan on 2019/10/11.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit

class MvvmViewController: UIViewController {
    
    let KHotkeyCell = "HotkeyCell"
    var tableView: UITableView!
    var datalist = [HotkeyModel]()
    
    var viewModel: HotkeysViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shortcut Key"
        self.viewModel = HotkeysViewModel.init()
        setupUI()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.isRefreshing = { loading in
//            UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        }
        
        let dict = ["":""]
        let url = APIManager.baseUrl + API.SKETCH
        print("url === \(url)")
        let params = NetworkParamsStruct.init(url: url, dict: dict, method: .post)
        viewModel.ready(params: params)
        viewModel.requestSucceed = { [weak self] data in
            guard let strongSelf = self else { return }
            print("req succeed === \(data.json)")
            strongSelf.datalist = data.array as! [HotkeyModel]
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
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

extension MvvmViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datalist.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idx = indexPath.section
        if idx > datalist.count - 1 {
            return UITableViewCell()
        }
        let cell: HotkeyCell = tableView.dequeueReusableCell(withIdentifier: KHotkeyCell, for: indexPath) as! HotkeyCell
        cell.selectionStyle = .none
        cell.model = datalist[idx]
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

extension MvvmViewController: ViewProtocol {
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
