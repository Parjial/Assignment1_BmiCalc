import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var measurementSegmentedControl: UISegmentedControl!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInputFields()
    }

    @IBAction func measurementChanged(_ sender: UISegmentedControl) {
        updateInputFields()
    }
    
    @IBAction func calculateBMI(_ sender: UIButton) {
        guard let heightText = heightTextField.text, let weightText = weightTextField.text,
              let height = Double(heightText), let weight = Double(weightText) else {
            resultLabel.text = "Please enter valid numbers."
            return
        }
        
        // Validate inputs
        if height <= 0 || weight <= 0 {
            resultLabel.text = "No negative values allowed."
            return
        }

        let bmi: Double
        if measurementSegmentedControl.selectedSegmentIndex == 0 { // SI
            bmi = weight / ((height / 100) * (height / 100)) // kg/m²
        } else { // Imperial
            bmi = (weight / (height * height)) * 703 // lb/in² * 703
        }
        
        let category = getBMICategory(bmi)
        resultLabel.text = String(format: "Your BMI: %.2f (%@)", bmi, category)
    }
    
    func updateInputFields() {
        if measurementSegmentedControl.selectedSegmentIndex == 0 {
            heightTextField.placeholder = "Height (cm)"
            weightTextField.placeholder = "Weight (kg)"
        } else {
            heightTextField.placeholder = "Height (in)"
            weightTextField.placeholder = "Weight (lb)"
        }
        heightTextField.text = ""
        weightTextField.text = ""
        resultLabel.text = ""
    }
    
    func getBMICategory(_ bmi: Double) -> String {
        switch bmi {
        case ..<18.5: return "Underweight"
        case 18.5..<24.9: return "Normal weight"
        case 25..<29.9: return "Overweight"
        default: return "Obesity"
        }
    }
}
