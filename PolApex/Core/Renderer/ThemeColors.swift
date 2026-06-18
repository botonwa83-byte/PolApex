import SwiftUI

extension Color {
    static let apexBackground = Color(red: 0.965, green: 0.982, blue: 0.985)
    static let apexSurface = Color.white
    static let apexInk = Color(red: 0.075, green: 0.115, blue: 0.145)
    static let apexTeal = Color(red: 0.035, green: 0.425, blue: 0.570)
    static let apexBlue = Color(red: 0.050, green: 0.300, blue: 0.620)
    static let apexRed = Color(red: 0.760, green: 0.105, blue: 0.135)
    static let apexGold = Color(red: 0.890, green: 0.610, blue: 0.130)
    static let apexEmerald = Color(red: 0.045, green: 0.540, blue: 0.365)
    static let apexViolet = Color(red: 0.375, green: 0.265, blue: 0.650)
    static let apexDanger = Color(red: 0.830, green: 0.195, blue: 0.160)

    static let stageJunior = Color(red: 0.070, green: 0.520, blue: 0.460)
    static let stageRequired = Color(red: 0.055, green: 0.325, blue: 0.680)
    static let stageElective = Color(red: 0.430, green: 0.280, blue: 0.690)
    static let stageSprint = Color(red: 0.760, green: 0.105, blue: 0.135)

    static func grade(_ grade: ImportanceGrade) -> Color {
        switch grade {
        case .s: return .apexRed
        case .a: return .apexGold
        case .b: return .apexBlue
        case .c: return .secondary
        }
    }
}
