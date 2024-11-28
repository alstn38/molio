import Combine
import UIKit

final class SplashViewController: UIViewController {
    private let viewModel: SplahViewModel
    private var input: SplahViewModel.Input
    private var output: SplahViewModel.Output
    
    private let viewDidLoadPublisher = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let molioTitleLabel: UILabel = {
        let label = UILabel()
        label.molioBold(text: StringLiterals.title, size: 72)
        label.textColor = .main
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let molioSubTitleLabel: UILabel = {
        let label = UILabel()
        label.molioMedium(text: StringLiterals.subTitle, size: 17)
        label.textColor = UIColor(hex: "#8D9F9B")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: SplahViewModel) {
        self.viewModel = viewModel
        self.input = SplahViewModel.Input(viewDidLoad: viewDidLoadPublisher.eraseToAnyPublisher())
        self.output = viewModel.transform(from: input)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        viewDidLoadPublisher.send()
        setupHierarchy()
        setupConstraint()
        setupBindings()
    }
    
    private func setupBindings() {
        output.navigateToNextScreen
            .receive(on: RunLoop.main)
            .sink { [weak self] nextScreenType in
                guard let self else { return }
                self.switchNextViewController(nextScreenType)
            }
            .store(in: &cancellables)
    }
    
    private func switchNextViewController(_ nextScreenType: SplahViewModel.NextScreenType) {
        let nextViewController = switch nextScreenType {
        case .login:
            LoginViewController(viewModel: LoginViewModel())
        case .main:
            MolioTabBarController()
        }
        
        guard let window = self.view.window else { return }
        
        UIView.transition(with: window, duration: 0.5) {
            nextViewController.view.alpha = 0.0
            window.rootViewController = nextViewController
            nextViewController.view.alpha = 1.0
        }
        
        window.makeKeyAndVisible()
    }
    
    private func setupHierarchy() {
        view.addSubview(titleStackView)
        titleStackView.addArrangedSubview(molioTitleLabel)
        titleStackView.addArrangedSubview(molioSubTitleLabel)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            titleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension SplashViewController {
    enum StringLiterals {
        static let title: String = "molio"
        static let subTitle: String = "음악 취향을 모르겠다면, 몰리오!"
    }
}