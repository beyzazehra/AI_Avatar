import UIKit
import NeonSDK

class ButtonsTableViewCell: NeonTableViewCell<SettingsButton> {

    private let settingsButton = CustomButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.backgroundColor = .black
        contentView.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(10)
            make.width.equalTo(380)
            make.height.equalTo(50)
        }
    }

    override func configure(with btn: SettingsButton) {
        super.configure(with: btn)
        settingsButton.configure(with: btn)
    }
}
