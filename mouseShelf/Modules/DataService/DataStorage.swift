//
//  DataStorage.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Foundation

final class DataStorageService {
    
    static let instanse = DataStorageService()
    
    func fetchUserRootCatalog() -> URL? {
        guard let rootCatalogURL = UserDefaults.standard.value(forKey: "com.user.rootCatalog") as? URL else {
            return nil
        }
        return rootCatalogURL
    }
    
    func setUserRootCatalog(with url: URL) {
        UserDefaults.standard.set(url, forKey: "com.user.rootCatalog")
    }
}
