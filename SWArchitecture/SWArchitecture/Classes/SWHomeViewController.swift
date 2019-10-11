//
//  SWHomeViewController.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit


struct SWCellStruct {
    var id: String = "id"
    var title: String = "title"
    var image: String = "image"
}

enum SWHomeCellIdEnum: String {
    case mvp = "mvp"
    case mvvm = "mvvm"
    case unknown = "unknown"
}

class SWHomeViewController: UIViewController {
    let KUITableViewCell = "UITableViewCell"
    var tableView: UITableView!
    
    var datalist: [SWCellStruct]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Architecture"
        
        initData()
        self.setupUI()
    }
    
    func initData() {
        let data0 = SWCellStruct.init(id: SWHomeCellIdEnum.mvp.rawValue, title: SWHomeCellIdEnum.mvp.rawValue, image: "")
        let data1 = SWCellStruct.init(id: SWHomeCellIdEnum.mvvm.rawValue, title: SWHomeCellIdEnum.mvp.rawValue, image: "")
        let data2 = SWCellStruct.init(id: SWHomeCellIdEnum.mvp.rawValue, title: SWHomeCellIdEnum.mvp.rawValue, image: "")
        
        datalist = [data0,
                    data1,
                    data2]
    }
    
    func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView = UITableView.init(frame: self.view.frame, style: .plain)
        self.view.addSubview(tableView)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        let arrayM = [KUITableViewCell]
        for str in arrayM {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: str) // 纯代码注册
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SWHomeViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: KUITableViewCell, for: indexPath)
        cell.selectionStyle = .none
        /// 防止数组越界
        var id = ""
        if indexPath.row < datalist.count {
            id = datalist[indexPath.row].id
        }
        else {
            if let identifier = datalist.first?.id {
                id = identifier
            }
        }
        switch id {
        case SWHomeCellIdEnum.mvp.rawValue:
            cell.textLabel?.text = SWHomeCellIdEnum.mvp.rawValue
        case SWHomeCellIdEnum.mvvm.rawValue:
            cell.textLabel?.text = SWHomeCellIdEnum.mvvm.rawValue
        default:
            cell.textLabel?.text = SWHomeCellIdEnum.mvp.rawValue
        }
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        cell.textLabel?.textColor = .darkGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // push
//        let vc = SWMvpViewController.init()
//        vc.hidesBottomBarWhenPushed = true
//       self.navigationController?.pushViewController(vc, animated: true)
        
        // 带nav的presenter
//        let vc = SWMvpViewController()
//        vc.modalTransitionStyle = .coverVertical
//        let nc = UINavigationController.init(rootViewController: vc)
//        let appDelegate = UIApplication.shared.delegate
//        appDelegate?.window??.rootViewController?.definesPresentationContext = true
//        nc.modalPresentationStyle = .overCurrentContext
//        appDelegate?.window??.rootViewController?.present(nc, animated: true, completion: nil)
        
        
        // 不带nav的presenter,且iOS13顶部会留有空条
//        let vc = SWMvpViewController.init()
//        vc.modalTransitionStyle = .coverVertical
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: true, completion: nil)
        
        // 全部展示
//        let vc = SWMvpViewController.init()
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
        
//        let vc = SWMvpViewController.init()
        
        let id = datalist[indexPath.row].id
        
        switch id {
        case SWHomeCellIdEnum.mvp.rawValue:
            let vc = SWMvpViewController.init()
            vc.modalPresentationStyle = .automatic
            self.present(vc, animated: true, completion: nil)
        case SWHomeCellIdEnum.mvvm.rawValue:
            let vc = MvvmViewController.init()
            vc.modalPresentationStyle = .automatic
            self.present(vc, animated: true, completion: nil)
        default:
            let vc = SWMvpViewController.init()
            vc.modalPresentationStyle = .automatic
            self.present(vc, animated: true, completion: nil)
        }
        
        // 不带nav的presenter,iOS13顶部不会留有空条
//        let vc = SWMvpViewController.init()
//        let appDelegate = UIApplication.shared.delegate
//        appDelegate?.window??.rootViewController?.definesPresentationContext = true
//        vc.modalPresentationStyle = .overCurrentContext
//        appDelegate?.window??.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
