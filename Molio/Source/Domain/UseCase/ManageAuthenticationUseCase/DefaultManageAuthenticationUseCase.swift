struct DefaultManageAuthenticationUseCase: ManageAuthenticationUseCase {
    private let authStateRepository: AuthStateRepository
    
    init(authStateRepository: AuthStateRepository = DIContainer.shared.resolve()) {
        self.authStateRepository = authStateRepository
    }
    
    func isAuthModeSelected() -> Bool {
        return authStateRepository.authSelection == .selected
    }
    
    func getAuthMode() -> AuthMode {
        return authStateRepository.authMode
    }
    
    func setAuthMode(_ mode: AuthMode) {
        authStateRepository.setAuthMode(mode)
        setAuthSelection(.selected)
    }
    
    private func setAuthSelection(_ selection: AuthSelection) {
        authStateRepository.setAuthSelection(selection)
    }
}
