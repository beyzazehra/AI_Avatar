import UIKit
import SwiftUI
import NeonSDK

class CustomButton: UIButton {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    private func updateAppearance() {
        if isSelected {
            layer.borderColor = UIColor.green.cgColor
            setImage(UIImage(named: "greenellipse"), for: .normal)
        } else {
            layer.borderColor = UIColor.textAreaColor.cgColor
            setImage(UIImage(named: "ellipse"), for: .normal)
        }
    }
    
    private func commonInit() {
        
    }
    
    func configure(with settingsButton: SettingsButton) {
        createButton(title: settingsButton.title, bgColor: settingsButton.bgColor, titleColor: .white)
        
        if let iconImageView = settingsButton.iconName {
            configureAspectButton(title: settingsButton.title, iconName: iconImageView.image?.accessibilityIdentifier, bgColor: settingsButton.bgColor, imagePlacement: settingsButton.imagePlacement)
        }
    }
    
    func configureNavigationButton(imageName: String) {
        if let buttonImage = UIImage(named: imageName) {
            setImage(buttonImage, for: .normal)
        }
    }
    
    
    func createButton(title: String, bgColor: UIColor, titleColor: UIColor) {
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = bgColor
        configuration.baseForegroundColor = titleColor
        configuration.background.cornerRadius = 15
        self.titleLabel?.font = Font.custom(size: 16, fontWeight: .Medium)
        self.configuration = configuration
    }
    

    
    func configureDropDownButton(title: String, iconName: String? = nil) {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 170
        configuration.baseBackgroundColor = .textAreaColor
        configuration.background.cornerRadius = 15
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        if let iconName = iconName {
            let iconImage = UIImage(systemName: iconName)?.withRenderingMode(.alwaysTemplate)
            configuration.image = iconImage
            configuration.baseForegroundColor = .white
        } else {
            configuration.image = nil
        }
        
        self.titleLabel?.font = Font.custom(size: 12, fontWeight: .Light)
        self.configuration = configuration
        
    }
    
    func configureAspectButton(title: String, iconName: String? = nil, bgColor: UIColor, imagePlacement: NSDirectionalRectEdge) {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.imagePlacement = imagePlacement
        configuration.titlePadding = 10
        configuration.baseBackgroundColor = bgColor
        configuration.background.cornerRadius = 15
        
        if let iconName = iconName {
            let iconImage = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
            configuration.image = iconImage
            configuration.baseForegroundColor = .white
        } else {
            configuration.image = nil
        }
        
        self.titleLabel?.font = Font.custom(size: 12, fontWeight: .Light)
        self.configuration = configuration
    }
    
    func configureResultButton(title: String, titleColor: UIColor, bgColor: UIColor, iconName: String, borderColor: UIColor) {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = bgColor
        configuration.baseForegroundColor = titleColor
        configuration.cornerStyle = .medium
        
        if let icon = UIImage(systemName: iconName) {
            configuration.image = icon
            configuration.imagePlacement = .leading
            configuration.imagePadding = 8
        }
        
        self.configuration = configuration
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
    }
    
    func paywallButton(title: String, subtitle: String?, titleColor: Color, subtitleColor: Color, bgColor: UIColor, iconName: String?, borderColor: UIColor) {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = bgColor
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 55
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        if let iconName = UIImage(named: iconName!) {
            setImage(iconName, for: .normal)
        }
        
        var titleAttributedString = AttributedString(title)
        titleAttributedString.foregroundColor = UIColor(titleColor)
        titleAttributedString.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        
        var subtitleAttributedString = AttributedString("\n" + (subtitle ?? ""))
        subtitleAttributedString.foregroundColor = UIColor(subtitleColor)
        subtitleAttributedString.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        titleAttributedString.append(subtitleAttributedString)
        
        configuration.attributedTitle = titleAttributedString
        
        self.titleLabel?.numberOfLines = 1
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 15
        self.configuration = configuration
        
    }
    

}
