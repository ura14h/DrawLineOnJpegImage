import UIKit

let image = UIImage(named: "sample.jpg")
let imageData = image!.cgImage!.dataProvider!.data!
let width = image!.cgImage!.width
let height = image!.cgImage!.height
let colorSpace = image!.cgImage!.colorSpace!
let bitmapInfo = image!.cgImage!.bitmapInfo
let bitsPerComponent = image!.cgImage!.bitsPerComponent
let bitsPerPixel = image!.cgImage!.bitsPerPixel
let bytesPerRow = image!.cgImage!.bytesPerRow

let dataLength = CFDataGetLength(imageData)
let dataPointer = CFDataGetBytePtr(imageData)!
let provider = CGDataProvider(dataInfo: nil, data: dataPointer, size: dataLength, releaseData: { (info: UnsafeMutableRawPointer?, data: UnsafeRawPointer, size: Int) -> Void in
})!
let cgimage = CGImage(width: width, height: height, bitsPerComponent: bitsPerComponent, bitsPerPixel: bitsPerPixel, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo, provider: provider, decode: nil, shouldInterpolate: false, intent: .defaultIntent)!

UIGraphicsBeginImageContext(CGSize(width: width, height: height))
let context = UIGraphicsGetCurrentContext()!

context.saveGState()
context.translateBy(x: 0, y: CGFloat(height))
context.scaleBy(x: 1.0, y: -1.0)
context.draw(cgimage, in: CGRect(x: 0, y: 0, width: width, height: height))
context.restoreGState()
context.saveGState()
context.setStrokeColor(red: 1, green: 1, blue: 1, alpha: 1)
context.setLineWidth(10)
context.move(to: CGPoint(x: 0, y: 0))
context.addLine(to: CGPoint(x: width, y: height))
context.strokePath()
context.move(to: CGPoint(x: width, y: 0))
context.addLine(to: CGPoint(x: 0, y: height))
context.strokePath()
context.restoreGState()

let editedImage = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
