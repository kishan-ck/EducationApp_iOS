//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import UIKit

//MARK: - UILabel setup
extension UILabel {
    
    /// Set font  as per below name that will replace any font with this name
    ///
    ///   English Font
    ///   1. PlayfairDisplay-Bold
    ///   2. Manrope-Medium
    ///   3. Manrope-SemiBold
    @IBInspectable var isApplyFont: Bool {
        get {
            return self.isApplyFont
        }
        set {
            self.isApplyFont = newValue
            if getLangCode() == "ar" {
                //TODO: - Apply font here for arabic
                
            }else{
                //TODO: - Change system font here
            }
        }
    }
    
    
    /// Font style for all UILabel
    @IBInspectable var style: String {
        set {
            self.font = UIFont(name: (allFont [newValue]?["name"] ?? "Manrope-Regular"), size: self.font.pointSize)
        }
        get {
            return ""
        }
    }
}

/// Enum for trailing content label
enum TrailingContent {
    case readmore
    case readless
    
    var text: String {
        switch self {
        case .readmore: return "...Read More"
        case .readless: return " Read Less"
        }
    }
}

/// Setup for uilabel add and less more text adding into the text.
extension UILabel {

    private var minimumLines: Int { return 5 }
    private var highlightColor: UIColor { return UIColor(named: "ThemeYellow - #E2A12D")! }

    private var attributes: [NSAttributedString.Key: Any] {
        return [.font: self.font ?? themeFont(size: 14, fontname: .poppinsRegular)]
    }
    
    public func requiredHeight(for text: String) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = minimumLines
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
      }

    func highlight(_ text: String, color: UIColor) {
        guard let labelText = self.text else { return }
        let range = (labelText as NSString).range(of: text)

        let mutableAttributedString = NSMutableAttributedString.init(string: labelText)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.attributedText = mutableAttributedString
    }

    func appendReadmore(after text: String, trailingContent: TrailingContent) {
        self.numberOfLines = minimumLines
        let fourLineText = "\n\n\n"
        let fourlineHeight = requiredHeight(for: fourLineText)
        let sentenceText = NSString(string: text)
        let sentenceRange = NSRange(location: 0, length: sentenceText.length)
        var truncatedSentence: NSString = sentenceText
        var endIndex: Int = sentenceRange.upperBound
        let size: CGSize = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        while truncatedSentence.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size.height >= fourlineHeight {
            if endIndex == 0 {
                break
            }
            endIndex -= 1

            truncatedSentence = NSString(string: sentenceText.substring(with: NSRange(location: 0, length: endIndex)))
            truncatedSentence = (String(truncatedSentence) + trailingContent.text) as NSString

        }
        self.text = truncatedSentence as String
        self.highlight(trailingContent.text, color: highlightColor)
    }

    func appendReadLess(after text: String, trailingContent: TrailingContent) {
        self.numberOfLines = 0
        self.text = text + trailingContent.text
        self.highlight(trailingContent.text, color: highlightColor)
    }
}

extension UITapGestureRecognizer {
    
    /// To did tap gesture for the label
    /// - Parameters:
    ///   - label: passing label object.
    ///   - targetRange: passing target range.
    /// - Returns: return boolean value.
    func didTap(label: UILabel, inRange targetRange: NSRange) -> Bool {
        
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)

        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

extension UILabel {
    
    /// To get max number of lines for label
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font!], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}

extension UILabel {
    
    /**
     * A map of actions, mapped as [ instanceIdentifier : action ].
     */
    private static var _tapHandlers = [String:(()->Void)]()

    /**
     * Retrieve the address for this UILabel as a String.
     */
    private func getAddressAsString() -> String {
        let addr = Unmanaged.passUnretained(self).toOpaque()
        return "\(addr)"
    }

    /**
     * Set the on tapped event for the label
     */
    func setOnTapped(_ handler: @escaping (()->Void)) {
        UILabel._tapHandlers[getAddressAsString()] = handler
        let gr = UITapGestureRecognizer(target: self, action: #selector(onTapped))
        gr.numberOfTapsRequired = 1
        self.addGestureRecognizer(gr)
        self.isUserInteractionEnabled = true
    }

    /**
     * Handle the tap event.
     */
    @objc private func onTapped() {
        UILabel._tapHandlers[self.getAddressAsString()]?()
    }
}

/// To used for find text width from the label
extension UILabel {
    
    func textWidth() -> CGFloat {
        return UILabel.textWidth(label: self)
    }
    
    class func textWidth(label: UILabel) -> CGFloat {
        return textWidth(label: label, text: label.text!)
    }
    
    class func textWidth(label: UILabel, text: String) -> CGFloat {
        return textWidth(font: label.font, text: text)
    }
    
    class func textWidth(font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString
        
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(labelSize.width)
    }
}

/*/// To used for padding from the label
extension UILabel {
    
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }

    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }

    override open var intrinsicContentSize: CGSize {
        guard let text = self.text else { return super.intrinsicContentSize }

        var contentSize = super.intrinsicContentSize
        var textWidth: CGFloat = frame.size.width
        var insetsHeight: CGFloat = 0.0
        var insetsWidth: CGFloat = 0.0

        if let insets = padding {
            insetsWidth += insets.left + insets.right
            insetsHeight += insets.top + insets.bottom
            textWidth -= insetsWidth
        }

        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font: self.font as Any], context: nil)

        contentSize.height = ceil(newSize.size.height) + insetsHeight
        contentSize.width = ceil(newSize.size.width) + insetsWidth

        return contentSize
    }
}*/
