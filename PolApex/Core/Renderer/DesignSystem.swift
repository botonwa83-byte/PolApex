import SwiftUI

enum Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 36
}

enum Radius {
    static let inner: CGFloat = 8
    static let card: CGFloat = 8
}

enum AppFont {
    static let sectionTitle = Font.system(.headline, design: .rounded).weight(.semibold)
    static let cardTitle = Font.system(.subheadline, design: .rounded).weight(.semibold)
    static let chip = Font.system(.caption2, design: .rounded).weight(.semibold)
    static func stat(_ size: CGFloat) -> Font {
        Font.system(size: size, weight: .bold, design: .rounded)
    }
}

extension View {
    func cardSurface(padding: CGFloat = Spacing.lg) -> some View {
        self
            .padding(padding)
            .background(Color.apexSurface)
            .clipShape(RoundedRectangle(cornerRadius: Radius.card, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: Radius.card, style: .continuous)
                    .stroke(Color.black.opacity(0.055), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.035), radius: 8, x: 0, y: 3)
    }

    func readableWidth(_ maxWidth: CGFloat = 760) -> some View {
        frame(maxWidth: maxWidth)
            .frame(maxWidth: .infinity)
    }
}

struct TagChip: View {
    let text: String
    var color: Color = .apexTeal

    var body: some View {
        Text(text)
            .font(AppFont.chip)
            .foregroundColor(color)
            .lineLimit(1)
            .minimumScaleFactor(0.82)
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .background(color.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
    }
}

struct SectionHeader: View {
    let title: String
    var systemImage: String? = nil
    var accent: Color = .apexTeal

    var body: some View {
        HStack(spacing: Spacing.sm) {
            if let systemImage {
                Image(systemName: systemImage)
                    .foregroundColor(accent)
            }
            Text(title)
                .font(AppFont.sectionTitle)
                .foregroundColor(.apexInk)
            Spacer()
        }
    }
}

struct EmptyStateView: View {
    let title: String
    let systemImage: String
    let message: String

    var body: some View {
        VStack(spacing: Spacing.md) {
            Image(systemName: systemImage)
                .font(.system(size: 42))
                .foregroundColor(.secondary)
            Text(title)
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(Spacing.xl)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
