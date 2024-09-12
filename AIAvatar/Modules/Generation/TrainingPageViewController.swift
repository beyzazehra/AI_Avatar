import UIKit
import NeonSDK

class TrainingPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI() {

        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "splash")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let imgView = UIImageView(image: UIImage(named: "group"))
        view.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(230)
        }

        let mainLabel = UILabel()
        view.addSubview(mainLabel)
        mainLabel.text = "Training AI Model..."
        mainLabel.textColor = .white
        mainLabel.font = Font.custom(size: 22, fontWeight: .Bold)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgView.snp.bottom).offset(20)
        }

        let descriptLabel = UILabel()
        view.addSubview(descriptLabel)
        descriptLabel.text = "We are training a custom AI model for you. Once we’re done, you’ll be able to create as many avatars as you want!"
        descriptLabel.numberOfLines = 0
        descriptLabel.textColor = .white
        descriptLabel.textAlignment = .center
        descriptLabel.font = Font.custom(size: 14, fontWeight: .Light)
        descriptLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-80)
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
        }

        let remainView = UIImageView(image: UIImage(named: "remain"))
        view.addSubview(remainView)
        remainView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptLabel.snp.bottom).offset(20)
            make.width.equalTo(220)
            make.height.equalTo(100)
        }

        let durationLabel = UILabel()
        durationLabel.text = "Remaining Duration"
        durationLabel.textColor = .remainTintColor
        durationLabel.font = Font.custom(size: 22, fontWeight: .Light)
        durationLabel.textAlignment = .center

        let timeLabel = UILabel()
        timeLabel.text = "Please Wait"
        timeLabel.textColor = .white
        timeLabel.font = Font.custom(size: 22, fontWeight: .Light)
        timeLabel.textAlignment = .center

        let stackView = UIStackView(arrangedSubviews: [durationLabel, timeLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8

        remainView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        let hideButton = CustomButton()
        hideButton.createButton(title: "Hide This Page", bgColor: .buttonColor, titleColor: .black)
        view.addSubview(hideButton)
        hideButton.addTarget(self, action: #selector(navigate), for: .touchUpInside)
        hideButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
    
    @objc func navigate() {
        self.present(destinationVC: PremiumPageViewController(), slideDirection: .up)

    }
}
