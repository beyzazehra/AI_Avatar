import UIKit
import NeonSDK
import FirebaseAuth

class TypeAvatarViewController: UIViewController {
    
    let textField = CustomTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        signInAnonymously()
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
        mainLabel.text = "Type your avatar ID"
        mainLabel.textColor = .white
        mainLabel.font = Font.custom(size: 22, fontWeight: .Bold)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgView.snp.bottom).offset(20)
        }
        
        let descriptLabel = UILabel()
        view.addSubview(descriptLabel)
        descriptLabel.text = "What will you call your avatar?"
        descriptLabel.numberOfLines = 0
        descriptLabel.textColor = .white
        descriptLabel.textAlignment = .center
        descriptLabel.font = Font.custom(size: 14, fontWeight: .Light)
        descriptLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-80)
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
            
        }
        
        textField.configureTextField()
        view.addSubview(textField)
        textField.delegate = self
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptLabel.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(60)
            
        }
   
    }
    
    @objc func navigate() {
        self.hero.dismissViewController()
    }
    
    func signInAnonymously() {
            Auth.auth().signInAnonymously { authResult, error in
                if let error = error {
                    print("Error signing in anonymously: \(error.localizedDescription)")
                    return
                }

                guard let user = authResult?.user else { return }
                print("Signed in anonymously with user ID: \(user.uid)")
            }
        }

        func checkUsernameUniqueness(_ username: String) {
            let reference = FirestoreManager.prepareReferance(path: [
                .collection(name: "id collection")
            ])
            .whereField("id", isEqualTo: username)
            .limit(to: 1)

            FirestoreManager.getDocuments(referance: reference) { documentID, documentData in
                self.showAlert(message: "This Avatar ID is already taken. Please choose a different one.")
            } isCollectionEmpty: {
                guard let currentUser = Auth.auth().currentUser else {
                    self.showAlert(message: "User is not authenticated.")
                    return
                }

                FirestoreManager.setDocument(path: [
                    .collection(name: "id collection"),
                    .document(name: "id document"),
                ], fields: [
                    "id": username,
                    "userID": currentUser.uid,
                ])

                self.present(destinationVC: TypePromptViewController(), slideDirection: .right)
            }
        }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}



extension TypeAvatarViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                
        guard let text = textField.text else { return true }
        let characterCount = text.count
        
        if characterCount < 4 || characterCount > 20 {
            showAlert(message: "Avatar ID must be between 4 and 20 characters. Please choose a different avatar ID.")
            return false
        }
        
        checkUsernameUniqueness(text)
        
        return false
    }
    
}


