# SWArchitecture
Swift Architecture for Application via MVP


https://github.com/cellgit/SWArchitecture/blob/master/img/darkmode.png


一. 使用:

- 网络请求前初始化 **Presenter**


``` 
/// 初始化 presenter
self.presenter = SWPresenter.init(model: HotkeyModel(), containerView: self)

/// 发起网络请求
func request() {
        let dict = ["":""]
        let url = APIManager.baseUrl + API.SKETCH
        print("url === \(url)")
        let params = NetworkParamsStruct.init(url: url, dict: dict, method: .post)
        self.presenter.request(params)
}
    
/// 实现协议
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
```




二. 介绍: 

- ***SWArchitecture*** 是通过 **MVP** 架构实现一个Sketch快捷键的列表项目
- 实现 **Alamofire** 的封装



三. MVP组成:

- M: Model
- V: View 或ViewController
- P: Presenter

四. MVP技术点:

- **V** 进行网络请求,然后通过两个协议(请求成功和请求失败)返回请求数据,进行展示数据
- **P** 通过使用泛型,实现整个项目调用同一类方法,这样我们就可以把更多时间用到数据解析和UI绘制上
- **M** 数据模型,负责解析数据,将请求json数据转化成模型数据


五. 协议: 项目中主要有两类协议: 

- 视图层协议 **ViewProtocol**
- 模型层协议 **ModelProtocal**



---
本项目旨在以最简单的方式实现**MVP**架构,并可以在实际生产中快速运用


