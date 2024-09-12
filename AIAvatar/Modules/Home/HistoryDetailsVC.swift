import UIKit
import AVKit
import SDWebImage

class HistoryDetailsVC: UIViewController {

    var historyList: [History]?

    private let imageView = UIImageView()
    private let playerViewController = AVPlayerViewController()
    private let closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpUI()
        configure(with: historyList?.first)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: playerViewController.player?.currentItem)
    }

    private func setUpUI() {
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.width.height.equalTo(40)
        }

        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with history: History?) {
        guard let history = history, let url = URL(string: history.mediaURLString) else { return }

        let fileExtension = url.pathExtension.lowercased()
        switch fileExtension {
        case "mp4":
            configureForVideo(with: url)
        case "jpg", "jpeg", "png":
            configureForImage(with: url)
        default:
            print("Unsupported file type")
            imageView.image = UIImage(named: "placeholder")
            playerViewController.view.removeFromSuperview()
        }
    }

    private func configureForVideo(with url: URL) {
        imageView.removeFromSuperview()
        
        let player = AVPlayer(url: url)
        playerViewController.player = player
        playerViewController.view.frame = view.bounds
        view.addSubview(playerViewController.view)
        playerViewController.player?.play()
    }

    private func configureForImage(with url: URL) {
        playerViewController.view.removeFromSuperview()
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
    }

    @objc private func playerDidFinishPlaying(notification: NSNotification) {
        dismiss(animated: true, completion: nil)
    }

    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: playerViewController.player?.currentItem)
    }
}
