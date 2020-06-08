//
//  TCFileManager.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/1/20.
//

import Foundation
import SwiftyJSON

public typealias TCJSON = JSON

public protocol FileHandling {
    func documentDirectroy() -> URL?
    func directoryURL(directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> URL?
    func getFileURL(fileName name: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> URL?
    func isFileExist(fileName name: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> Bool
    func readFile(fileName name: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> String?
    func writeFile(fileName name: String, content: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask)
    func copyFile(file fromFile: String, toFile: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> Bool
    func moveFile(fromPath: String, toPath: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> Bool
    func deleteFile(atPath path: String, inDirectroy directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> Bool
    func createDirectroy(atPath path: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> Bool
    func listContent(inDirectoryName name: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> [String]?
    func listContentURLs(inDirectoryName name: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> [URL]?
    func createZipFile(atPath path: String, withContentsOfDirectory contentDirectoryPath: String)
    func unzipFile(atPath path: String, toDestination destinationPath: String, withCompletion completion:((String, Bool, Error?) -> Void)?)
    func createZipFile(atPath path: String, withContentsOfDirectory contentDirectoryPath: String, password: String)
    func unzipFile(atPath path: String, toDestination destinationPath: String, password: String, withCompletion completion:((String, Bool, Error?) -> Void)?)
    func isFilePasswordProtected(_ filePath: String) -> Bool
    func readPlist(name: String) -> [String: AnyObject]?
    func readJSON(fileName: String) -> TCJSON?
}

struct TCFileManager: FileHandling {
    func documentDirectroy() -> URL? {
        return directoryURL()
    }

    func directoryURL(directory: FileManager.SearchPathDirectory = .documentDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask = .userDomainMask) -> URL? {
        if let dir = FileManager.default.urls(for: directory, in: domainMask).first {
            return dir
        }
        return nil
    }

    func getFileURL(fileName name: String, inDirectory directory: FileManager.SearchPathDirectory = .documentDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask = .userDomainMask) -> URL? {
        guard let directoryUrl = directoryURL(directory: directory, inDomainMask: domainMask) else {
            return nil
        }
        return directoryUrl.appendingPathComponent(name)
    }
    
    func isFileExist(fileName name: String, inDirectory directory: FileManager.SearchPathDirectory = .documentDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask = .userDomainMask) -> Bool {
        let fileURL = getFileURL(fileName: name, inDirectory: directory, inDomainMask: domainMask)

        guard let filePath = fileURL?.path else { return false }

        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: filePath) {
            return true
        } else {
            return false
        }
    }
    
    func readFile(fileName name: String, inDirectory directory: FileManager.SearchPathDirectory = .documentDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask = .userDomainMask) -> String? {
        guard let fileUrl = getFileURL(fileName: name, inDirectory: directory, inDomainMask: domainMask) else { return nil }

        do {
            let text = try String(contentsOf: fileUrl, encoding: .utf8)
            return text
        } catch {
            return nil
        }
    }
    
    func writeFile(fileName name: String, content: String, inDirectory directory: FileManager.SearchPathDirectory = .documentDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask = .userDomainMask) {
        guard let fileUrl = getFileURL(fileName: name, inDirectory: directory, inDomainMask: domainMask) else {
            App.managers.logger.error(message: "cant write content to a nil filepath.")
            return
        }

        do {
            try content.write(to: fileUrl, atomically: false, encoding: .utf8)
        } catch {
            App.managers.logger.error(message: "cant write content to \(fileUrl.path)")
        }
    }
    
    func copyFile(file fromFile: String, toFile: String, inDirectory directory: FileManager.SearchPathDirectory = .documentDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask = .userDomainMask) -> Bool {
        guard let directoryUrl = directoryURL(directory: directory, inDomainMask: domainMask) else { return false }
        
        let originalFile = directoryUrl.appendingPathComponent(fromFile)
        let copyFile = directoryUrl.appendingPathComponent(toFile)

        let fileManager = FileManager.default
        do {
            try fileManager.copyItem(at: originalFile, to: copyFile)
            return true
        } catch {
            App.managers.logger.error(message: "can't copy \(fromFile) to \(toFile)")
            return false
        }
    }
    
    func moveFile(fromPath: String, toPath: String, inDirectory directory: FileManager.SearchPathDirectory = .documentDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask = .userDomainMask) -> Bool {
        guard let directoryUrl = directoryURL(directory: directory, inDomainMask: domainMask) else { return false }

        let oldPath = directoryUrl.appendingPathComponent(fromPath)
        let newPath = directoryUrl.appendingPathComponent(toPath)

        let fileManager = FileManager.default
        do {
            try fileManager.moveItem(at: oldPath, to: newPath)
            return true
        } catch {
            App.managers.logger.error(message: "can't move \(fromPath) to \(toPath)")
            return false
        }
    }
    
    func deleteFile(atPath path: String, inDirectroy directory: FileManager.SearchPathDirectory = .documentDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask = .userDomainMask) -> Bool {
        guard let fileUrl = getFileURL(fileName: path, inDirectory: directory, inDomainMask: domainMask) else { return false }

        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: fileUrl)
            return true
        } catch {
            App.managers.logger.error(message: "cant remove file \(path)")
            return false
        }
    }
    
    func createDirectroy(atPath path: String, inDirectory directory: FileManager.SearchPathDirectory = .documentDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask = .userDomainMask) -> Bool {
        guard let directoryUrl = directoryURL(directory: directory, inDomainMask: domainMask) else { return false }

        let newDirectoryUrl = directoryUrl.appendingPathComponent(path)
        do {
            try FileManager.default.createDirectory(atPath: newDirectoryUrl.path, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch let error as NSError {
            App.managers.logger.error(message: "Unable to create directory \(path). Error: \(error.localizedDescription)")
            return false
        }
    }
    
    func listContent(inDirectoryName name: String, inDirectory directory: FileManager.SearchPathDirectory = .documentDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask = .userDomainMask) -> [String]? {
        guard let directoryUrl = directoryURL(directory: directory, inDomainMask: domainMask) else { return nil }

        let newDirectoryUrl = directoryUrl.appendingPathComponent(name)
        do {
            let contentPaths = try FileManager.default.contentsOfDirectory(atPath: newDirectoryUrl.path)
            return contentPaths
        } catch let error as NSError {
            App.managers.logger.error(message: error.localizedDescription)
            return nil
        }
    }
    
    func listContentURLs(inDirectoryName name: String, inDirectory directory: FileManager.SearchPathDirectory = .documentDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask = .userDomainMask) -> [URL]? {
        guard let content = listContent(inDirectoryName: name, inDirectory: directory, inDomainMask: domainMask) else { return nil }

        var contentUrls: [URL] = []
        for urlString in content {
            let url = URL(fileURLWithPath: urlString)
            contentUrls.append(url)
        }

        return (contentUrls.count > 0) ? contentUrls : nil
    }

    func createZipFile(atPath path: String, withContentsOfDirectory contentDirectoryPath: String) {
        App.services.zip.createZipFile(atPath: path, withContentsOfDirectory: contentDirectoryPath)
    }

    func unzipFile(atPath path: String, toDestination destinationPath: String, withCompletion completion:((String, Bool, Error?) -> Void)?) {
        App.services.zip.unzipFile(atPath: path, toDestination: destinationPath, withCompletion: completion)
    }

    func createZipFile(atPath path: String, withContentsOfDirectory contentDirectoryPath: String, password: String) {
        App.services.zip.createZipFile(atPath: path, withContentsOfDirectory: contentDirectoryPath, password: password)
    }

    func unzipFile(atPath path: String, toDestination destinationPath: String, password: String, withCompletion completion:((String, Bool, Error?) -> Void)?) {
        App.services.zip.unzipFile(atPath: path, toDestination: destinationPath, password: password, withCompletion: completion)
    }

    func isFilePasswordProtected(_ filePath: String) -> Bool {
        return App.services.zip.isFilePasswordProtected(filePath)
    }

    func readPlist(name: String) -> [String: AnyObject]? {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
        guard let plistPath = Bundle.main.path(forResource: name, ofType: "plist") else { return nil }
        guard let plistXML = FileManager.default.contents(atPath: plistPath) else { return nil }
        do {
            let plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            return plistData
        } catch {
            App.managers.logger.error(message: "Error reading plist: \(error), format: \(propertyListFormat)")
            return nil
        }
    }

    func readJSON(fileName: String) -> TCJSON? {
        var json: TCJSON?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSON(data: data)
            } catch {
                App.managers.logger.error(message: "Error reading json file: \(error.localizedDescription), format: json")
            }
        }
        return json
    }

}
