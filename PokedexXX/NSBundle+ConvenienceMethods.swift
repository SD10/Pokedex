//
//  NSBundle+ConvenienceMethods.swift
//  PokedexXX
//
//  Created by Martin Wildfeuer on 24.04.16.
//  Copyright © 2016 steven. All rights reserved.
//

import Foundation

// MARK: Convenience Methods

extension NSBundle {
    static func retrieveFilePath(name: String, format: String) throws -> String {
        guard let path = self.mainBundle().pathForResource(name, ofType: format) else {
            throw FilePathError.UnableRetrievePath("\(name).\(format)")
        }
        return path
    }
}

// MARK: ErrorTypes

enum FilePathError: ErrorType {
    case UnableRetrievePath(String)
    case UnableCreateURL
}