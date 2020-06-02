//
//  TCFileManager.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 6/1/20.
//

import Foundation

public protocol FileHandling {
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
    // zip
    // unzip
}

struct TCFileManager: FileHandling {
    func directoryURL(directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> URL? {
        if let dir = FileManager.default.urls(for: directory, in: domainMask).first {
            return dir
        }
        return nil
    }
    
    func getFileURL(fileName name: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> URL? {
        guard let directoryUrl = directoryURL(directory: directory, inDomainMask: domainMask) else {
            return nil
        }
        return directoryUrl.appendingPathComponent(name)
    }
    
    func isFileExist(fileName name: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> Bool {
        let fileURL = getFileURL(fileName: name, inDirectory: directory, inDomainMask: domainMask)

        guard let filePath = fileURL?.path else { return false }

        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: filePath) {
            return true
        } else {
            return false
        }
    }
    
    func readFile(fileName name: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> String? {
        guard let fileUrl = getFileURL(fileName: name, inDirectory: directory, inDomainMask: domainMask) else { return nil }

        do {
            let text = try String(contentsOf: fileUrl, encoding: .utf8)
            return text
        } catch {
            return nil
        }
    }
    
    func writeFile(fileName name: String, content: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) {
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
    
    func copyFile(file fromFile: String, toFile: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> Bool {
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
    
    func moveFile(fromPath: String, toPath: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> Bool {
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
    
    func deleteFile(atPath path: String, inDirectroy directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> Bool {
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
    
    func createDirectroy(atPath path: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> Bool {
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
    
    func listContent(inDirectoryName name: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> [String]? {
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
    
    func listContentURLs(inDirectoryName name: String, inDirectory directory: FileManager.SearchPathDirectory, inDomainMask domainMask: FileManager.SearchPathDomainMask) -> [URL]? {
        guard let content = listContent(inDirectoryName: name, inDirectory: directory, inDomainMask: domainMask) else { return nil }

        var contentUrls: [URL] = []
        for urlString in content {
            let url = URL(fileURLWithPath: urlString)
            contentUrls.append(url)
        }

        return (contentUrls.count > 0) ? contentUrls : nil
    }
}
