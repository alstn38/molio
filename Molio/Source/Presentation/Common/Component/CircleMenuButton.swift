import UIKit

final class CircleMenuButton: UIButton {
    
    private let buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(backgroundColor: UIColor,
         buttonSize: CGFloat,
         tintColor: UIColor?,
         buttonImage: UIImage?,
         buttonImageSize: CGSize
    ) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView(backgroundColor: backgroundColor,
                  buttonSize: buttonSize,
                  tintColor: tintColor,
                  buttonImage: buttonImage)
        setupHierarchy()
        setupConstraint(buttonSize: buttonSize, buttonImageSize: buttonImageSize)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView(backgroundColor: UIColor,
                           buttonSize: CGFloat,
                           tintColor: UIColor?,
                           buttonImage: UIImage?
    ) {
        self.backgroundColor = backgroundColor
        layer.cornerRadius = buttonSize / 2
        clipsToBounds = true
        buttonImageView.tintColor = tintColor
        buttonImageView.image = buttonImage
    }
    
    private func setupHierarchy() {
        addSubview(buttonImageView)
    }
    
    private func setupConstraint(buttonSize: CGFloat, buttonImageSize: CGSize) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: buttonSize),
            self.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
        
        NSLayoutConstraint.activate([
            buttonImageView.widthAnchor.constraint(equalToConstant: buttonImageSize.width),
            buttonImageView.heightAnchor.constraint(equalToConstant: buttonImageSize.height),
            buttonImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
