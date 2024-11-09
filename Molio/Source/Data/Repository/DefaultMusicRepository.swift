struct DefaultMusicRepository: MusicRepository {
    private let spotifyAPIService: SpotifyAPIService
    private let musicKitService: MusicKitService
    
    init(spotifyAPIService: SpotifyAPIService,
         musicKitService: MusicKitService
    ) {
        self.spotifyAPIService = spotifyAPIService
        self.musicKitService = musicKitService
    }
    
    func fetchMusics(genres: [String]) async throws -> [Music] {
        let musicFilter = MusicFilter(genres: genres)
        let isrcs = await spotifyAPIService.fetchRecommendedMusicISRCs(musicFilterEntity: musicFilter)
        
        var musics: [Music?] = []
        
        for isrc in isrcs {
            await musics.append(musicKitService.getMusic(with: isrc))
        }
        
        return musics.compactMap { $0 }
    }
}