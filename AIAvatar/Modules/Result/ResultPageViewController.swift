import UIKit
import NeonSDK
import AVFoundation
import Photos

class ResultPageViewController: UIViewController {
    
    
    let yourAvatarLabel = UILabel()
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var videoURL: URL?
    var yourAvatarPromptText: String = ""
    var yourAvatarIdText: String?
    let promptResult = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        if let videoURL = videoURL {
            playVideo(from: videoURL)
        }
        
        fetchAvatarIDFromFirebase()
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
        navigationButton.addTarget(self, action: #selector(navigate), for: .touchUpInside)
        view.addSubview(navigationButton)
        navigationButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        let shareButton = CustomButton()
        shareButton.configureNavigationButton(imageName: "share")
        view.addSubview(shareButton)
        shareButton.addTarget(self, action: #selector(shareWithOthers), for: .touchUpInside)
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        view.addSubview(promptResult)
        promptResult.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.width.height.equalTo(350)
        }
        
        view.addSubview(yourAvatarLabel)
        yourAvatarLabel.textColor = .white
        yourAvatarLabel.font = Font.custom(size: 18, fontWeight: .Bold)
        yourAvatarLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(promptResult.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(300)
            
        }
        let yourAvatarPrompt = UILabel()
        view.addSubview(yourAvatarPrompt)
        yourAvatarPrompt.text = yourAvatarPromptText
        yourAvatarPrompt.textColor = .gray
        yourAvatarPrompt.backgroundColor = .textAreaColor
        yourAvatarPrompt.layer.cornerRadius = 15
        yourAvatarPrompt.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(yourAvatarLabel.snp.bottom).offset(10)
            make.width.equalTo(350)
            make.height.equalTo(140)
        }
        
        let saveButton = CustomButton()
        saveButton.configureResultButton(title: "Save", titleColor: .black, bgColor: .buttonColor, iconName: "square.and.arrow.down", borderColor: .buttonColor)
        saveButton.addTarget(self, action: #selector(saveMediaToPhotosAlbum), for: .touchUpInside)
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(view.snp.centerX).offset(-160)
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
        
        let refreshButton = CustomButton()
        refreshButton.configureResultButton(title: "Refresh", titleColor: .white, bgColor: .black, iconName: "arrow.clockwise", borderColor: .buttonColor)
        refreshButton.addTarget(self, action: #selector(requestAgain), for: .touchUpInside)
        view.addSubview(refreshButton)
        refreshButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalTo(view.snp.centerX).offset(160)
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
    }
    func fetchAvatarIDFromFirebase() {
        FirestoreManager.getDocument(path: [
            .collection(name: "id collection"),
            .document(name: "id document") 
        ], completion: { documentID, documentData in
            if let id = documentData["id"] as? String {
                self.yourAvatarIdText = id
                self.yourAvatarLabel.text = "Avatar ID: \(id)"
            } else {
                print("Failed to retrieve Avatar ID. Please try again.")
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = promptResult.bounds
    }
    
    @objc func navigate() {
        self.present(destinationVC: StartPageViewController(), slideDirection: .left)
    }

    @objc func saveMediaToPhotosAlbum() {
        if let videoURL = promptResult as? URL {
            print("Medya bir video URL'si.")
            UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
        } else if let view = promptResult as? UIView {
            print("Medya bir UIView, bu tür desteklenmiyor.")
            if let image = view.asImage() {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                print("UIView'dan UIImage oluşturulamadı.")
            }
        } else {
            print("Desteklenmeyen medya türü.")
        }
        
        
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Hata: \(error.localizedDescription)")
        } else {
            print("Fotoğraf başarıyla kaydedildi!")
        }
    }

    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Video kaydetme hatası: \(error.localizedDescription)")
        } else {
            print("Video başarıyla kaydedildi!")
        }
    }

    @objc func requestAgain() {
        self.present(destinationVC: HistoryCollectionVC(), slideDirection: .up)
    }
    
    @objc func shareWithOthers() {
        
        let itemsToShare = [videoURL]
        let activityViewController = UIActivityViewController(activityItems: itemsToShare as [Any], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func playVideo(from url: URL) {
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = promptResult.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        
        if let playerLayer = playerLayer {
            promptResult.layer.addSublayer(playerLayer)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(replayVideo),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem
        )
        
        player?.play()
    }

    @objc func replayVideo() {
        player?.seek(to: CMTime.zero)
        player?.play()
    }
    
}
extension UIView {
    func asImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
