import Foundation
import UIKit

class SaveView: UIView {
    
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        applyCornerRadius()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpUI() {
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "beyza"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.sizeToFit()
        self.backgroundColor = .buttonColor
        
        label.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }
    
    func setTitle(_ title: String) {
        label.text = title

    }
    
    private func applyCornerRadius() {
            let path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft, .bottomLeft, .topRight],
                                    cornerRadii: CGSize(width: 15, height: 15))
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = self.backgroundColor?.cgColor
            
            self.layer.mask = shapeLayer
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            applyCornerRadius()
        }
}
