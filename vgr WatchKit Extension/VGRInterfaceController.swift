import WatchKit
import Foundation


class VGRInterfaceController: WKInterfaceController {
    
    var questions = [String]()
    
    @IBOutlet var historyTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    override func didAppear() {
        
    }
    
    func updateQuestions(_ question: String) {
        questions.append(question)
        setupTable()
    }
}

extension VGRInterfaceController {
    
    func setupTable() {
        historyTable.setNumberOfRows(questions.count, withRowType: "HistoryTableRowController")
        
        for index in 0..<questions.count {
            let question = questions[index]
            let row = historyTable.rowController(at: index) as! HistoryTableRowController
            row.historyLabel.setText(question)
        }
    }
}
