
import XCTest
@testable import EspacioX

class LaunchListPresenterTests: XCTestCase {
    
    // Explicitly wrapping is okay here as its a test case
    private var sut: LaunchListDefaultPresenter!
    private var view: MockLaunchListViewController!
    private var interactor: MockLaunchListInteractor!
    private var router: MockLaunchListRouter!
    
    override func tearDown() {
        sut = nil
        view = nil
        interactor = nil
        router = nil
    }
    
    private func createFlow(withLaunchFetchResult result: NetworkResult<[Launch]>,
                            nextLaunchFetchResult nextLaunchResult: NetworkResult<Launch>) {
        interactor = MockLaunchListInteractor(withUpcompingLaunchResult: result,
                                              nextLaunchResult: nextLaunchResult)
        
        router = MockLaunchListRouter()
        sut = LaunchListDefaultPresenter(withInteractor: interactor,
                                         router: router)
        view = MockLaunchListViewController(withPresenter: sut)
        
        sut.attachView(view: view)
        sut.viewDidLoad()
    }
    
    func testNextLaunchFetchFailFlow() {
        let errorMessage = "Test Network Error"
        let result = NetworkResult<[Launch]>.success(value: [MockLaunchBuilder.build()])
        let nextLaunchResult = NetworkResult<Launch>.success(value: MockLaunchBuilder.build())
        
        createFlow(withLaunchFetchResult: result,
                   nextLaunchFetchResult: nextLaunchResult)
        
        XCTAssert(view.didCall.performInitialSetup)
        XCTAssert(interactor.didCall.fetchUpcomingLaunches)
        XCTAssert(interactor.didCall.fetchNextLaunch)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            XCTAssert(self.view.didCall.hideLoader)
            XCTAssert(self.router.didCall.presentAlert)
            XCTAssert(self.router.didUpdate.errorAlertMessage(to: errorMessage))
        }
    }
    
    func testUpcomingLaunchFetchFailFlow() {
        let errorMessage = "Test Network Error"
        let result = NetworkResult<[Launch]>.failure(error: LaunchFetchError.network(description: errorMessage))
        let nextLaunchResult = NetworkResult<Launch>.success(value: MockLaunchBuilder.build())
        createFlow(withLaunchFetchResult: result,
                   nextLaunchFetchResult: nextLaunchResult)
        
        XCTAssert(view.didCall.performInitialSetup)
        XCTAssert(interactor.didCall.fetchUpcomingLaunches)
        XCTAssert(interactor.didCall.fetchNextLaunch)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            XCTAssert(self.view.didCall.hideLoader)
            XCTAssert(self.router.didCall.presentAlert)
            XCTAssert(self.router.didUpdate.errorAlertMessage(to: errorMessage))
        }
    }
    
    func testSuccessfulFlow() {
        let result = NetworkResult<[Launch]>.success(value: [MockLaunchBuilder.build()])
        let nextLaunchResult = NetworkResult<Launch>.success(value: MockLaunchBuilder.build())
        
        createFlow(withLaunchFetchResult: result,
                   nextLaunchFetchResult: nextLaunchResult)
        
        XCTAssert(view.didCall.performInitialSetup)
        XCTAssert(interactor.didCall.fetchUpcomingLaunches)
        XCTAssert(interactor.didCall.fetchNextLaunch)
        XCTAssert(view.didUpdate.title(to: "EspacioX"))
        XCTAssert(view.didCall.showLoader)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            XCTAssert(self.view.didCall.hideLoader)
            XCTAssert(self.view.didCall.reloadView)
            XCTAssertFalse(self.router.didCall.presentAlert)
            XCTAssert(self.router.didUpdate.errorAlertMessage(to: nil))
        }
    }
}
