//
//  String+Extensions.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import Foundation
import UIKit

// MARK: - String Validation Extensions
extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&_])[A-Za-z\\d$@$!%*?&_]{14,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    func isValidMobile(limits: String = "9,10") -> Bool {
        let regex = "^[0-9]{\(limits)}$"
        return self.range(of: regex, options: .regularExpression) != nil
    }
    
    var isValidURL: Bool {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let range = NSRange(location: 0, length: self.utf16.count)
        let match = detector?.firstMatch(in: self, options: [], range: range)
        return match?.range.length == self.utf16.count
    }
}

// MARK: - UI & Attributed String Extensions
extension String {
    
    /// Returns an attributed string with a strike-through line.
    func strikeThrough(color: UIColor = .label) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: color
        ])
    }
    
    /// Converts HTML string to NSAttributedString for rendering in Labels/TextViews.
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf16) else { return nil }
        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }
    
    /// Calculates the required height for a string given a fixed width and font.
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }
}

// MARK: - Base64 Image Conversion
extension String {
    /// Converts a Base64 string to a UIImage.
    func toImage() -> UIImage? {
        guard let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else { return nil }
        return UIImage(data: data)
    }
}

extension UIImage {
    /// Converts UIImage to a Base64 encoded string (JPEG format).
    func toJpegBase64(quality: CGFloat = 0.8) -> String? {
        return self.jpegData(compressionQuality: quality)?.base64EncodedString()
    }
}
