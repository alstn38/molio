import SwiftUI

struct UserProfileView: View {
    @StateObject var viewModel: UserProfileViewModel
    let isMyProfile: Bool
    let followRelationType: FollowRelationType?
    let friendUserID: String?
    
    var didNotificationButtonTapped: (() -> Void)?
    var didSettingButtonTapped: (() -> Void)?
    var didFollowingButtonTapped: (() -> Void)?
    var didFollowerButtonTapped: (() -> Void)?
    var didPlaylistCellTapped: ((MolioPlaylist) -> Void)?
    init(
        isMyProfile: Bool,
        followRelationType: FollowRelationType? = nil,
        viewModel: UserProfileViewModel,
        friendUserID: String? = nil
    ) {
        self.isMyProfile = isMyProfile
        self.followRelationType = followRelationType
        _viewModel = StateObject(wrappedValue: viewModel)
        self.friendUserID = friendUserID
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            } else {
                VStack {
                    // MARK: - 상단 제목 및 기어 버튼
                    HStack {
                        Text(viewModel.user?.name ?? "로그인해야 닉네임을 입력할 수 있어요")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                        
                        if isMyProfile {
                            if viewModel.isLogin {
                                Button(action: {
                                    didNotificationButtonTapped?()
                                }) {
                                    Image(systemName: "bell.fill")
                                        .foregroundStyle(.main)
                                }
                                Spacer()
                                    .frame(width: 14)
                            }
                            Button(action: {
                                didSettingButtonTapped?()
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .foregroundStyle(.main)
                            }
                        }
                    }
                    .padding(.horizontal, 22)
                    
                    // MARK: - 유저 정보 HStack
                    HStack {
                        ProfileImageView(imageURL: viewModel.user?.profileImageURL)
                        
                        GeometryReader { proxy in
                            HStack(spacing: 10) {
                                let size = CGSize(
                                    width: (proxy.size.width - 20) / 3,
                                    height: proxy.size.height
                                )
                                userInfoView(type: .playlist, value: viewModel.playlists.count, size: size)
                                            
                                Button(action: {
                                    didFollowingButtonTapped?()
                                }) {
                                    userInfoView(type: .following, value: viewModel.followings.count, size: size)
                                }
                                
                                Button(action: {
                                    didFollowerButtonTapped?()
                                }) {
                                    userInfoView(type: .follower, value: viewModel.followers.count, size: size)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 82)
                    .padding(.horizontal, 22)
                    .padding(.top, 16)
                    
                    Spacer().frame(height: 21)
                    
                    // MARK: - 유저 description
                    
                    if viewModel.currentID != nil, let description = viewModel.user?.description {
                        Text(description)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 22)
                    }
                    
                    Spacer().frame(height: 13)
                    
                    // MARK: - 팔로우 버튼
                    if !isMyProfile, let followRelationType = followRelationType {
                        FollowRelationButton(type: followRelationType)
                            .padding(.horizontal, 22)
                            .frame(height: 32)
                    }
                    
                    Spacer().frame(height: 13)
                    
                    // MARK: - 유저 플레이리스트
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack {
                            ForEach(viewModel.playlists, id: \.self) { playlist in
                                Button(action: {
                                    didPlaylistCellTapped?(playlist)
                                }) {
                                    userPlaylistRowView(playlist: playlist)
                                }
                            }
                        }
                        .padding(.horizontal, 22)
                    }
                    
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .onAppear {
            Task {
                await viewModel.fetchData(isMyProfile: isMyProfile, friendUserID: nil)
            }
        }
    }
    
    func userPlaylistRowView(playlist: MolioPlaylist) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(playlist.name)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white)
                HStack {
                    ForEach(playlist.filter.genres, id: \.self) { genre in
                        FilterTag(content: genre.description)
                    }
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.gray)
        }
        .frame(height: 70)
    }
    
    func userInfoView(type: UserInfoType, value: Int, size: CGSize) -> some View {
        VStack {
            Text(type.rawValue)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
            Text("\(value)")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
        }
        .frame(width: size.width, height: size.height)
    }
    
    enum UserInfoType: String {
        case playlist = "플레이리스트"
        case following = "팔로잉"
        case follower = "팔로워"
    }
}
