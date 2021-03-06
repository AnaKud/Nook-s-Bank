// ProphetPricesModels.swift
// Created by Anastasiya Kudasheva on 08.07.2021.

import UIKit

enum ProphetPrices {
    enum Turnip {
        struct Request { // swiftlint:disable:this nesting
            let buyPrice: Int
            let mondayMorning: Int?
            let mondayEvening: Int?
            let tuesdayMorning: Int?
            let tuesdayEvening: Int?
            let wednesdayMorning: Int?
            let wednesdayEvening: Int?
            let thursdayMorning: Int?
            let thursdayEvening: Int?
            let fridayMorning: Int?
            let fridayEvening: Int?
            let saturdayMorning: Int?
            let saturdayEvening: Int?
            init(from model: TurnipPrices?) {
                self.buyPrice = model?.buyPrice ?? 0
                self.mondayMorning = model?.mondayMorning
                self.mondayEvening = model?.mondayEvening
                self.tuesdayMorning = model?.tuesdayMorning
                self.tuesdayEvening = model?.tuesdayEvening
                self.wednesdayMorning = model?.wednesdayMorning
                self.wednesdayEvening = model?.wednesdayEvening
                self.thursdayMorning = model?.thursdayMorning
                self.thursdayEvening = model?.thursdayEvening
                self.fridayMorning = model?.fridayMorning
                self.fridayEvening = model?.fridayEvening
                self.saturdayMorning = model?.saturdayMorning
                self.saturdayEvening = model?.saturdayEvening
            }
            func pricesArray() -> [Int?] {
				return [
					self.mondayMorning,
					self.mondayEvening,
					self.tuesdayMorning,
					self.tuesdayEvening,
					self.wednesdayMorning,
					self.wednesdayEvening,
					self.thursdayMorning,
					self.thursdayEvening,
					self.fridayMorning,
					self.fridayEvening,
					self.saturdayMorning,
					self.saturdayEvening
				]
            }
        }
        struct Response { // swiftlint:disable:this nesting
            let minWeekValue: Int
            let minMaxPattern: [[Int]]
            let avgPattern: [Int]
            let existingPrices: [Int?]
            let preview: String
            init(from apiResponse: TurnipResponse?, existingPrices: [Int?]) {
                self.minWeekValue = apiResponse?.minWeekValue ?? 0
                self.minMaxPattern = apiResponse?.minMaxPattern ?? [[Int]]()
                self.avgPattern = apiResponse?.avgPattern ?? [Int]()
                self.existingPrices = existingPrices
                self.preview = apiResponse?.preview ?? ""
            }
        }
        struct ViewModel { // swiftlint:disable:this nesting
            struct Prices { // swiftlint:disable:this nesting
                let minimumPrice: Int
                let graphLink: String
                let minMaxPattern: [[Int]]
                let expectedPrices: [Int]
                let existingPrices: [Int?]
                init(from response: ProphetPrices.Turnip.Response) {
                    self.minimumPrice = response.minWeekValue
                    self.graphLink = response.preview
                    self.minMaxPattern = response.minMaxPattern
                    self.expectedPrices = response.avgPattern
                    self.existingPrices = response.existingPrices
                }
                func getDayPrice(for priceType: PriceType) -> DayPrices {
                    let index = priceType.rawValue
                    return DayPrices(priceType: priceType,
									 existingPrice: existingPrices[index],
									 patternPrice: minMaxPattern[index],
									 expectedPrice: expectedPrices[index])
                }
            }
            struct PriceForGraph { // swiftlint:disable:this nesting
                let pricesData: [Double]?
                init(prices: ProphetPrices.Turnip.ViewModel.Prices) {
                    if prices.minimumPrice == 0 {
                        self.pricesData = nil
                    } else {
                        var result = [Double]()
                        var index = 0
                        for item in prices.existingPrices {
                            if let item = item {
                                result.append(Double(item))
                            } else {
                                result.append(Double(prices.expectedPrices[index]))
                            }
                            index += 1
                        }
                        self.pricesData = result
                    }
                }
            }

            struct DayPrices { // swiftlint:disable:this nesting
                let priceType: PriceType
                let existingPrice: Int?
                let patternPrice: [Int]
                let expectedPrice: Int
            }

            struct Dates { // swiftlint:disable:this nesting
                let dates: [String]? = DatesOfCurrentWeek().getWeekDates()

                func dateForView(forDayWeek dayWeek: WeekDay) -> String? {
                    let index = dayWeek.rawValue
                    return dates?[index]
                }
            }
        }
    }
    enum PriceType: Int {
        case mondayMorning
        case mondayEvening

        case tuesdayMorning
        case tuesdayEvening

        case wednesdayMorning
        case wednesdayEvening

        case thursdayMorning
        case thursdayEvening

        case fridayMorning
        case fridayEvening

        case saturdayMorning
        case saturdayEvening
    }
}
