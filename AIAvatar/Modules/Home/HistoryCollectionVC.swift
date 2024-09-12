import UIKit
import FirebaseFirestore
import FirebaseAuth
import SnapKit

private let reuseIdentifier = "Cell"

class HistoryCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var historyList = [History]()
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        fetchSavedVideos()
    }
    
    func setUpCollectionView() {
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
        headerLabel.text = "Saved"
        headerLabel.textColor = .white
        headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(navigationButton)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func fetchSavedVideos() {
        self.historyList.removeAll()
        self.collectionView.reloadData()

        guard let currentUser = Auth.auth().currentUser else {
            print("No authenticated user found")
            return
        }

        let docRef = Firestore.firestore().collection("id collection").document("id document")
        
        docRef.getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error getting document: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists else {
                print("Document does not exist")
                return
            }
            
            let data = document.data()
            print("Document data: \(String(describing: data))")
            
            if let savedVideoURLs = data?["promptResult"] as? [String] {
                self?.historyList = savedVideoURLs.map { History(mediaURLString: $0) } 
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            } else {
                print("No promptResult field found in document or it's not an array of strings")
            }
        }
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HistoryCollectionViewCell
        let history = historyList[indexPath.item]
        cell.configure(with: history)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 60) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHistory = historyList[indexPath.item]
        let detailsVC = HistoryDetailsVC()
        detailsVC.historyList = [selectedHistory]
        present(destinationVC: detailsVC, slideDirection: .right
        
        )
    }

    @objc func navigate() {
        self.present(destinationVC: CreateFromPromptViewController(), slideDirection: .right)
    }
}
