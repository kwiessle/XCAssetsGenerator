import Foundation
import AssetKit

extension AssetKit {
    
    private static func xcassetsFolder(named name: String) -> String {
        return "\(name).xcassets"
    }
    
    private static func colorsetFolder(named name: String) -> String {
        return "\(name).colorset"
    }
    
    
    static func generateXCAssetsFolder(named name: String, atPath path: String) throws -> URL {
        let xcassetsFolder = self.xcassetsFolder(named: name)
        let outputFolder = URL(fileURLWithPath: path).appendingPathComponent(xcassetsFolder
        )
        try self.createDirectoryIfNeeded(url: outputFolder)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try jsonEncoder.encode(Info.default)
        
        let jsonFile = outputFolder.appendingPathComponent("Contents.json")
        
        try data.write(to: jsonFile)
        return outputFolder
    }
    
    
    static func generateColor(hexString: String, named name: String, atPath path: String) throws {
        let colorSetFoler = self.colorsetFolder(named: name)
        
        let outputFolder = URL(fileURLWithPath: path).appendingPathComponent(colorSetFoler
        )
        try! self.createDirectoryIfNeeded(url: outputFolder)
        let jsonFile = outputFolder.appendingPathComponent("Contents.json")
        let data = colorSetTemplate(hexString: hexString).data(using: .utf8)
        try data!.write(to: jsonFile)
    }
    
    static func createDirectoryIfNeeded(url: URL) throws {
        var isDirectory: ObjCBool = false
        if !FileManager.default.fileExists(atPath: url.absoluteString, isDirectory: &isDirectory) {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
    }
}
