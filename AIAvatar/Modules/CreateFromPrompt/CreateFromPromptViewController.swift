import UIKit
import NeonSDK
import FirebaseAuth
import FirebaseFirestore

class CreateFromPromptViewController: NeonViewController, PromptOptionsDelegate, ButtonTitleDelegate, UITextViewDelegate {
    
    
    var userPromptText: String?
    var selectedAspectRatio: String?
    let bottomLabel = UILabel()
    let promptSuggestionButton = CustomButton()
    let textView = CustomTextView()
    let headerStack = NeonHStack()
    let options = PromptOptions()
    
    var textViewPromptString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        options.delegate = self
        options.titleDelegate = self
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        view.backgroundColor = .black
        
        let navigationButton = CustomButton()
        navigationButton.configureNavigationButton(imageName: "btn")
        navigationButton.addTarget(self, action: #selector(navigatePrevious), for: .touchUpInside)
        view.addSubview(navigationButton)
        navigationButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        let headerLabel = UILabel()
        headerLabel.text = "Create"
        headerLabel.textColor = .white
        headerLabel.font = Font.custom(size: 18, fontWeight: .Bold)
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(navigationButton)
        }
        
        let mainLabel = UILabel()
        mainLabel.text = "Create:"
        mainLabel.textColor = .white
        mainLabel.font = Font.custom(size: 16, fontWeight: .Bold)
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationButton.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        textView.configureAsCustomTextView(placeholder: nil)
        textView.delegate = self
        view.addSubview(textView)
        textView.text = textViewPromptString
        textView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
            make.width.equalTo(380)
            make.height.equalTo(135)
        }
        
        options.isHidden = true
        view.addSubview(options)
        options.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(200)
        }
        
        promptSuggestionButton.configureDropDownButton(title: "Prompt Suggestions", iconName: "chevron.down")
        promptSuggestionButton.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
        view.addSubview(promptSuggestionButton)
        promptSuggestionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textView.snp.bottom).offset(10)
            make.width.equalTo(380)
            make.height.equalTo(50)
        }
        
        bottomLabel.text = "Choose Aspect Ratio:"
        bottomLabel.textColor = .white
        bottomLabel.font = Font.custom(size: 16, fontWeight: .Bold)
        view.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(promptSuggestionButton.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            
        }
        
        headerStack.distribution = .equalSpacing
        headerStack.spacing = 8
        view.addSubview(headerStack)
        headerStack.snp.makeConstraints { make in
            make.top.equalTo(bottomLabel.snp.bottom).offset(20)
            make.height.equalTo(110)
            make.width.equalTo(380)
        }
        
        let button1 = CustomButton()
        button1.configureAspectButton(title: "1:1", iconName: "rect11", bgColor: .textAreaColor, imagePlacement: .top)
        button1.addTarget(self, action: #selector(aspectRatioButtonTapped(_:)), for: .touchUpInside)
        headerStack.addArrangedSubview(button1)
        
        let button2 = CustomButton()
        button2.configureAspectButton(title: "3:2", iconName: "rect32", bgColor: .textAreaColor, imagePlacement: .top)
        button2.addTarget(self, action: #selector(aspectRatioButtonTapped(_:)), for: .touchUpInside)
        headerStack.addArrangedSubview(button2)
        
        let button3 = CustomButton()
        button3.configureAspectButton(title: "2:3", iconName: "rect23", bgColor: .textAreaColor, imagePlacement: .top)
        button3.addTarget(self, action: #selector(aspectRatioButtonTapped(_:)), for: .touchUpInside)
        headerStack.addArrangedSubview(button3)
        
        let createMoreButton = CustomButton()
        createMoreButton.createButton(title: "Create More", bgColor: .buttonColor, titleColor: .black)
        view.addSubview(createMoreButton)
        createMoreButton.addTarget(self, action: #selector(navigateNext), for: .touchUpInside)
        createMoreButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
    }
 
    func didReceiveButtonTitle(_ title: String) {
        if let currentText = textView.text {
            textView.text = currentText + " " + title
        } else {
            textView.text = title
        }
    }
    
    func createAspectRatioButton(title: String, iconName: String) -> CustomButton {
        let button = CustomButton()
        button.configureAspectButton(title: title, iconName: iconName, bgColor: .textAreaColor, imagePlacement: .top)
        button.addTarget(self, action: #selector(aspectRatioButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func aspectRatioButtonTapped(_ sender: CustomButton) {
        print("Button tapped: \(sender.titleLabel?.text ?? "Unknown")")
        
        for button in headerStack.arrangedSubviews as! [CustomButton] {
            button.backgroundColor = .textAreaColor
        }
        
        sender.backgroundColor = .buttonColor
        
        selectedAspectRatio = sender.titleLabel?.text
        print("Selected Aspect Ratio: \(selectedAspectRatio ?? "None")")
        
    }
    
    
    @objc func showOptions() {
        promptSuggestionButton.isHidden = true
        bottomLabel.isHidden = true
        headerStack.isHidden = true
        
        options.alpha = 1.0
        options.isHidden = false
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideOptions() {
        UIView.animate(withDuration: 0.1) {
            self.options.isHidden = true
            self.view.layoutIfNeeded()
        }
        
        promptSuggestionButton.isHidden = false
        bottomLabel.isHidden = false
        headerStack.isHidden = false
    }
       
    
    @objc func navigatePrevious() {
        self.hero.dismissViewController()
    }
    
    @objc func navigateNext() {
        guard let userPrompt = textView.text, !userPrompt.isEmpty else {
            print("Prompt is empty")
            return
        }
        
        guard let currentUser = Auth.auth().currentUser else {
            print("No authenticated user found")
            return
        }

        let trainingPageVC = TrainingPageViewController()
        trainingPageVC.modalPresentationStyle = .fullScreen
        present(trainingPageVC, animated: true, completion: nil)

        makeAPIRequestForUUID(with: userPrompt) { result in
            DispatchQueue.main.async {
                trainingPageVC.dismiss(animated: true, completion: {
                    switch result {
                    case .success(let videoURLString):
                        if let videoURL = URL(string: videoURLString) {
                            let resultVC = ResultPageViewController()
                            resultVC.yourAvatarPromptText = self.textView.text
                            resultVC.videoURL = videoURL
                            self.present(resultVC, animated: true, completion: nil)
                            
                            FirestoreManager.updateDocument(path: [
                               .collection(name: "id collection"),
                               .document(name: "id document")
                            ], fields: [
                                "promptResult": FieldValue.arrayUnion([videoURLString])
                            ])

                            
                        } else {
                            print("Invalid video URL")
                        }
                    case .failure(let error):
                        print("Error making API request: \(error)")
                    }
                })
            }
        }
    }

}

