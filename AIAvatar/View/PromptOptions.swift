import UIKit
import NeonSDK

protocol PromptOptionsDelegate: AnyObject {
    func hideOptions()
}

protocol ButtonTitleDelegate: AnyObject {
    func didReceiveButtonTitle(_ title: String)
}

class PromptOptions: UIView {
    
    weak var titleDelegate: ButtonTitleDelegate?
    weak var delegate: PromptOptionsDelegate?
    
    let mainStackView = UIStackView()
    var isToggle = false
    
    func buttonTapped(withTitle title: String) {
        print("title: \(title)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        mainStackView.backgroundColor = .textAreaColor
        mainStackView.layer.cornerRadius = 15
        self.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fill
        horizontalStackView.backgroundColor = .textAreaColor
        horizontalStackView.layer.cornerRadius = 15
        mainStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        let promptSuggestionLabel = UILabel()
        promptSuggestionLabel.text = "Prompt Suggestions"
        promptSuggestionLabel.textColor = .white
        promptSuggestionLabel.font = Font.custom(size: 16, fontWeight: .Light)
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        promptSuggestionLabel.isUserInteractionEnabled = true
        promptSuggestionLabel.addGestureRecognizer(labelTapGesture)
        horizontalStackView.addArrangedSubview(promptSuggestionLabel)
        
        let iconImage = UIImageView(image: UIImage(systemName: "chevron.down"))
        iconImage.contentMode = .scaleAspectFit
        iconImage.tintColor = .white
        let iconTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        iconImage.isUserInteractionEnabled = true
        iconImage.addGestureRecognizer(iconTapGesture)
        horizontalStackView.addArrangedSubview(iconImage)
        
        iconImage.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        promptSuggestionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(iconImage.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
        }
        
        let rowStackView1 = UIStackView()
        rowStackView1.axis = .horizontal
        rowStackView1.spacing = 10
        rowStackView1.alignment = .fill
        rowStackView1.distribution = .fillEqually
        mainStackView.addArrangedSubview(rowStackView1)
        
        let button1 = CustomButton()
        button1.createButton(title: "Elegant", bgColor: .optionButtonColor, titleColor: .white)
        button1.addTarget(self, action: #selector(buttonTapped1), for: .touchUpInside)
        rowStackView1.addArrangedSubview(button1)
        
        button1.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        let button2 = CustomButton()
        button2.createButton(title: "Cute", bgColor: .optionButtonColor, titleColor: .white)
        button2.addTarget(self, action: #selector(buttonTapped1), for: .touchUpInside)
        rowStackView1.addArrangedSubview(button2)
        
        button2.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        let rowStackView2 = UIStackView()
        rowStackView2.axis = .horizontal
        rowStackView2.spacing = 10
        rowStackView2.alignment = .fill
        rowStackView2.distribution = .fillEqually
        mainStackView.addArrangedSubview(rowStackView2)
        
        let button3 = CustomButton()
        button3.createButton(title: "Clear", bgColor: .optionButtonColor, titleColor: .white)
        button3.addTarget(self, action: #selector(buttonTapped1), for: .touchUpInside)
        rowStackView2.addArrangedSubview(button3)
        
        button3.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        let button4 = CustomButton()
        button4.createButton(title: "Shiny", bgColor: .optionButtonColor, titleColor: .white)
        button4.addTarget(self, action: #selector(buttonTapped1), for: .touchUpInside)
        rowStackView2.addArrangedSubview(button4)
        
        button4.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        let rowStackView3 = UIStackView()
        rowStackView3.axis = .horizontal
        rowStackView3.spacing = 10
        rowStackView3.alignment = .fill
        rowStackView3.distribution = .fillEqually
        mainStackView.addArrangedSubview(rowStackView3)
        
        let button5 = CustomButton()
        button5.createButton(title: "Dark", bgColor: .optionButtonColor, titleColor: .white)
        button5.addTarget(self, action: #selector(buttonTapped1), for: .touchUpInside)
        rowStackView3.addArrangedSubview(button5)
        button5.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        let button6 = CustomButton()
        button6.createButton(title: "Extraordinary", bgColor: .optionButtonColor, titleColor: .white)
        button6.addTarget(self, action: #selector(buttonTapped1), for: .touchUpInside)
        rowStackView3.addArrangedSubview(button6)
        button6.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        
    }
    
    @objc func buttonTapped1(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            titleDelegate?.didReceiveButtonTitle(title)
        }
    }
    
    @objc func tapped() {
        if let parentView = self.delegate as? CreateFromPromptViewController {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0.0
            }, completion: { _ in
                self.isHidden = true
                parentView.hideOptions()
            })
        }
    }
    
    
}
