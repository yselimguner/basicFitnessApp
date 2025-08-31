//
//  ViewController.swift
//  basicFitnessApp
//
//  Created by Yavuz Selim Güner on 31.08.2025.
//

import UIKit
import HealthKit


class ViewController: UIViewController {
    
    @IBOutlet weak var noHeartView: CardView!
    @IBOutlet weak var noStepView: CardView!
    @IBOutlet weak var heartView: CardView!
    @IBOutlet weak var stepView: CardView!
    
    
    @IBOutlet weak var stepGoalLabel: UILabel!
    @IBOutlet weak var goalStepLabel: UILabel!
    @IBOutlet weak var percentProgressView: UIProgressView!
    @IBOutlet weak var stepPercentageLabel: UILabel!
    @IBOutlet weak var numberStepsLabel: UILabel!
    
    @IBOutlet weak var lastMeasurementlabel: UILabel!
    @IBOutlet weak var heartLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    let healthStore = HKHealthStore()
    let stepGoal: Double = 15000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestHealthKitAuthorization()
        goalStepLabel.text = "Hedef: \(Int(stepGoal)) adım"
    }
    
    private func requestHealthKitAuthorization() {
        if HKHealthStore.isHealthDataAvailable() {
            let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
            let heartType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
            
            let dataTypes: Set = [stepType, heartType]
            
            healthStore.requestAuthorization(toShare: [], read: dataTypes) { success, error in
                if success {
                    self.fetchTodaySteps()
                    self.fetchLastHeartRate()
                } else {
                    print("HealthKit izin reddedildi: \(String(describing: error))")
                }
            }
        }
    }
    
    private func fetchTodaySteps() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { _, result, _ in
            DispatchQueue.main.async {
                if let result = result, let sum = result.sumQuantity() {
                    let steps = sum.doubleValue(for: HKUnit.count())
                    self.updateUI(with: steps)
                    
                    self.stepView.isHidden = false
                    self.noStepView.isHidden = true
                } else {
                    self.numberStepsLabel.text = "0"
                    self.stepPercentageLabel.text = "%0"
                    self.percentProgressView.progress = 0
                    self.stepView.isHidden = true
                    self.noStepView.isHidden = false
                }
            }
        }
        
        healthStore.execute(query)
    }
    
    private func fetchLastHeartRate() {
        let heartType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: heartType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { _, samples, error in
            
            DispatchQueue.main.async {
                if let sample = samples?.first as? HKQuantitySample {
                    let heartRate = sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                    let measurementDate = sample.endDate
                    let minutesAgo = Int(Date().timeIntervalSince(measurementDate) / 60)
                    let restBPM = Int(max(60, heartRate * 0.9))
                    let activeBPM = Int(min(140, heartRate * 1.2))
                    
                    self.lastMeasurementlabel.text = "Son ölçüm: \(minutesAgo) dakika önce"
                    self.heartLabel.text = "\(Int(heartRate))"
                    self.restLabel.text = "\(restBPM) BPM"
                    self.activeLabel.text = "\(activeBPM) BPM"
                    
                    self.heartView.isHidden = false
                    self.noHeartView.isHidden = true
                } else {
                    self.heartView.isHidden = true
                    self.noHeartView.isHidden = false
                }
            }
        }
        
        healthStore.execute(query)
    }
    
    // MARK: - UI Güncelle
    private func updateUI(with steps: Double) {
        let percentage = steps / stepGoal
        let percentageText = min(percentage, 1.0) * 100
        
        numberStepsLabel.text = "\(Int(steps))"
        stepGoalLabel.text = "\(Int(max(stepGoal - steps, 0))) adım"
        stepPercentageLabel.text = "%\(Int(percentageText))"
        percentProgressView.progress = Float(min(percentage, 1.0))
    }
    
    
}

