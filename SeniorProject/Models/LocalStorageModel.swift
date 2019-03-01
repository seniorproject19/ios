//
//  LocalStorageModel.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 2/7/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit

protocol LocalStorageModel {
    
    func storeCookies(cookies: [HTTPCookie]?)
    func retrieveCookies() -> [HTTPCookie]?
    func restoreCookies()

}

extension LocalStorageModel {
    
    func storeCookies(cookies: [HTTPCookie]?) {
        if let cookies = cookies {
            let data = NSKeyedArchiver.archivedData(withRootObject: cookies)
            UserDefaults.standard.set(data, forKey: "Cookies")
            UserDefaults.standard.synchronize()
        }
    }
    
    func retrieveCookies() -> [HTTPCookie]? {
        let cookiesData = UserDefaults.standard.object(forKey: "Cookies") as! Data
        if cookiesData.count > 0 {
            let cookies = NSKeyedUnarchiver.unarchiveObject(with: cookiesData) as! [HTTPCookie]
            return cookies
            
        }
        return nil
    }
    
    func restoreCookies() {
        if let cookies = retrieveCookies() {
            for cookie in cookies {
                HTTPCookieStorage.shared.setCookie(cookie)
            }
        }
    }
    
}
