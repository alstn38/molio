import UIKit

final class MolioTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarAppearance()
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        appearance.stackedLayoutAppearance.selected.iconColor = .main
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.itemPositioning = .centered
    }
    
    private func setupViewControllers() {
        let swipeMusicViewController = createSwipeMusicViewController()
        let communityViewController = createCommunityViewController()
        
        viewControllers = [
            swipeMusicViewController,
            communityViewController
        ]
    }
    
    private func createSwipeMusicViewController() -> UINavigationController {
        let swipeMusicViewModel = SwipeMusicViewModel()
        let swipeMusicViewController = SwipeMusicViewController(viewModel: swipeMusicViewModel)
        let swipeMusicViewNavigationController = UINavigationController(rootViewController: swipeMusicViewController)
        
        swipeMusicViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "house.fill"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        return swipeMusicViewNavigationController
    }
    
    private func createCommunityViewController() -> UIViewController {
        let communityViewController = CommunityViewController()
        communityViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(resource: .personCircle).withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(resource: .personCircle).withRenderingMode(.alwaysOriginal)
        )
        
        return communityViewController
    }
}