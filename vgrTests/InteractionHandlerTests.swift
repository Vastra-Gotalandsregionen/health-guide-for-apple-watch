import XCTest

@testable import vgr
class InteractionHandlerTests: XCTestCase {

    var sut: InteractionHandler!
    
    override func setUp() {
        super.setUp()
        sut = InteractionHandler()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testThatInteractionIsAdded() {
        sut.newInteraction(interaction: Interaction(keyword: "", answer: ""))
        
        guard let interactions = sut.getInteractions() else {
            XCTFail("No interactions")
            return
        }
        
        XCTAssertGreaterThan(interactions.count, 0)
    }
    
    func testThatInteractionIsFound() {
        sut.newInteraction(interaction: Interaction(keyword: "snuva", answer: "svar: snuva"))
        sut.newInteraction(interaction: Interaction(keyword: "Hosta", answer: "svar: Hosta"))
        sut.newInteraction(interaction: Interaction(keyword: "förkylning", answer: "svar: förkylning"))
        sut.newInteraction(interaction: Interaction(keyword: "flämta", answer: "svar: flämta"))
        
        guard let foundInteraction = sut.findInteraction(question: "jag har förkylning, så det så") else {
            XCTFail("no interaction found")
            return
        }
        
        XCTAssertEqual(foundInteraction.answer, "svar: förkylning")
        
    }
}
