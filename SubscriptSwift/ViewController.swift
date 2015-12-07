//
//  ViewController.swift
//  DictionaryKey
//
//  Created by Limon on 15/12/7.
//  Copyright © 2015年 EvernoteSimple. All rights reserved.
//

import UIKit

var accountSet = Set<Account>()

let dictionaryOne = [
        MyDictionaryKeys.Name.rawValue: "Limon",
        MyDictionaryKeys.Age.rawValue: Int(18)
]

let dictionaryTwo = [DictionaryKeys.userIDKey.value: "3148"] as NSDictionary

class ViewController: UIViewController {


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // 样式一
        let name = dictionaryOne[.Name]!
        let age = dictionaryOne[.Age]!

        print("样式一、name: \(name) age: \(age)")


        // 样式二
        let userID = dictionaryTwo[.userIDKey]!

        print("样式二、\(userID)")


        // 样式三
        let qqAccount = accountSet[.QQ]
        let weChatAccount = accountSet[.WeChat]

        print("样式三、qqAppID: \(qqAccount!.appID) weChatAppID: \(weChatAccount!.appID)")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        accountSet.insert(Account.QQ(appID: "qq43243279402"))
        accountSet.insert(Account.WeChat(appID: "wx79873294002"))
    }
}


// MARK: 样式一

enum MyDictionaryKeys: String {
    case Name
    case Age
}

extension Dictionary {

    subscript(customKey: MyDictionaryKeys) -> AnyObject? {

        guard let key = customKey.rawValue as? Key else {
            return nil
        }

        for (k, value) in self {
            if key == k {
                return value as? String
            }
        }

        return nil
    }
}

extension NSDictionary {

    subscript(customKey: MyDictionaryKeys) -> AnyObject? {
        return objectForKey(customKey.rawValue)
    }
}


// MARK: 样式二

enum OAuthPlatform: String {
    case QQ
    case WeChat
}

extension Set {

    subscript(platform: OAuthPlatform) -> Account? {

        switch platform {

        case .WeChat:
            for account in accountSet {
                if case .WeChat = account {
                    return account
                }
            }
        case .QQ:
            for account in accountSet {
                if case .QQ = account {
                    return account
                }
            }
        }

        return nil
    }
}


func ==(lhs: Account, rhs: Account) -> Bool {
    return lhs.appID == rhs.appID
}

enum Account: Hashable {

    case WeChat(appID: String)
    case QQ(appID: String)

    var appID: String {
        switch self {
        case .WeChat(let appID):
            return appID
        case .QQ(let appID):
            return appID
        }
    }

    var hashValue: Int {
        return appID.hashValue
    }
}


// MARK: 样式三

extension NSDictionary {

    subscript(key: DictionaryKey<String?>) -> String? {
        get { return objectForKey(key.value) as? String }
    }

    subscript(key: DictionaryKey<Int?>) -> Int? {
        get { return objectForKey(key.value) as? Int }
    }
}

extension DictionaryKeys {
    static let userIDKey = DictionaryKey<String?>("userID")
}

class DictionaryKeys {
    private init() {}
}

class DictionaryKey<ValueType>: DictionaryKeys {
    
    let value: String
    
    init(_ key: String) {
        self.value = key
    }
}






