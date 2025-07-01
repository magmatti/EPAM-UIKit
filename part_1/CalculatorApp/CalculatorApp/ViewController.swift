import UIKit

class ViewController: UIViewController {

    private let displayLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: 340, height: 60))
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 32)
        label.text = "0"
        label.backgroundColor = .lightGray
        label.textColor = .black
        return label
    }()

    private let operationLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 60, width: 340, height: 30))
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.text = ""
        return label
    }()

    private var currentNumber: String = ""
    private var previousNumber: Double?
    private var currentOperation: String?
    private var isTypingNumber = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(displayLabel)
        view.addSubview(operationLabel)
        setupButtons()
    }

    private func setupButtons() {
        let buttonTitles: [[String]] = [
            ["7", "8", "9", "/"],
            ["4", "5", "6", "*"],
            ["1", "2", "3", "-"],
            ["0", "C", "=", "+"]
        ]

        let buttonWidth: CGFloat = 80
        let buttonHeight: CGFloat = 60
        let padding: CGFloat = 10

        for (rowIndex, row) in buttonTitles.enumerated() {
            for (colIndex, title) in row.enumerated() {
                let x = CGFloat(colIndex) * (buttonWidth + padding) + 20
                let y = CGFloat(rowIndex) * (buttonHeight + padding) + 180
                let button = UIButton(frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight))
                button.setTitle(title, for: .normal)
                button.backgroundColor = .darkGray
                button.setTitleColor(.white, for: .normal)
                button.layer.cornerRadius = 10
                button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                view.addSubview(button)
            }
        }
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }

        switch title {
        case "0"..."9":
            handleNumberInput(title)
        case "+", "-", "*", "/":
            handleOperation(title)
        case "=":
            calculateResult()
        case "C":
            clear()
        default:
            break
        }
    }

    private func handleNumberInput(_ digit: String) {
        if isTypingNumber {
            currentNumber += digit
        } else {
            currentNumber = digit
            isTypingNumber = true
        }
        displayLabel.text = currentNumber
    }

    private func handleOperation(_ operation: String) {
        if let value = Double(currentNumber) {
            previousNumber = value
            currentOperation = operation
            isTypingNumber = false
            operationLabel.text = "\(currentNumber) \(operation)"
        }
    }

    private func calculateResult() {
        guard let operation = currentOperation,
              let prev = previousNumber,
              let current = Double(currentNumber) else { return }

        var result: Double?

        switch operation {
        case "+":
            result = prev + current
        case "-":
            result = prev - current
        case "*":
            result = prev * current
        case "/":
            result = current != 0 ? prev / current : nil
        default:
            break
        }

        if let result = result {
            displayLabel.text = "\(result)"
            currentNumber = "\(result)"
            operationLabel.text = ""
        } else {
            displayLabel.text = "Nan"
            currentNumber = ""
            operationLabel.text = ""
        }

        previousNumber = nil
        currentOperation = nil
        isTypingNumber = false
    }

    private func clear() {
        currentNumber = ""
        previousNumber = nil
        currentOperation = nil
        isTypingNumber = false
        displayLabel.text = "0"
        operationLabel.text = ""
    }
}
