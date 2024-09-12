import UIKit
import NeonSDK

class CheckOutViewController: UIViewController {
    
    var customButtons: [CustomButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
    }
    
    
    func setUpUI() {
        
        view.backgroundColor = .black
        
        let closeButton = CustomButton()
        closeButton.configureNavigationButton(imageName: "closeblack")
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        let mainLabel = UILabel()
        view.addSubview(mainLabel)
        mainLabel.text = "Check Out"
        mainLabel.textColor = .white
        mainLabel.font = Font.custom(size: 24, fontWeight: .Bold)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            
            
        }
        
        let label = UILabel()
        view.addSubview(label)
        label.text = "Why is it pay?"
        label.textColor = .white
        label.font = Font.custom(size: 14, fontWeight: .Light)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
        }
        
        let otherLabel = UILabel()
         view.addSubview(otherLabel)
         otherLabel.text = "AI Avatar consume that tremendous computation power to create amazing avatars for you. It’s expensive, but we made it as affordable as possible."
         otherLabel.numberOfLines = 0
         otherLabel.textAlignment = .center
         otherLabel.textColor = .white
         otherLabel.font = Font.custom(size: 14, fontWeight: .Light)
         otherLabel.snp.makeConstraints { make in
             make.centerX.equalToSuperview()
             make.top.equalTo(label.snp.bottom).offset(20)
             make.leading.equalToSuperview().offset(20)
             make.trailing.equalToSuperview().offset(-20)
         }
         otherLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 40

        let rect = UIImageView(image: UIImage(named: "bigrect"))
        view.addSubview(rect)
        rect.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(otherLabel.snp.bottom).offset(70)
            make.height.equalTo(340)
            make.width.equalTo(350)
            
        }
        
        let customButton = CustomButton()
        customButton.paywallButton(title: "50 AVATARS - $7.99", subtitle: nil, titleColor: .white, subtitleColor: .white, bgColor: .optionButtonColor, iconName: "ellipse", borderColor: .textAreaColor)
        view.addSubview(customButton)
        customButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        customButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(rect).offset(-100)
            make.height.equalTo(80)
            make.width.equalTo(300)
        }
        
        let customButton2 = CustomButton()
        customButton2.paywallButton(title: "100 AVATARS - $11.99", subtitle: nil, titleColor: .white, subtitleColor: .white, bgColor: .optionButtonColor, iconName: "ellipse", borderColor: .textAreaColor)
        view.addSubview(customButton2)
        customButton2.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        customButton2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(customButton.snp.bottom).offset(10)
            make.height.equalTo(80)
            make.width.equalTo(300)
        }
        
        let saveView = SaveView()
        saveView.setTitle("POPULAR")
        saveView.clipsToBounds = true
        customButton2.addSubview(saveView)
        saveView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        let customButton3 = CustomButton()
        customButton3.paywallButton(title: "200 AVATARS - $15.99", subtitle: nil, titleColor: .white, subtitleColor: .white, bgColor: .optionButtonColor, iconName: "ellipse", borderColor: .textAreaColor)
        view.addSubview(customButton3)
        customButton3.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        customButton3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(customButton2.snp.bottom).offset(10)
            make.height.equalTo(80)
            make.width.equalTo(300)
        }
        
        customButtons = [customButton, customButton2, customButton3]

        let bottomLabel = UILabel()
        view.addSubview(bottomLabel)
        bottomLabel.text = "Get Up to %50 off with Subscription"
        bottomLabel.textColor = .white
        bottomLabel.font = Font.custom(size: 14, fontWeight: .Light)
        bottomLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(customButton3.snp.bottom).offset(20)
        }
        
        let bottomLabel2 = UILabel()
        view.addSubview(bottomLabel2)
        bottomLabel2.text = "See Plans"
        bottomLabel2.textColor = .buttonColor
        bottomLabel2.font = Font.custom(size: 14, fontWeight: .Light)
        bottomLabel2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bottomLabel.snp.bottom).offset(20)
        }
        
        let button = CustomButton()
        button.createButton(title: "Continue", bgColor: .buttonColor, titleColor: .black)
        button.addTarget(self, action: #selector(navigateToPayment), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        let legalView = NeonLegalView()
        legalView.configureLegalController(onVC: self, backgroundColor: .black, headerColor: .blue, titleColor: .white, textColor: .white)
        legalView.restoreButtonClicked = {
            
        }
        legalView.textColor = .white
        view.addSubview(legalView)
        legalView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        legalView.termsURL = "[https://www.neonapps.co/terms-of-use](https://www.neonapps.co/terms-of-use)"
        legalView.privacyURL = "[https://www.neonapps.co/privacy-policy](https://www.neonapps.co/privacy-policy)"

    }
    
    @objc func dismissPage() {
        self.present(destinationVC: AIAvatarViewController(), slideDirection: .right)
    }
    
    @objc func navigateToPayment() {
        
    }
    
    @objc func buttonTapped(_ sender: CustomButton) {
        for button in customButtons {
            button.isSelected = false
            button.layer.borderColor = UIColor.textAreaColor.cgColor
            button.setImage(UIImage(named: "ellipse"), for: .normal)
        }

        sender.isSelected = true
        sender.layer.borderColor = UIColor.green.cgColor
        sender.setImage(UIImage(named: "greenellipse"), for: .normal) 

        sender.layoutIfNeeded()
    }

}
