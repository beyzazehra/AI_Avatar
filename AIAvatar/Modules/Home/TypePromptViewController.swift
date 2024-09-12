import UIKit
import NeonSDK

class TypePromptViewController: UIViewController {
    
    let textView = CustomTextView()

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
        
        let imgView = UIImageView(image: UIImage(named: "group"))
        view.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(navigationButton.snp.bottom).offset(10)
            make.height.equalTo(230)
            
        }
        
        let mainLabel = UILabel()
        view.addSubview(mainLabel)
        mainLabel.text = "Type your avatar prompt"
        mainLabel.textColor = .white
        mainLabel.font = Font.custom(size: 22, fontWeight: .Bold)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgView.snp.bottom).offset(20)
        }
        
        let descriptLabel = UILabel()
        view.addSubview(descriptLabel)
        descriptLabel.text = "How do you want your avatar looks like?"
        descriptLabel.numberOfLines = 0
        descriptLabel.textColor = .white
        descriptLabel.textAlignment = .center
        descriptLabel.font = Font.custom(size: 14, fontWeight: .Light)
        descriptLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-80)
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
            
        }
        
        view.addSubview(textView)
        textView.configureAsCustomTextView(placeholder: "Type...")
        textView.setDelegate(vc: self)
        textView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptLabel.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(120)
        }

    }

        
    @objc func navigate() {
        self.hero.dismissViewController()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .white
        }
    }
    

   
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else {return}
        
        let createVC = CreateFromPromptViewController()
        createVC.textViewPromptString = text
        self.present(destinationVC: createVC, slideDirection: .right)

    }

    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            print("Done tapped")
           
            return false
        }
        return true
    }
   

}
extension TypePromptViewController: UITextFieldDelegate, UITextViewDelegate {
    
}


