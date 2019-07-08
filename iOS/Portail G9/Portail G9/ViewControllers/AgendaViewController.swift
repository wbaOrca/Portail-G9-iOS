//
//  AgendaViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 08/07/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import YMCalendar

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class AgendaViewController: UIViewController {

    @IBOutlet weak var labelCurrentDate: UILabel!
    @IBOutlet weak var calendarWeekBarView: YMCalendarWeekBarView!
    @IBOutlet weak var calendarView: YMCalendarView!
    @IBOutlet weak var buttonLeftPlanning: UIButton!
    @IBOutlet weak var buttonRightPlanning: UIButton!
    
    let symbols = ["Dim", "Lun", "Mar", "Mer", "Jeu", "Ven", "Sam"]
    var calendar = Calendar.current
    
    var mCurrentDate : Date = Date();
    var mCurrentYear = 2000;
    var mCurrentMonth = 1;
    
    
    // *******************************
    // *******************************
    // **** viewDidLoad
    // *******************************
    // *******************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mCurrentDate = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: mCurrentDate)
        mCurrentYear =  components.year ?? 2000
        mCurrentMonth = components.month ?? 1
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let strMonth = dateFormatter.string(from: mCurrentDate)
        labelCurrentDate.text = strMonth + " " + String(mCurrentYear)
        
        calendar.firstWeekday = 2
        
        /// WeekBarView
        calendarWeekBarView.appearance = self
        calendarWeekBarView.calendar = calendar
        calendarWeekBarView.backgroundColor = #colorLiteral(red: 1, green: 0.7921568627, blue: 0.09803921569, alpha: 1)
        
        
        /// MonthCalendar
        
        // Delegates
        calendarView.delegate   = self
        calendarView.dataSource = self
        calendarView.appearance = self
        calendarView.allowsMultipleSelection = false
        
        // Month calendar settings
        calendarView.calendar = calendar
        calendarView.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 0.5954301076)
        calendarView.scrollDirection = .horizontal
        calendarView.isPagingEnabled = true
        
        // Events settings
        calendarView.eventViewHeight  = 18
        calendarView.maxVisibleEvents = nil;
        var previousMonth = calendar.date(byAdding: .month, value: -3, to: mCurrentDate)
        previousMonth = calendar.startOfMonthForDate(previousMonth!)
        var lastMonth = calendar.date(byAdding: .month, value: 3, to: mCurrentDate)
        lastMonth = calendar.endOfMonthForDate(lastMonth!)
        let dateange_ = DateRange(start: previousMonth!, end: lastMonth!)
        calendarView.setDateRange(dateange_)
        calendarView.selectedDates = [mCurrentDate];
    }
    

    
    // *******************************
    // *******************************
    // **** viewDidAppear
    // *******************************
    // *******************************
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    
    
    // ***********************************
    // ******** previousMonth *******
    // ***********************************
    @IBAction func previousMonth(_ sender: Any) {
        
        let startMonth =  self.calendar.date(byAdding: .month, value: -3, to: Date())
        let previousMonth = self.calendar.date(byAdding: .month, value: -1, to: self.mCurrentDate)
        
        let components = self.calendar.dateComponents([.month], from: startMonth!, to: previousMonth!)
        let difference_months = components.month ?? 0
        if(difference_months > -1)
        {
            calendarView.scrollToDate(previousMonth!, animated: true)
        }
    }
    // ***********************************
    // ******** nextMonth ********
    // ***********************************
    @IBAction func nextMonth(_ sender: Any) {
        
        var endMonth = calendar.date(byAdding: .month, value: 3, to: Date())
        endMonth = calendar.endOfMonthForDate(endMonth!)
        
        let nextMonth = self.calendar.date(byAdding: .month, value: 1, to: self.mCurrentDate)
        
        let components = self.calendar.dateComponents([.month], from: nextMonth!, to: endMonth!)
        let difference_months = components.month ?? 0
        if(difference_months >= 1)
        {
            calendarView.scrollToDate(nextMonth!, animated: true)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// MARK: - YMCalendarWeekBarDataSource
extension AgendaViewController: YMCalendarWeekBarAppearance {
    
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func horizontalGridColor(in view: YMCalendarWeekBarView) -> UIColor {
        return .white
    }
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func verticalGridColor(in view: YMCalendarWeekBarView) -> UIColor {
        return .white
    }
    
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    // weekday: Int
    // e.g.) 1: Sunday, 2: Monday,.., 6: Friday, 7: Saturday
    func calendarWeekBarView(_ view: YMCalendarWeekBarView, textAtWeekday weekday: Int) -> String {
        return symbols[weekday - 1]
    }
    
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func calendarWeekBarView(_ view: YMCalendarWeekBarView, textColorAtWeekday weekday: Int) -> UIColor {
        switch weekday {
        case 1: // Sun
            return .lightGray
        case 7: // Sat
            return .lightGray
        default:
            return .white
        }
    }
}

// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// MARK: - YMCalendarDelegate
extension AgendaViewController: YMCalendarDelegate {
    
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func calendarView(_ view: YMCalendarView, didSelectDayCellAtDate date: Date) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        navigationItem.title = formatter.string(from: date)
        
        print("didSelectDayCellAtDate ",date)
        
        
       
        /*
            let detailsDayEventsVC = self.storyboard!.instantiateViewController(withIdentifier: "DetailsDayEventsViewController") as! DetailsDayEventsViewController
            
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            let dayNumber =  components.day ?? 1
            
            detailsDayEventsVC.mArrayPlanning = mArrayOfDaysPlanning [(dayNumber - 1)]
            detailsDayEventsVC.isVueSalle = self.isVueSalle
            
            navigationController?.pushViewController(detailsDayEventsVC, animated: true)
        */
    }
    
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func calendarView(_ view: YMCalendarView, didMoveMonthOfStartDate date: Date) {
        
        // If you want to auto select when displaying month has changed
        // view.selectDayCell(at: date)
        
        self.mCurrentDate = date
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        mCurrentYear =  components.year ?? 2000
        mCurrentMonth = components.month ?? 1
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let strMonth = dateFormatter.string(from: date)
        labelCurrentDate.text = strMonth + " " + String(mCurrentYear)
        
        
    }
    
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func calendarView(_ view: YMCalendarView, didSelectEventAtIndex index: Int, date: Date)
    {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        navigationItem.title = formatter.string(from: date)
        
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let dayNumber =  components.day ?? 1
        
        
        
    }
}

// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// MARK: - YMCalendarDataSource
extension AgendaViewController: YMCalendarDataSource {
    
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func calendarView(_ view: YMCalendarView, eventViewForEventAtIndex index: Int, date: Date) -> YMEventView {
        
        let view_ = YMEventView(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        
        
        let components = self.calendar.dateComponents([.year, .month, .day], from: date)
        let currentDay =  components.day ?? 28
        
        
        view_.backgroundColor = #colorLiteral(red: 1, green: 0.8298398852, blue: 0.2543682456, alpha: 1)
        view_.labelTitle.text = "Event"
        
        view_.layer.cornerRadius = 3
        view_.clipsToBounds = true
        
        return view_
        
    }
    
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func calendarView(_ view: YMCalendarView, numberOfEventsAtDate date: Date) -> Int {
        
        return 3;
    }
    
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func calendarView(_ view: YMCalendarView, dateRangeForEventAtIndex index: Int, date: Date) ->  DateRange? {
        
        return DateRange(start: date, end: calendar.endOfDayForDate(date))
        
    }
    
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func calendarView(_ view: YMCalendarView, styleForEventViewAt index: Int, date: Date) -> Style<UIView> {
        return Style<UIView> {
            
            let components = self.calendar.dateComponents([.year, .month, .day], from: date)
            let currentDay =  components.day ?? 28
            
            $0.backgroundColor = .orange
            
            $0.layer.cornerRadius = 3
            $0.clipsToBounds = true
            
        }
    }
    
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    
    
}
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++
// MARK: - YMCalendarAppearance
extension AgendaViewController: YMCalendarAppearance {
    // grid lines
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func weekBarHorizontalGridColor(in view: YMCalendarView) -> UIColor {
        return .white
    }
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func weekBarVerticalGridColor(in view: YMCalendarView) -> UIColor {
        return .white
    }
    
    // dayLabel
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func dayLabelAlignment(in view: YMCalendarView) -> YMDayLabelAlignment {
        return .center
    }
    
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func calendarViewAppearance(_ view: YMCalendarView, dayLabelTextColorAtDate date: Date) -> UIColor {
        let weekday = calendar.component(.weekday, from: date)
        switch weekday {
        case 1: // Sun
            return .black
        case 7: // Sat
            return .black
        default:
            return .white
        }
    }
    
    // Selected dayLabel Color
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func calendarViewAppearance(_ view: YMCalendarView, dayLabelSelectedTextColorAtDate date: Date) -> UIColor {
        return .white
    }
    // *******************************
    // *******************************
    // ****
    // *******************************
    // *******************************
    func calendarViewAppearance(_ view: YMCalendarView, dayLabelSelectedBackgroundColorAtDate date: Date) -> UIColor {
        return #colorLiteral(red: 0.7919282317, green: 0.1277886331, blue: 0.07557370514, alpha: 1)
    }
}
