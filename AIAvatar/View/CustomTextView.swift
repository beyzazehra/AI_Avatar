import UIKit
import NeonSDK

class CustomTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

   
    func setDelegate(vc: UITextViewDelegate) {
        self.delegate = vc
        self.returnKeyType = .done
    }

    func configureAsCustomTextView(placeholder: String?, fontSize: CGFloat = 14, cornerRadius: CGFloat = 15, textColor: UIColor = .white, placeholderColor: UIColor = .lightGray) {
        
        self.text = ""
        self.backgroundColor = .textAreaColor
        self.textColor = placeholderColor
        self.layer.cornerRadius = cornerRadius
        self.font = Font.custom(size: fontSize, fontWeight: .Light)
        self.keyboardAppearance = .dark
        
    }
}


