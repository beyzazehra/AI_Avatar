import UIKit
import NeonSDK

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        configureTextField()
    }
    
    func configureTextField() {
        self.attributedPlaceholder = NSAttributedString(
            string: "Type...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.leftViewMode = .always
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.rightViewMode = .always
        self.backgroundColor = .textAreaColor
        self.textColor = .white
        self.layer.cornerRadius = 15
        self.font = Font.custom(size: 14, fontWeight: .Light)
        self.keyboardAppearance = .dark
    }
}
