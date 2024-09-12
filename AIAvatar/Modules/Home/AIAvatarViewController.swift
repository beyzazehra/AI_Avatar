import UIKit
import NeonSDK

class AIAvatarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    
    func setUpUI() {
        
        view.backgroundColor = .black
        
        let navigationButton = CustomButton()
        navigationButton.configureNavigationButton(imageName: "settings")
        navigationButton.addTarget(self, action: #selector(navigateSettings), for: .touchUpInside)
        view.addSubview(navigationButton)
        navigationButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        let headerLabel = UILabel()
        view.addSubview(headerLabel)
        headerLabel.text = "AI Avatar"
        headerLabel.textColor = .white
        headerLabel.font = Font.custom(size: 22, fontWeight: .Bold)
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(navigationButton)
        }
        
        
        let startPromptButton = CustomButton()
        startPromptButton.configureNavigationButton(imageName: "prompt")
        startPromptButton.addTarget(self, action: #selector(navigateHome), for: .touchUpInside)
        view.addSubview(startPromptButton)
        startPromptButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(30)
            make.width.equalTo(380)
            make.height.equalTo(270)
        }
    }
    
    @objc func navigateSettings() {
        self.present(destinationVC: SettingsTableViewController(), slideDirection: .right)
    }
    
    @objc func navigateHome() {
        self.present(destinationVC: StartPageViewController(), slideDirection: .right)
    }
}
