//
//  InterfaceService.swift
//  Voice_copy
//
//  Created by putao on 2022/6/13.
//

import Foundation
import Moya
import CryptoSwift
import Reachability
import UIKit

typealias RequestCompletion = (_ result: Result<[String: Any], InterfaceService.ServiceError>) -> Void

class InterfaceService {
    
    enum ServiceError: Error {
        enum RequestErrorType: Int {
            case duplicateRequest   = -2
            case unknownFormat      = -1    // 客户端转化错误
            case none               = 0     // 未发生错误
            case general            = 1     // 普通错误
            //            case bindPhone          = 2     // 需绑定手机
        }
        
        enum HttpErrorType: Int {
            case unknown        = -1
            case unauthorized   = 401 //未授权跳转登录
            case tokenerror   = 500 //账号错误
        }
        
        case requestError(type: RequestErrorType, message: String)
        case httpError(type: HttpErrorType)
    }
    
    // 单例
    static let shared = InterfaceService()
    
    // moya 网络请求
    private let provider = MoyaProvider<ServiceInterface>()
    
    // 请求方法
    // b66ac5bd1af02a9d006da02d330523c753cf5c9afea68b4d9075aecceb47ad0bf7e6a3853376bc922c10de84e6605e7b29aaec1c5f1c8124
    func request(interface: ServiceInterface, completion: RequestCompletion?) {
        provider.request(interface) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let resultDict = try JSONSerialization.jsonObject(with: moyaResponse.data, options: []) as? [String: Any]
                    if let resultDict = resultDict {
                        let resultStr = resultDict["data"] as? String
                        print(resultStr)
                        let desStr = resultStr?.desDecrypt(key: String("x2dkE4BYFWQOQ7gN".prefix(8)))
                        print(desStr)
                    } else {
                        print("error")
                    }
                } catch {
                    print("error")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

enum ServiceInterface {
    case appLink(packageName: String, appVersion: String)
}

extension ServiceInterface:  TargetType {
    // 基本路径
    var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://apiioshideapp.putaotec.com/ioshideapp")!
        }
    }
    // 路径
    var path: String {
        switch self {
        default:
            return "user/applink"
        }
    }
    // 请求方式
    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    // 封装请求数据
    var task: Task {
        var bodyParameters: [String: Any] = [:]
        switch self {
        case let .appLink(packageName, appVersion):
            bodyParameters["packageName"] = packageName
            bodyParameters["appVersion"] = appVersion
        }
        var parameters: [String: Any] = [:]
        let urlParameter: [String: Any] = globalParameter()
        
        
        var dataParameters: [String: Any] = [:]
        parameters["data"] = String(bodyParameters)
        parameters["query"] = String(urlParameter)
        let parametersString = String(parameters)
        
        dataParameters["data"] = parametersString.desEncrypt(key: String("x2dkE4BYFWQOQ7gN".prefix(8)))
        
        return .requestCompositeParameters(bodyParameters: dataParameters, bodyEncoding: JSONEncoding.default, urlParameters: [:])
    }
    
    // 请求头
    var headers: [String : String]? {
        return nil
    }
    
    func globalParameter() -> [String: Any] {
        var resultDict: [String : Any] = [:]
//        resultDict["mt"] = "iPhone10,3"
//        resultDict["sv"] = "15.4.1"
//        resultDict["tz"] = "8"
//        resultDict["ai"] = "74F438C2-C854-4DF4-89BD-BFE64840D0C5"
//        resultDict["pid"] = "5"
//        resultDict["av"] = "1.0.3"
//        resultDict["ns"] = 1
//        resultDict["bundleid"] = "com.lzn.voice"
//        resultDict["ts"] = "1655174313"
//        resultDict["cc"] = "CN"
//        resultDict["sng"] = "00d4acc1f5468d1c94e14117ed510a94"
//        resultDict["c"] = "appstore"
//        resultDict["idfa"] = "74F438C2-C854-4DF4-89BD-BFE64840D0C5"
//        resultDict["lan"] = "zh-Hans-CN"
//        resultDict["bvrs"] = "23"
        return resultDict
    }
}

