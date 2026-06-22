import AppKit

// Args: out, screenshot, title, subtitle, accentHex, index, total
let a = CommandLine.arguments
guard a.count >= 8 else { fputs("usage error\n", stderr); exit(1) }
let outPath = a[1], shotPath = a[2], title = a[3], subtitle = a[4]
let accentHex = a[5]
let index = Int(a[6]) ?? 0, total = Int(a[7]) ?? 1

let W = 1080, H = 1920

func color(_ hex: String) -> NSColor {
    var s = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
    if s.count == 6 { s += "ff" }
    let v = UInt64(s, radix: 16) ?? 0
    return NSColor(srgbRed: CGFloat((v >> 24) & 0xff)/255,
                   green: CGFloat((v >> 16) & 0xff)/255,
                   blue: CGFloat((v >> 8) & 0xff)/255,
                   alpha: CGFloat(v & 0xff)/255)
}
let accent = color(accentHex)

let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: W, pixelsHigh: H,
                           bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true,
                           isPlanar: false, colorSpaceName: .deviceRGB,
                           bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
let ctx = NSGraphicsContext.current!.cgContext

// helper: convert top-based y to AppKit bottom-based
func ty(_ topY: CGFloat) -> CGFloat { CGFloat(H) - topY }

// --- background: deep navy gradient with accent glow ---
let bg = NSGradient(colors: [color("#0A1626"), color("#0F2540"), color("#0A1626")])!
bg.draw(in: NSRect(x: 0, y: 0, width: W, height: H), angle: -90)

// accent radial glow top
ctx.saveGState()
let glow = NSGradient(colors: [accent.withAlphaComponent(0.34), accent.withAlphaComponent(0.0)])!
glow.draw(in: NSBezierPath(ovalIn: NSRect(x: -160, y: ty(620), width: 1400, height: 1000)), relativeCenterPosition: NSPoint(x: 0, y: 0))
ctx.restoreGState()

// --- title ---
let titlePara = NSMutableParagraphStyle(); titlePara.alignment = .center
let titleAttr: [NSAttributedString.Key: Any] = [
    .font: NSFont(name: "PingFangSC-Semibold", size: 78) ?? NSFont.boldSystemFont(ofSize: 78),
    .foregroundColor: NSColor.white,
    .paragraphStyle: titlePara,
    .kern: 1.5
]
let titleRect = NSRect(x: 60, y: ty(250), width: CGFloat(W) - 120, height: 110)
(title as NSString).draw(in: titleRect, withAttributes: titleAttr)

// accent underline under title
let lineW: CGFloat = 96
ctx.setFillColor(accent.cgColor)
let underline = NSBezierPath(roundedRect: NSRect(x: (CGFloat(W)-lineW)/2, y: ty(290), width: lineW, height: 7), xRadius: 3.5, yRadius: 3.5)
underline.fill()

// --- subtitle ---
let subPara = NSMutableParagraphStyle(); subPara.alignment = .center; subPara.lineSpacing = 11
let subAttr: [NSAttributedString.Key: Any] = [
    .font: NSFont(name: "PingFangSC-Medium", size: 42) ?? NSFont.systemFont(ofSize: 42, weight: .medium),
    .foregroundColor: NSColor(white: 0.93, alpha: 1),
    .paragraphStyle: subPara
]
let subRect = NSRect(x: 80, y: ty(434), width: CGFloat(W) - 160, height: 160)
(subtitle as NSString).draw(in: subRect, withAttributes: subAttr)

// --- phone screenshot, rounded with shadow ---
if let shot = NSImage(contentsOfFile: shotPath) {
    let imgSize = shot.size
    let aspect = imgSize.width / imgSize.height
    let topY: CGFloat = 452
    let bottomLimit: CGFloat = 1724          // keep clear of footer
    let availH = bottomLimit - topY
    let drawW = min(700, availH * aspect)     // fit by height so it never overflows
    let drawH = drawW / aspect
    let x = (CGFloat(W) - drawW)/2
    let usedTop = topY + (availH - drawH)/2   // center within the band
    let yBottom = ty(usedTop + drawH)
    let frame = NSRect(x: x, y: yBottom, width: drawW, height: drawH)

    ctx.saveGState()
    ctx.setShadow(offset: CGSize(width: 0, height: -18), blur: 60, color: NSColor.black.withAlphaComponent(0.55).cgColor)
    let radius: CGFloat = 52
    let clip = NSBezierPath(roundedRect: frame, xRadius: radius, yRadius: radius)
    // draw a backing fill so the shadow renders, then clip and draw image
    NSColor.black.setFill(); clip.fill()
    ctx.restoreGState()

    ctx.saveGState()
    clip.addClip()
    shot.draw(in: frame, from: NSRect(origin: .zero, size: imgSize), operation: .copy, fraction: 1.0)
    ctx.restoreGState()

    // subtle border
    ctx.setStrokeColor(NSColor.white.withAlphaComponent(0.12).cgColor)
    clip.lineWidth = 2; clip.stroke()
}

// --- footer: wordmark + progress dots ---
let wm = "PolApex"
let wmAttr: [NSAttributedString.Key: Any] = [
    .font: NSFont(name: "PingFangSC-Semibold", size: 30) ?? NSFont.boldSystemFont(ofSize: 30),
    .foregroundColor: NSColor.white.withAlphaComponent(0.9),
    .kern: 2.0
]
let wmSize = (wm as NSString).size(withAttributes: wmAttr)
(wm as NSString).draw(at: NSPoint(x: (CGFloat(W)-wmSize.width)/2, y: ty(1856)), withAttributes: wmAttr)

// progress dots
let dotR: CGFloat = 6, gap: CGFloat = 22
let totalW = CGFloat(total) * dotR * 2 + CGFloat(total - 1) * (gap - dotR * 2)
var dx = (CGFloat(W) - totalW)/2
for i in 0..<total {
    let on = (i == index)
    ctx.setFillColor((on ? accent : NSColor.white.withAlphaComponent(0.25)).cgColor)
    let w: CGFloat = on ? 28 : dotR*2
    let path = NSBezierPath(roundedRect: NSRect(x: dx, y: ty(1788), width: w, height: dotR*2), xRadius: dotR, yRadius: dotR)
    path.fill()
    dx += w + (gap - dotR*2) + (on ? 0 : 0)
}

NSGraphicsContext.restoreGraphicsState()

guard let data = rep.representation(using: .png, properties: [:]) else { exit(2) }
try! data.write(to: URL(fileURLWithPath: outPath))
print("wrote \(outPath)")
