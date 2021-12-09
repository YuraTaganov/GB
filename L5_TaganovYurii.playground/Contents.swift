import Foundation

// 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
// 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
// 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
// 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
// 6. Вывести сами объекты в консоль.

// MARK: - Enums

enum EngineState {
    case on
    case off
}

enum WindowsState {
    case open
    case close
}

enum TruckType {
    case refrigirator
    case semitrunk
    case tank
}

enum DriveMode {
    case city
    case sport
    case drift
    case drag
}

// MARK: - CarProtocol

protocol CarProtocol {
    var brand: String { get set }
    var color: String { get set }
    var year: Int { get set }
    var km: Double { get set }
    var engineState: EngineState { get set }
    var windowsState: WindowsState { get set }

    func drive()
}

// MARK: - Extension CarProtocol

extension CarProtocol {

    mutating func engineOn() {
        switch engineState {
        case .on:
            print("The engine is already on")
        case .off:
            engineState = .on
            print("Engine on")
        }
    }

    mutating func engineOff() {
        switch engineState {
        case .on:
            engineState = .off
            print("Engine off")
        case .off:
            print("The engine is already off")
        }
    }

    mutating func openWindows() {
        switch windowsState {
        case .open:
            print("The windows are already open")
        case .close:
            windowsState = .open
            print("The windows are open")
        }
    }

    mutating func closeWindows() {
        switch windowsState {
        case .open:
            windowsState = .close
            print("The windows are closed")
        case .close:
            print("The windows are already closed")
        }
    }

}

// MARK: - Classes

final class TrunkCar: CarProtocol {
    var brand: String
    var color: String
    var year: Int
    var km: Double
    var engineState: EngineState
    var windowsState: WindowsState
    var capacity: Int
    var truckType: TruckType

    init(brand: String,
         color: String,
         year: Int,
         km: Double,
         engineState: EngineState,
         windowsState: WindowsState,
         capacity: Int,
         truckType: TruckType)
    {
        self.brand = brand
        self.color = color
        self.year = year
        self.km = km
        self.engineState = engineState
        self.windowsState = windowsState
        self.capacity = capacity
        self.truckType = truckType
    }

    func drive() {
        switch engineState {
        case .off:
            engineState = .on
            print("Engine \(engineState). \(brand) is ready to race!")
        case .on:
            print("The engine is already on. \(brand) is ready to race!")
        }
    }
}

final class SportCar: CarProtocol {
    var brand: String
    var color: String
    var year: Int
    var km: Double
    var engineState: EngineState
    var windowsState: WindowsState
    var isSpoilerEnable: Bool
    var driveMode: DriveMode

    init(brand: String,
         color: String,
         year: Int,
         km: Double,
         engineState: EngineState,
         windowsState: WindowsState,
         isSpoilerEnable: Bool,
         driveMode: DriveMode)
    {
        self.brand = brand
        self.color = color
        self.year = year
        self.km = km
        self.engineState = engineState
        self.windowsState = windowsState
        self.isSpoilerEnable = isSpoilerEnable
        self.driveMode = driveMode
    }

    func drive() {
        switch engineState {
        case .off:
            engineState = .on
            print("\nEngine \(engineState). \(brand) is ready to race!")
        case .on:
            print("\nThe engine is already on. \(brand) is ready to race!")
        }
    }
}

// MARK: - CustomStringConvertible Extensions

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "\nTrunk car\nBrand: \(brand)\nColor: \(color)\nYear: \(year)\nKm: \(km)\nEngine state: \(engineState)\nWindows State: \(windowsState)\nCapacity: \(capacity)\nTruck type: \(truckType)"
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "\nSport car\nBrand: \(brand)\nColor: \(color)\nYear: \(year)\nKm: \(km)\nEngine state: \(engineState)\nWindows State: \(windowsState)\nSpoiler: \(isSpoilerEnable)\nDrive mode: \(driveMode)"
    }
}

// MARK: - Initialization

var sportCarBugatti = SportCar(brand: "Bugatti", color: "White", year: 1991, km: 200, engineState: .off, windowsState: .close, isSpoilerEnable: true, driveMode: .drift)
sportCarBugatti.engineOn()
sportCarBugatti.openWindows()
print(sportCarBugatti.description)
sportCarBugatti.engineOff()
sportCarBugatti.drive()

var sportCarMcLaren = SportCar(brand: "McLaren",color: "Black", year: 2010, km: 100, engineState: .off, windowsState: .close, isSpoilerEnable: false, driveMode: .drag)
sportCarMcLaren.engineOn()
print(sportCarMcLaren.description)
sportCarMcLaren.drive()

var trunkCarMAN = TrunkCar(brand: "MAN", color: "Gray", year: 2016, km: 499950, engineState: .on, windowsState: .open, capacity: 8000, truckType: .refrigirator)
trunkCarMAN.closeWindows()
print(trunkCarMAN.description)
trunkCarMAN.drive()

var trunkCarKamaz = TrunkCar(brand: "Kamaz", color: "Orange", year: 2001, km: 800010, engineState: .off, windowsState: .close, capacity: 6000, truckType: .tank)
print(trunkCarKamaz.description)
trunkCarKamaz.drive()
