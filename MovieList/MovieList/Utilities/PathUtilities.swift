//
//  PathUtilities.swift
//  MovieList
//
//  Created by ITRMG on 2017-20-12.
//  Copyright © 2016 Vasthimal, Deepesh : @djrecker. All rights reserved.
//

import Foundation

typealias JSONDict = [String: AnyObject]
typealias JSONDicts = [JSONDict]

class PathUtilities {
    static func find(_ resourceNamed: String, ofType type: String ) -> Data? {
        if let path = Bundle.main.path(forResource: resourceNamed, ofType: type) {
            do {
                let jsonData = try Data(contentsOf:
                    URL(fileURLWithPath: path),
                                        options: NSData.ReadingOptions.mappedIfSafe)
                return jsonData
            } catch {}
        }
        return nil
    }
    static func findJSON(_ resourceNamed: String) -> JSONDict? {
        if let jsonData = self.find(resourceNamed, ofType: "json") {
            do {
                if let jsonResult: JSONDict = try JSONSerialization.jsonObject(with:
                    jsonData, options: JSONSerialization.ReadingOptions(rawValue: 0))
                    as? JSONDict { return jsonResult }
            } catch {}
        }
        return nil
    }
}
