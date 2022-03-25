//
//  resultsViewController.swift
//  curdle
//
//  Created by Kartik Narayanan on 04/03/22.
//

import UIKit
import Charts


class resultsViewController: UIViewController {
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var playedLabel: UILabel!
    @IBOutlet weak var wonLabel: UILabel!
    @IBOutlet weak var currentStreakLabel: UILabel!
    @IBOutlet weak var maxStreakLabel: UILabel!
    @IBOutlet weak var avgTimeLabel: UILabel!

    @IBOutlet weak var radarChart: BarChartView!

    
    var resultGameStats = GameStats()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(resultGameStats)
        
        playedLabel.text = String(resultGameStats.gamesPlayed)
        wonLabel.text = String(resultGameStats.winPercent)
        currentStreakLabel.text = String(resultGameStats.currentStreak)
        maxStreakLabel.text = String(resultGameStats.maxStreak)
        avgTimeLabel.text = String(resultGameStats.avgTimeToWin)
        
       // setChartData()
        
      //  formatChart()
        
        setChartData2()
        formatChart2()
        
    }
    

    
    @IBAction func dismissScreen(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func setChartData2() {
        let blueDataSet = BarChartDataSet(
            entries: [
                BarChartDataEntry(x: 0.0, y: Double(resultGameStats.attemptDistribution[0])),
                BarChartDataEntry(x: 1.0, y: Double(resultGameStats.attemptDistribution[1])),
                BarChartDataEntry(x: 2.0, y: Double(resultGameStats.attemptDistribution[2])),
                BarChartDataEntry(x: 3.0, y: Double(resultGameStats.attemptDistribution[3])),
                BarChartDataEntry(x: 4.0, y: Double(resultGameStats.attemptDistribution[4])),
                BarChartDataEntry(x: 5.0, y: Double(resultGameStats.attemptDistribution[5])),
                
            ]
        )
        
        let data = BarChartData(dataSets: [blueDataSet])
        
        
        radarChart.data = data
    
        
        
        
            // 3
        blueDataSet.valueFormatter = DataSetValueFormatter()
    }
    
    func formatChart2() {
        
        
        
        
        radarChart.drawValueAboveBarEnabled = false
        
        radarChart.borderLineWidth = 1.5
        radarChart.tintColor = .lightGray
        radarChart.backgroundColor = .darkGray
        radarChart.borderColor = .systemBlue
        
            // 3
        let xAxis = radarChart.xAxis
        xAxis.labelFont = .systemFont(ofSize: 12, weight: .bold)
        xAxis.labelTextColor = .blue
        xAxis.xOffset = 10
        xAxis.yOffset = 10
        xAxis.valueFormatter = XAxisFormatter()
        
            // 4
       
        
            // 5

        radarChart.legend.enabled = true
    }
    

    
    
    func setChartData() {

        
        let redDataSet = RadarChartDataSet(
            entries: [
                RadarChartDataEntry(value: Double(resultGameStats.attemptDistribution[0])),
                RadarChartDataEntry(value: Double(resultGameStats.attemptDistribution[1])),
                RadarChartDataEntry(value: Double(resultGameStats.attemptDistribution[2])),
                RadarChartDataEntry(value: Double(resultGameStats.attemptDistribution[3])),
                RadarChartDataEntry(value: Double(resultGameStats.attemptDistribution[4])),
                RadarChartDataEntry(value: Double(resultGameStats.attemptDistribution[5])),

            ]
        )
    //    print(resultGameStats.attemptDistribution)

        let data = RadarChartData(dataSets: [redDataSet])
        

        radarChart.data = data
        
        redDataSet.lineWidth = 2
        

        let redColor = Colors.matchColor(matchtype: .imperfect)
        let redFillColor = Colors.matchColor(matchtype: .perfect)
        redDataSet.colors = [redColor]
        redDataSet.fillColor = redFillColor
        redDataSet.drawFilledEnabled = true
        
            // 3
        redDataSet.valueFormatter = DataSetValueFormatter()
    }
    
 /*   func formatChart() {
        

        
        
        radarChart.webLineWidth = 1.5
        radarChart.innerWebLineWidth = 1.5
        radarChart.webColor = .lightGray
        radarChart.innerWebColor = .lightGray
        
            // 3
        let xAxis = radarChart.xAxis
        xAxis.labelFont = .systemFont(ofSize: 9, weight: .bold)
        xAxis.labelTextColor = Colors.matchColor(matchtype: .no)
        xAxis.xOffset = 10
        xAxis.yOffset = 10
        xAxis.valueFormatter = XAxisFormatter()
        
            // 4
        let yAxis = radarChart.yAxis
        yAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        yAxis.labelCount = 5
        yAxis.drawTopYLabelEntryEnabled = false
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = Double(resultGameStats.attemptDistribution.max()!)
        yAxis.valueFormatter = YAxisFormatter()
        
            // 5
        radarChart.rotationEnabled = false
        radarChart.legend.enabled = false
    }
    
*/

}
class DataSetValueFormatter: IValueFormatter {
    
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        ""
    }
}

    // 2
class XAxisFormatter: IAxisValueFormatter {
    
    let titles = "123456".map { "\($0)" }
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        titles[Int(value) % titles.count]
    }
}

    // 3
class YAxisFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        "\(Int(value)) "
    }
}
