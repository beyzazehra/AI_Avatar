import UIKit
import NeonSDK
import Adapty

class PremiumPageViewController: UIViewController, AdaptyManagerDelegate {
    
    
    let customButton = CustomButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        AdaptyManager.delegate = self
        AdaptyManager.selectPaywall(placementID: "pro")
        if let Paywall = AdaptyManager.selectedPaywall{
            Adapty.logShowPaywall(Paywall)
        }
        
        packageFetched()
        
    }
    
    func setUpUI() {
        
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "inapp")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let closeButton = CustomButton()
        closeButton.configureNavigationButton(imageName: "closegreen")
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
        mainLabel.text = "Choose Your Plan"
        mainLabel.textColor = .white
        mainLabel.font = Font.custom(size: 24, fontWeight: .Bold)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(250)
        }
        
        let featuresView = NeonPaywallFeaturesView()
        view.addSubview(featuresView)
        featuresView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(90)
        }
        
        featuresView.featureTextColor = .white
        featuresView.featureIconBackgroundColor = .black
        featuresView.featureIconTintColor = .white
        
        featuresView.addFeature(title: "Unlimited Art Creation", icon: UIImage(named: "infinity")!)
        featuresView.addFeature(title: "Ad - Free Experience", icon: UIImage(named: "block")!)
        featuresView.addFeature(title: "No limits to Photo Editing", icon: UIImage(named: "check")!)
        
        let rect = UIImageView(image: UIImage(named: "rect"))
        view.addSubview(rect)
        rect.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(featuresView.snp.bottom).offset(70)
            make.height.equalTo(230)
            make.width.equalTo(350)
        }
        
        customButton.paywallButton(title: "YEARLY ACCESS", subtitle: "US$29.99/year", titleColor: .green, subtitleColor: .white, bgColor: .optionButtonColor, iconName: "greenellipse", borderColor: .buttonColor)
        customButton.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
        view.addSubview(customButton)
        customButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(rect).offset(-40)
            make.height.equalTo(80)
            make.width.equalTo(300)
        }
        
        let saveView = SaveView()
        saveView.setTitle("SAVE %60")
        saveView.tintColor = .black
        saveView.clipsToBounds = true
        customButton.addSubview(saveView)
        saveView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        let label = UILabel()
        view.addSubview(label)
        label.text = "No commitment. Cancel anytime."
        label.textColor = .white
        label.font = Font.custom(size: 14, fontWeight: .Light)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(customButton.snp.bottom).offset(50)
        }
        
        let button = CustomButton()
        button.createButton(title: "Continue", bgColor: .buttonColor, titleColor: .black)
        button.addTarget(self, action: #selector(purchase), for: .touchUpInside)
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
            // Handle restore purchases
        }
        legalView.textColor = .white
        view.addSubview(legalView)
        legalView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        legalView.termsURL = "https://www.neonapps.co/terms-of-use"
        legalView.privacyURL = "https://www.neonapps.co/privacy-policy"
        
        
    }
    
    
    @objc func dismissPage() {
        self.hero.dismissViewController()
    }
    
    @objc func selectButton() {
        customButton.isSelected = true
    }

    
    @objc func purchase() {
                    
        self.present(destinationVC: CheckOutViewController(), slideDirection: .right)

        AdaptyManager.selectPackage(id: "unlock.neonacademy.annual")
        AdaptyManager.purchase(animation: .loadingCircle2, animationColor: .buttonColor) { [self] in
            self.present(destinationVC: AIAvatarViewController(), slideDirection: .right)
        } completionFailure: {
            NeonAlertManager.default.present(
                title: "Opps...",
                message: "Looks like an unexpected error occurred",
                style: .alert,
                viewController: self
            )
        }
        
    }
    
    func packageFetched() {
        
//        if let price = AdaptyManager.getPackagePrice(id: "unlock.neonacademy.annual"){
//            let monthlyPackagePrice = price
//        }
//        
        if let monthlyPackage = AdaptyManager.getPackage(id: "unlock.neonacademy.annual"){
            let price = monthlyPackage.localizedPrice
        }
    }
    
    
}
