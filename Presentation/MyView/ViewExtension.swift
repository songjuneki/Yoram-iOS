//
//  ViewExtension.swift
//  Yoram
//
//  Created by 송준기 on 2022/09/19.
//

import Foundation
import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        let scenes = self.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        //        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window?.addGestureRecognizer(tapRecognizer)
    }
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_gestureRecognizer: UITapGestureRecognizer, shouldRecognizeSimultaneouslyWithotherRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}


extension String {
    func highlight(keyword: String) -> String {
        var changed = keyword
        changed.insert(contentsOf: "[", at: changed.startIndex)
        changed.append("](.)")
        return self.replacingOccurrences(of: keyword, with: changed)
    }
}

struct BlurView: UIViewRepresentable {
    typealias UIViewType = UIVisualEffectView
    
    let style: UIBlurEffect.Style
    
    init(style: UIBlurEffect.Style = .systemMaterial) { self.style = style }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}


extension UIImage {
    /// Average color of the image, nil if it cannot be found
    var averageColor: UIColor? {
        // convert our image to a Core Image Image
        guard let inputImage = CIImage(image: self) else { return nil }
        
        // Create an extent vector (a frame with width and height of our current input image)
        let extentVector = CIVector(x: inputImage.extent.origin.x,
                                    y: inputImage.extent.origin.y,
                                    z: inputImage.extent.size.width,
                                    w: inputImage.extent.size.height)
        
        // create a CIAreaAverage filter, this will allow us to pull the average color from the image later on
        guard let filter = CIFilter(name: "CIAreaAverage",
                                    parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        // A bitmap consisting of (r, g, b, a) value
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        
        // Render our output image into a 1 by 1 image supplying it our bitmap to update the values of (i.e the rgba of the 1 by 1 image will fill out bitmap array
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)
        
        // Convert our bitmap images of r, g, b, a to a UIColor
        return UIColor(red: CGFloat(bitmap[0]) / 255,
                       green: CGFloat(bitmap[1]) / 255,
                       blue: CGFloat(bitmap[2]) / 255,
                       alpha: CGFloat(bitmap[3]) / 255)
    }
}


extension Color {
    func toHex() -> String? {
        let uicolor = UIColor(self)
        guard let components = uicolor.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if a != Float(1.0) {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
    func isBrightness() -> Bool {
        let uicolor = UIColor(self)
//        guard let components = uicolor.cgColor.components, components.count >= 3 else { return nil }
//        let r = Float(components[0])
//        let g = Float(components[1])
//        let b = Float(components[2])
//        let a = Float(components[3])
        let r = Float(uicolor.cgColor.components?[0] ?? 0)
        let g = Float(uicolor.cgColor.components?[1] ?? 0)
        let b = Float(uicolor.cgColor.components?[2] ?? 0)
        let a = Float(uicolor.cgColor.components?[3] ?? 1)
        
        if a <= 0.5 {
            return true
        }
        
        let luma = ((r * 0.299) + (g * 0.587) + (b * 0.114))
        
        return luma >= 0.5
    }

}
