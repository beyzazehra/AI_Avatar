import UIKit
import NeonSDK

class SettingsTableViewController: UIViewController {
    
    var tableview = NeonTableView<SettingsButton, ButtonsTableViewCell>()
    let buttons = [
        SettingsButton(title: "Try Premium", iconName: UIImageView(image: UIImage(systemName: "crown")), bgColor: .buttonColor, imagePlacement: .trailing),
        SettingsButton(title: "Restore Purchase", iconName: nil, bgColor: .textAreaColor, imagePlacement: .trailing),
        SettingsButton(title: "Privacy Policy", iconName: nil, bgColor: .textAreaColor, imagePlacement: .trailing),
        SettingsButton(title: "Terms of Use", iconName: nil, bgColor: .textAreaColor, imagePlacement: .trailing),
        SettingsButton(title: "Rate Us", iconName: nil, bgColor: .textAreaColor, imagePlacement: .trailing),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        func setUpUI() {

            view.backgroundColor = .black
            
            let navigationButton = CustomButton()
            navigationButton.configureNavigationButton(imageName: "btn")
            view.addSubview(navigationButton)
            navigationButton.addTarget(self, action: #selector(navigate), for: .touchUpInside)
            navigationButton.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
                make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
                make.width.equalTo(40)
                make.height.equalTo(40)
            }
            
            let headerLabel = UILabel()
            view.addSubview(headerLabel)
            headerLabel.text = "Settings"
            headerLabel.textColor = .white
            headerLabel.font = Font.custom(size: 18, fontWeight: .Bold)
            headerLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalTo(navigationButton)
            }
            
            tableview = NeonTableView<SettingsButton, ButtonsTableViewCell>(
                objects: buttons,
                heightForRows: 70
            )
            view.addSubview(tableview)
            tableview.backgroundColor = .black
            tableview.snp.makeConstraints { make in
                make.top.equalTo(headerLabel.snp.bottom).offset(10)
                make.left.right.bottom.equalToSuperview()
            }
            tableview.reloadData()


            tableview.didSelect = { object, indexPath in
                print("selam")
                switch object.title {
                case "Try Premium":
                    print("Try Premium button tapped")
                    self.present(destinationVC: PremiumPageViewController(), slideDirection: .left)
                    
                case "Restore Purchase":
                    print("Restore Purchase button tapped")
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(appSettings) {
                            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                        }
                    }

                case "Privacy Policy":
                    print("Privacy Policy button tapped")
                    if let url = URL(string: "https://neonapps.co") {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }

                case "Terms of Use":
                    print("Terms of Use button tapped")
                    if let url = URL(string: "https://neonapps.com") {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                case "Rate Us":
                    print("Rate Us button tapped")
                    if let url = URL(string:                 "https://apps.apple.com/tr/app/bree-breathing-exercises/id1527756593?l=tr") {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                default:
                    break
                }
            }

        
        }

    }
    
    
    @objc func navigate() {
        self.hero.dismissViewController()
    }
}
