
import Foundation

struct InteractionHandler {
    private var interactions: [Interaction]
    
    init() {
        interactions = [Interaction]()
    }
    
    func getInteractions() -> [Interaction]? {
        return interactions
    }
    
    mutating func newInteraction(interaction: Interaction) {
        interactions.append(interaction)
    }

    func findInteraction(question: String) -> Interaction? {
        for interaction in interactions {
            let keyword = interaction.keyword
            if question.lowercased().range(of: keyword) != nil {
                return interaction
            }
        }
        return nil
    }

}
