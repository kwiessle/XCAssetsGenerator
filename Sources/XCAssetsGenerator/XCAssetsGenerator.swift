import AssetKit
import AppKit
import Foundation
import Cocoa


#if DEBUG
let _argv_1 = "--appicon" // Path of appIcon.png
let _argv_2 = "/Users/kiefer/Desktop/Group40.png" // Path for all images -> xcassets
let _argv_3 = "/Users/kiefer/Desktop" // output path
let _argv_4 = ""
let _argc = 4
#else
let _argv_1 = CommandLine.arguments[1]
let _argv_2 = CommandLine.arguments[2]
let _argv_3 = CommandLine.arguments[3]
let _argv_4 = CommandLine.arguments[4]
let _argc = CommandLine.argc
#endif

enum XCAssetsGeneratorError: Error {
    case imageNotFoundAtPath(path: String)
    case unknownFlag(named: String)
    case invalidNumberOfParameters
    var message: String {
        
        switch self {
        case .imageNotFoundAtPath(let path):
            return "NOOOO '\(path)'"
        case .unknownFlag(let unknownFlag):
            return "invalid flag '\(unknownFlag)'"
        case .invalidNumberOfParameters:
            return self.usage
        }
    }
    
    private var usage: String { "Found \(_argc) attemps 4" }
}

enum Flag: String {
    
    case appIcon = "--appicon"
    case color  = "--color"
    case image = "--image"
    
    // ./executable --appicon ./input/path ./output/path
    // ./executable --image  ./input/path ./output/path name
    // ./executable --color  #012345 ./output/path name

    
    var requiredArguments: Int {
        switch self {
        case .appIcon:
            return 4
        case .color:
            return 5
        case .image:
            return 5
        }
    }
}




@main
public struct XCAssetsGenerator {
    
    
    private static func checkParameters() throws -> Flag {
        guard let flag = Flag(rawValue: _argv_1) else {
            throw XCAssetsGeneratorError.unknownFlag(named: _argv_1)
        }
        guard _argc == flag.requiredArguments else {
            throw XCAssetsGeneratorError.invalidNumberOfParameters
        }
        return flag
    }

    public static func main() {
        do {
            let flag = try self.checkParameters()
            let xcassetsFolder = try self.generateXCAssetsFolder(named: "Assets", atPath: _argv_3).absoluteString
            switch flag {
            case .appIcon:
                try self.generateAppIconSet(imagePath: _argv_2, outputPath: xcassetsFolder)
            case .color:
                try self.generateColorSet(hexString: _argv_2, named: _argv_4, outputPath: xcassetsFolder)
            case .image:
                try self.generateImageSet(imagePath: _argv_2, named: _argv_4, outputPath: xcassetsFolder)
            }
        } catch let error as XCAssetsGeneratorError {
            print(error.message)
            exit(EXIT_FAILURE)
        } catch {
            print(error.localizedDescription)
            exit(EXIT_FAILURE)
        }
    
    }
    
    @discardableResult
    public static func generateXCAssetsFolder(named name: String, atPath path: String) throws -> URL {
        return try AssetKit.generateXCAssetsFolder(named: name, atPath: path)
    }
    
    public static func generateAppIconSet(imagePath: String, outputPath: String) throws {
        let appIcon = try loadImage(atPath: imagePath)
        let safeIcon = flatAppIcon(appIcon)
        AssetKit.generateIconSet(input: safeIcon, outputPath: outputPath)
    }
    
    public static func generateImageSet(imagePath: String, named name: String, outputPath: String) throws {
        let image = try loadImage(atPath: imagePath)
        AssetKit.generateImageSet(input: image, filename: name, outputPath: outputPath)
    }
    
    public static func generateColorSet(hexString: String, named name: String, outputPath: String) throws {
        try AssetKit.generateColor(hexString: hexString, named: name, atPath: outputPath)
    }
    
    private static func loadImage(atPath path: String) throws -> NSImage {
        guard let image = NSImage(contentsOf: URL(filePath: path)) else {
            throw XCAssetsGeneratorError.imageNotFoundAtPath(path: path)
        }
        return image
    }
    
    private static func flatAppIcon(_ image: NSImage) -> NSImage {
        var rect = NSRect(origin: .zero, size: .init(width: 1024, height: 1024))
        let resized = image.resize(withSize: rect.size)!
        let cgImage = resized.cgImage(forProposedRect: &rect, context: nil, hints: nil)!
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])!
        return NSImage(data: jpegData)!
    }
    
   
    
   
}









