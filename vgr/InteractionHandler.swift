
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
        return genericInteraction()
    }

    private func genericInteraction() -> Interaction {
        return Interaction(keyword: "generic", answer: "Jag är ledsen, men jag har inte något tips på detta besvär ännu. Vill du pröva på nytt?")
    }
}
