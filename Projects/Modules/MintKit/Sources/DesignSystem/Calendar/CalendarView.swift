//
//  CalendarView.swift
//  MintKit
//
//  Created by 박준하 on 2023/07/05.
//  Copyright © 2023 Mint-iOS. All rights reserved.
//

import UIKit

@available(iOS 16.0, *)
open class CalendarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCalendarView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCalendarView() {
        let calendarView = UICalendarView()
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "USA")
        calendarView.fontDesign = .rounded
        self.addSubview(calendarView)
        calendarView.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            $0.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            $0.height.equalTo(450.0)
            $0.width.equalTo(370.0)
        }
        calendarView.backgroundColor = .systemBackground
        calendarView.layer.cornerCurve = .continuous
        calendarView.layer.cornerRadius = 10.0
        calendarView.tintColor = MintKitAsset.Colors.mainColor.color
        
        calendarView.delegate = self
        calendarView.availableDateRange = DateInterval.init(start: Date.now, end: Date.distantFuture)
        let dateSelection = UICalendarSelectionMultiDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
    }
}

@available(iOS 16.0, *)
extension CalendarView: UICalendarViewDelegate {
    public func calendar(_ calendar: UICalendarView, viewFor dateComponents: DateComponents) -> UIView {
        let dateLabel = UILabel()
        dateLabel.textAlignment = .center
        
        if let weekday = dateComponents.weekday {
            let text = "\(dateComponents.day ?? 0)"
            
            let weekdayTextColor: UIColor
            switch weekday {
            case 1, 7:
                weekdayTextColor = .red
            default:
                weekdayTextColor = .blue
            }
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: weekdayTextColor,
                .font: UIFont.systemFont(ofSize: 16)
            ]
                
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            dateLabel.attributedText = attributedText
        }
        
        return dateLabel
    }
}

@available(iOS 16.0, *)
extension CalendarView: UICalendarSelectionSingleDateDelegate {

    public func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print("Selected Date:",dateComponents ?? "No selection")
    }
    
    public func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return false
    }
}

@available(iOS 16.0, *)
extension CalendarView: UICalendarSelectionMultiDateDelegate {

    public func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        print("Selected Date:",dateComponents)
    }
    
    public func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        print("De-Selected Date:",dateComponents)
    }
    
    public func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectDate dateComponents: DateComponents) -> Bool {
        return true
    }
    
    public func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canDeselectDate dateComponents: DateComponents) -> Bool {
        return true
    }
}
