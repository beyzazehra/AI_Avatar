import UIKit
import AVFoundation

class HistoryCollectionViewCell: UICollectionViewCell {

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with history: History) {
        if let url = URL(string: history.mediaURLString) {
            if url.pathExtension == "mp4" {
                // Videodan kesit (thumbnail) almak
                generateThumbnail(from: url) { [weak self] (thumbnailImage) in
                    DispatchQueue.main.async {
                        self?.imageView.image = thumbnailImage ?? UIImage(named: "videoPlaceholder")
                    }
                }
            } else {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            }
        }
    }

    private func generateThumbnail(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let asset = AVAsset(url: url)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImageGenerator.appliesPreferredTrackTransform = true

        let time = CMTime(seconds: 1.0, preferredTimescale: 600)
        
        DispatchQueue.global().async {
            do {
                let cgImage = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
                let image = UIImage(cgImage: cgImage)
                completion(image)
            } catch {
                print("Error generating thumbnail: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}

