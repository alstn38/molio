//import XCTest
//@testable import Molio
//
//final class MusicDeckTests: XCTestCase {
//    private var sut: RandomMusicDeck!
//    
//    override func setUpWithError() throws {
//        let mockPlaylist = MolioPlaylist.mock
//        let mockPublishCurrentPlaylistUseCase = MockPublishCurrentPlaylistUseCase(mockPlaylist: mockPlaylist)
//        let mockFetchRecommendedMusicUseCase = MockFetchRecommendedMusicUseCase()
//        sut = RandomMusicDeck(
//            publishCurrentPlaylistUseCase: mockPublishCurrentPlaylistUseCase,
//            fetchRecommendedMusicUseCase: mockFetchRecommendedMusicUseCase
//        )
//    }
//    
//    override func tearDownWithError() throws {
//        sut = nil
//    }
//    
//    func test_RandomMusicDeck_초기화시_fetchRecommendedMusicUseCase_유즈케이스를_한_번_실행한다() async throws {
//        // Given
//        let mockFetchRecommendedMusicUseCase = MockFetchRecommendedMusicUseCase()
//        
//        // When
//        sut = RandomMusicDeck(fetchRecommendedMusicUseCase: mockFetchRecommendedMusicUseCase)
//        
//        // Then
//        XCTAssertEqual(1, mockFetchRecommendedMusicUseCase.excutedCount)
//    }
//    
//    func test_reset_호출하면_fetchRecommendedMusicUseCase_유즈케이스를_실행한다()  async throws {
//        // Given
//        let mockFetchRecommendedMusicUseCase = MockFetchRecommendedMusicUseCase()
//        sut = RandomMusicDeck(fetchRecommendedMusicUseCase: mockFetchRecommendedMusicUseCase)
//        let prevExcutedCount = mockFetchRecommendedMusicUseCase.excutedCount
//        
//        // When
//        sut.reset(with: MusicFilter(genres: []))
//        
//        // Then
//        XCTAssertEqual(prevExcutedCount + 1, mockFetchRecommendedMusicUseCase.excutedCount)
//    }
    
//    private var deck: RandomMusicDeck = {
//        return RandomMusicDeck()
//    }()
//    
//    func testDeckFetch() async {
//        let subscription = deck.randomMusics.sink { randomMusics in
//            print(randomMusics)
//        }
//        
//        Thread.sleep(forTimeInterval: 1)
//    }
//    
//    func testDeckSwipe() {
//        Thread.sleep(forTimeInterval: 1)
//        
//        let subscription = deck.randomMusics
//            .sink { randomMusics in
//                print("노래 5곡:", randomMusics.prefix(5).map { $0.title }.joined(separator: ", "))
//            }
//        
//        let currentMusicPublisher = deck.currentMusicTrackModelPublisher
//        let nextMusicPublisher = deck.nextMusicTrackModelPublisher
//        
//        let currentMusicSubscription = currentMusicPublisher
//            .sink { music in
//                print("현재 노래:", music?.title ?? "비어있습니다.")
//            }
//
//        let nextMusicSubscription = nextMusicPublisher
//            .sink { music in
//                print("다음 노래:", music?.title ?? "비어있습니다.")
//            }
//
//        for i in 0 ..< 50 {
//            Thread.sleep(forTimeInterval: 1)
//
//            deck.likeCurrentMusic()
//        }
//    }
//}
