// HistApex app icon generator.
// Produces a luminous history-themed icon: jade/sky/gold gradient, time arc, and a bold "史" seal mark.
// Run: swift scripts/make_hist_icon.swift

import AppKit
import CoreGraphics

let size = 1024
let cs = CGColorSpace(name: CGColorSpace.sRGB)!
let ctx = CGContext(
    data: nil,
    width: size,
    height: size,
    bitsPerComponent: 8,
    bytesPerRow: 0,
    space: cs,
    bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue
)!

func cg(_ hex: UInt32, alpha: CGFloat = 1) -> CGColor {
    let r = CGFloat((hex >> 16) & 0xff) / 255
    let g = CGFloat((hex >> 8) & 0xff) / 255
    let b = CGFloat(hex & 0xff) / 255
    return CGColor(colorSpace: cs, components: [r, g, b, alpha])!
}

func ns(_ hex: UInt32, alpha: CGFloat = 1) -> NSColor {
    NSColor(cgColor: cg(hex, alpha: alpha))!
}

func linearGradient(_ colors: [CGColor], _ locations: [CGFloat], start: CGPoint, end: CGPoint) {
    let gradient = CGGradient(colorsSpace: cs, colors: colors as CFArray, locations: locations)!
    ctx.drawLinearGradient(gradient, start: start, end: end, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
}

func radialGlow(center: CGPoint, radius: CGFloat, colors: [CGColor], locations: [CGFloat]) {
    let gradient = CGGradient(colorsSpace: cs, colors: colors as CFArray, locations: locations)!
    ctx.drawRadialGradient(
        gradient,
        startCenter: center,
        startRadius: 0,
        endCenter: center,
        endRadius: radius,
        options: [.drawsAfterEndLocation]
    )
}

let bounds = CGRect(x: 0, y: 0, width: size, height: size)
ctx.setFillColor(cg(0x12345F))
ctx.fill(bounds)

linearGradient(
    [cg(0x4FE1D2), cg(0x4EA4F4), cg(0xF6D36E), cg(0xD94A3A)],
    [0.0, 0.42, 0.74, 1.0],
    start: CGPoint(x: 0, y: size),
    end: CGPoint(x: size, y: 0)
)

radialGlow(
    center: CGPoint(x: 250, y: 790),
    radius: 560,
    colors: [cg(0xFFFFFF, alpha: 0.34), cg(0xFFFFFF, alpha: 0.0)],
    locations: [0, 1]
)
radialGlow(
    center: CGPoint(x: 800, y: 190),
    radius: 520,
    colors: [cg(0xC83F33, alpha: 0.28), cg(0xC83F33, alpha: 0.0)],
    locations: [0, 1]
)

NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(cgContext: ctx, flipped: false)

let iconRect = CGRect(x: 0, y: 0, width: size, height: size)

let arcRect = CGRect(x: 170, y: 210, width: 710, height: 710)
for (offset, alpha) in [(0.0, 0.24), (54.0, 0.16), (108.0, 0.10)] {
    let path = NSBezierPath()
    path.appendArc(withCenter: CGPoint(x: iconRect.midX, y: iconRect.midY),
                   radius: arcRect.width / 2 - offset,
                   startAngle: 208,
                   endAngle: 18,
                   clockwise: false)
    path.lineWidth = offset == 0 ? 18 : 10
    ns(0xFFFFFF, alpha: alpha).setStroke()
    path.stroke()
}

for (x, y, radius, color) in [
    (265.0, 370.0, 17.0, 0xFFF4B0),
    (512.0, 810.0, 20.0, 0xFFFFFF),
    (780.0, 385.0, 15.0, 0xFFE08A)
] {
    let dot = NSBezierPath(ovalIn: CGRect(x: x - radius, y: y - radius, width: radius * 2, height: radius * 2))
    ns(UInt32(color), alpha: 0.9).setFill()
    dot.fill()
}

let sealRect = CGRect(x: 212, y: 220, width: 600, height: 600)
let shadow = NSShadow()
shadow.shadowColor = ns(0x173052, alpha: 0.28)
shadow.shadowOffset = NSSize(width: 0, height: -18)
shadow.shadowBlurRadius = 32
shadow.set()

let sealPath = NSBezierPath(roundedRect: sealRect, xRadius: 150, yRadius: 150)
linearGradient(
    [cg(0xFFFFFF, alpha: 0.36), cg(0xFFFFFF, alpha: 0.15), cg(0x15345C, alpha: 0.22)],
    [0, 0.54, 1],
    start: CGPoint(x: sealRect.minX, y: sealRect.maxY),
    end: CGPoint(x: sealRect.maxX, y: sealRect.minY)
)
ctx.saveGState()
ctx.addPath(sealPath.cgPath)
ctx.clip()
linearGradient(
    [cg(0xFFFFFF, alpha: 0.28), cg(0xFFFFFF, alpha: 0.06), cg(0x193F70, alpha: 0.34)],
    [0, 0.52, 1],
    start: CGPoint(x: sealRect.minX, y: sealRect.maxY),
    end: CGPoint(x: sealRect.maxX, y: sealRect.minY)
)
ctx.restoreGState()

NSGraphicsContext.current = NSGraphicsContext(cgContext: ctx, flipped: false)
NSColor.white.withAlphaComponent(0.36).setStroke()
sealPath.lineWidth = 5
sealPath.stroke()

let inner = NSBezierPath(roundedRect: sealRect.insetBy(dx: 34, dy: 34), xRadius: 122, yRadius: 122)
ns(0xFFFFFF, alpha: 0.18).setStroke()
inner.lineWidth = 3
inner.stroke()

let paragraph = NSMutableParagraphStyle()
paragraph.alignment = .center

let textShadow = NSShadow()
textShadow.shadowColor = ns(0x173052, alpha: 0.30)
textShadow.shadowOffset = NSSize(width: 0, height: -10)
textShadow.shadowBlurRadius = 18

let attrs: [NSAttributedString.Key: Any] = [
    .font: NSFont.systemFont(ofSize: 430, weight: .black),
    .foregroundColor: NSColor.white.withAlphaComponent(0.96),
    .paragraphStyle: paragraph,
    .shadow: textShadow
]

let text = NSAttributedString(string: "史", attributes: attrs)
let textSize = text.size()
text.draw(at: NSPoint(x: (CGFloat(size) - textSize.width) / 2,
                      y: (CGFloat(size) - textSize.height) / 2 - 36))

let highlight = NSBezierPath()
highlight.move(to: CGPoint(x: 294, y: 700))
highlight.curve(to: CGPoint(x: 640, y: 790),
                controlPoint1: CGPoint(x: 380, y: 800),
                controlPoint2: CGPoint(x: 530, y: 830))
ns(0xFFFFFF, alpha: 0.25).setStroke()
highlight.lineWidth = 12
highlight.lineCapStyle = .round
highlight.stroke()

NSGraphicsContext.restoreGraphicsState()

let image = ctx.makeImage()!
let rep = NSBitmapImageRep(cgImage: image)
let png = rep.representation(using: .png, properties: [:])!
let output = URL(fileURLWithPath: "/Users/wangfeng/Documents/trae_projects/HistApex/HistApex/Resources/Assets.xcassets/AppIcon.appiconset/AppIcon-1024.png")
try png.write(to: output)
print("HistApex icon written to \(output.path) (1024 RGB, no alpha)")
