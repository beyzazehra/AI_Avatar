import UIKit
import NeonSDK

class StartPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    
    func setUpUI() {
        
        view.backgroundColor = .black
        
        let navigationButton = CustomButton()
        navigationButton.configureNavigationButton(imageName: "btn")
        navigationButton.addTarget(self, action: #selector(navigate), for: .touchUpInside)
        view.addSubview(navigationButton)
        navigationButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        let headerLabel = UILabel()
        view.addSubview(headerLabel)
        headerLabel.text = "Create Avatar"
        headerLabel.textColor = .white
        headerLabel.font = Font.custom(size: 18, fontWeight: .Bold)
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(navigationButton)
        }
        
        
        let mainLabel = UILabel()
        view.addSubview(mainLabel)
        mainLabel.text = "Start Here"
        mainLabel.textColor = .white
        mainLabel.font = Font.custom(size: 22, fontWeight: .Bold)
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let descriptLabel = UILabel()
        view.addSubview(descriptLabel)
        descriptLabel.text = "Create your first avatar with the power of artificial intelligence."
        descriptLabel.numberOfLines = 0
        descriptLabel.textColor = .white
        descriptLabel.textAlignment = .center
        descriptLabel.font = Font.custom(size: 14, fontWeight: .Light)
        descriptLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-80)
            make.top.equalTo(mainLabel.snp.bottom).offset(12)
            
        }
        
        let arrowView = UIImageView(image: UIImage(named: "arrow"))
        view.addSubview(arrowView)
        arrowView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptLabel.snp.bottom).offset(20)
            make.height.equalTo(150)
            
        }
        
        let createButton = CustomButton()
        createButton.createButton(title: "Create New Avatar", bgColor: .buttonColor, titleColor: .black)
        view.addSubview(createButton)
        createButton.addTarget(self, action: #selector(navigateTypeAvatarVC), for: .touchUpInside)
        createButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.width.equalTo(300)
            make.height.equalTo(50)
            
        }
        
    }
    
    @objc func navigate() {
        self.hero.dismissViewController()
    }
    
    @objc func navigateTypeAvatarVC() {
        let vc = TypeAvatarViewController()
        present(destinationVC: vc, slideDirection: .right)
    }
    
    
}
