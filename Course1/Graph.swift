//
//  Graph.swift
//  Course1
//
//  Created by Devloper on 12.02.2020.
//  Copyright © 2020 Devloper. All rights reserved.
//

import Cocoa

class Graph: NSView {
    
    @IBOutlet weak var controller: ViewController!
    var separatorInset: Int = 20
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        self.layer?.backgroundColor = .white
        drawAxes()
        drawSeparators()
        
        let sinParams = controller.sinParams.arrangedSubviews as! [NSTextField]
        let cosParams = controller.cosParams.arrangedSubviews as! [NSTextField]
        let tanParams = controller.tanParams.arrangedSubviews as! [NSTextField]
        let cotParams = controller.cotParams.arrangedSubviews as! [NSTextField]
        
        drawSin(Float(sinParams[0].doubleValue),
                Float(sinParams[1].doubleValue),
                Float(sinParams[2].doubleValue),
                Float(sinParams[3].doubleValue),
                Float(sinParams[4].doubleValue),
                controller.sinCheck.state)
        drawCos(Float(cosParams[0].doubleValue),
                Float(cosParams[1].doubleValue),
                Float(cosParams[2].doubleValue),
                Float(cosParams[3].doubleValue),
                Float(cosParams[4].doubleValue),
                controller.cosCheck.state)
        drawTan(Float(tanParams[0].doubleValue),
                Float(tanParams[1].doubleValue),
                Float(tanParams[2].doubleValue),
                Float(tanParams[3].doubleValue),
                Float(tanParams[4].doubleValue),
                controller.tanCheck.state)
        drawCot(Float(cotParams[0].doubleValue),
                Float(cotParams[1].doubleValue),
                Float(cotParams[2].doubleValue),
                Float(cotParams[3].doubleValue),
                Float(cotParams[4].doubleValue),
                controller.cotCheck.state)
        
        drawLegend()
        
    }
    // .........................................................................DRAWING AXES AND SEPARATORS
    func drawAxes() -> Void {
        let abscissa = NSBezierPath()
        let ordinate = NSBezierPath()
        
        let abscissaStart = NSPoint(x: 0, y: bounds.height/2-0.5)
        let abscissaEnd = NSPoint(x: bounds.width, y: bounds.height/2-0.5)
        
        let ordinateStart = NSPoint(x: bounds.width/2-0.5, y: 0)
        let ordinateEnd = NSPoint(x: bounds.width/2-0.5, y: bounds.height)
        
        abscissa.move(to: abscissaStart)
        abscissa.line(to: abscissaEnd)
        
        ordinate.move(to: ordinateStart)
        ordinate.line(to: ordinateEnd)
        
        
        abscissa.stroke()
        ordinate.stroke()
    }
    
    func drawSeparators() {
        let posX = [NSBezierPath](repeating: NSBezierPath(), count: Int(bounds.width/CGFloat(separatorInset)*2))
        let negX = [NSBezierPath](repeating: NSBezierPath(), count: Int(bounds.width/CGFloat(separatorInset)*2))
        for i in 1..<posX.count {
            let posXStart = NSPoint(x: bounds.width/2 + CGFloat(separatorInset*i)-0.5, y: bounds.height/2+2.5)
            let posXEnd = NSPoint(x: bounds.width/2 + CGFloat(separatorInset*i)-0.5, y: bounds.height/2-3.5)
            posX[i].move(to: posXStart)
            posX[i].line(to: posXEnd)
            posX[i].stroke()
            
            let negXStart = NSPoint(x: bounds.width/2 - CGFloat(separatorInset*i)-0.5, y: bounds.height/2+2.5)
            let negXEnd = NSPoint(x: bounds.width/2 - CGFloat(separatorInset*i)-0.5, y: bounds.height/2-3.5)
            negX[i].move(to: negXStart)
            negX[i].line(to: negXEnd)
            negX[i].stroke()
            
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            
            let posVal = NSAttributedString(string: String(i), attributes: [NSAttributedString.Key.paragraphStyle: style])
            let negVal = NSAttributedString(string: "-"+String(i), attributes: [NSAttributedString.Key.paragraphStyle: style])
            let posRect = CGRect(x: posXEnd.x-10, y: posXEnd.y-20, width: 20, height: 20)
            let negRect = CGRect(x: negXEnd.x-10, y: negXEnd.y-20, width: 20, height: 20)
            posVal.draw(in: posRect)
            negVal.draw(in: negRect)
            
        }
        let posY = [NSBezierPath](repeating: NSBezierPath(), count: Int(bounds.height/CGFloat(separatorInset)*2))
        let negY = [NSBezierPath](repeating: NSBezierPath(), count: Int(bounds.height/CGFloat(separatorInset)*2))
        for i in 1..<negY.count {
            let negYStart = NSPoint(x: bounds.width/2-3.5, y: bounds.height/2-CGFloat(separatorInset*i)-0.5)
            let negYEnd = NSPoint(x: bounds.width/2+2.5, y: bounds.height/2-CGFloat(separatorInset*i)-0.5)
            posY[i].move(to: negYStart)
            posY[i].line(to: negYEnd)
            posY[i].stroke()
            
            let posYStart = NSPoint(x: bounds.width/2-3.5, y: bounds.height/2+CGFloat(separatorInset*i)-0.5)
            let posYEnd = NSPoint(x: bounds.width/2+2.5, y: bounds.height/2+CGFloat(separatorInset*i)-0.5)
            negY[i].move(to: posYStart)
            negY[i].line(to: posYEnd)
            negY[i].stroke()
            
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            
            let posVal = NSAttributedString(string: String(i), attributes: [NSAttributedString.Key.paragraphStyle: style])
            let negVal = NSAttributedString(string: "-"+String(i), attributes: [NSAttributedString.Key.paragraphStyle: style])
            let posRect = CGRect(x: posYStart.x-20, y: posYEnd.y-20, width: 20, height: 20)
            let negRect = CGRect(x: negYStart.x-20, y: negYEnd.y-20, width: 20, height: 20)
            posVal.draw(in: posRect)
            negVal.draw(in: negRect)
        }
    }
    // .........................................................................DRAWING TRIGONOMETRIC FUNCTIONS
    // sin
    func drawSin(_ a:Float = 1, _ b:Float = 1, _ c:Float = 0, _ d:Float = -52, _ e:Float = 52, _ state:NSControl.StateValue) -> Void {
        guard state == .on else {return}
        let center = NSPoint(x: bounds.width/2, y: bounds.height/2)
        var sinPoints: [NSPoint] = []
        for i in 0...Int(bounds.width) {
            let x = Float((CGFloat(i)-center.x)/CGFloat(separatorInset))
            guard x >= d, x <= e else {continue}
            let y = a*(sin(b*x+c))*Float(separatorInset)
            let sinPoint = NSPoint(x: CGFloat(i)-0.5, y: CGFloat(y)+bounds.height/2-0.5)
            sinPoints.append(sinPoint)
        }
        guard !sinPoints.isEmpty else {return}
        let path = NSBezierPath()
        path.move(to: sinPoints[0])
        for point in sinPoints {
            path.line(to: point)
        }
        NSColor.magenta.setStroke()
        path.stroke()
    }
    
    // cos
    func drawCos(_ a:Float = 1, _ b:Float = 1, _ c:Float = 0, _ d:Float = -52, _ e:Float = 52, _ state:NSControl.StateValue) -> Void {
        guard state == .on else {return}
        let center = NSPoint(x: bounds.width/2, y: bounds.height/2)
        var cosPoints: [NSPoint] = []
        for i in 0...Int(bounds.width) {
            let x = Float((CGFloat(i)-center.x)/CGFloat(separatorInset))
            guard x >= d, x <= e else {continue}
            let y = a*(cos(b*x+c))*Float(separatorInset)
            let cosPoint = NSPoint(x: CGFloat(i)-0.5, y: CGFloat(y)+bounds.height/2-0.5)
            cosPoints.append(cosPoint)
        }
        guard !cosPoints.isEmpty else {return}
        let path = NSBezierPath()
        path.move(to: cosPoints[0])
        for point in cosPoints {
            path.line(to: point)
        }
        NSColor.red.setStroke()
        path.stroke()
    }
    
    // tan
    func drawTan(_ a:Float = 1, _ b:Float = 1, _ c:Float = 0, _ d:Float = -52, _ e:Float = 52, _ state:NSControl.StateValue) -> Void {
        guard state == .on else {return}
        let center = NSPoint(x: bounds.width/2, y: bounds.height/2)
        var tanPoints: [NSPoint] = []
        for i in 0...Int(bounds.width) {
            let x = Float((CGFloat(i)-center.x)/CGFloat(separatorInset))
            guard x >= d, x <= e else {continue}
            let y = a*(tan(b*x+c))*Float(separatorInset)
            let tanPoint = NSPoint(x: CGFloat(i)-0.5, y: CGFloat(y)+bounds.height/2-0.5)
//            if let y1 = tanPoints.last?.y, y1*CGFloat(y) < 0 {
//
//            }
            //print(tanPoint)
            tanPoints.append(tanPoint)
        }
        guard !tanPoints.isEmpty else {return}
        let path = NSBezierPath()
        path.move(to: tanPoints[0])
        for i in 0..<tanPoints.count-1 {
            if fabsf(Float(tanPoints[i].y-tanPoints[i+1].y)) > 100 {
                path.line(to: tanPoints[i])
                path.move(to: tanPoints[i+1])
                continue
            }
            path.line(to: tanPoints[i])
        }
        NSColor.blue.setStroke()
        path.stroke()
        //assymptotes
        for i in 0...Int(bounds.width/2) {
            let x = (bounds.width/2+(CGFloat.pi/2+CGFloat(Float.pi*Float(i))+CGFloat(c))*CGFloat(separatorInset)/CGFloat(b))-0.5
            let nX = (bounds.width/2-(CGFloat.pi/2+CGFloat(Float.pi*Float(i))+CGFloat(c))*CGFloat(separatorInset)/CGFloat(b))-0.5
            let assymptote = NSBezierPath()
            let assymptote1 = NSBezierPath()
            assymptote.move(to: NSPoint(x: x, y: bounds.height))
            assymptote.line(to: NSPoint(x: x, y: 0))
            assymptote1.move(to: NSPoint(x: nX, y: bounds.height))
            assymptote1.line(to: NSPoint(x: nX, y: 0))
            NSColor.red.setStroke()
            assymptote.lineWidth = 1
            assymptote1.lineWidth = 1
            let dashes: [CGFloat] = [10,5]
            assymptote.setLineDash(dashes, count: dashes.count, phase: 5.0)
            assymptote1.setLineDash(dashes, count: dashes.count, phase: 5.0)
            assymptote.stroke()
            assymptote1.stroke()
        }
    }
    
    // cot
    func drawCot(_ a:Float = 1, _ b:Float = 1, _ c:Float = 0, _ d:Float = -52, _ e:Float = 52, _ state:NSControl.StateValue) -> Void {
        guard state == .on else {return}
        let center = NSPoint(x: bounds.width/2, y: bounds.height/2)
        var cotPoints: [NSPoint] = []
        for i in 0...Int(bounds.width) {
            let x = Float((CGFloat(i)-center.x)/CGFloat(separatorInset))
            guard x >= d, x <= e else {continue}
            let y = a*(1/tan(b*x+c))*Float(separatorInset)
            let cotPoint = NSPoint(x: CGFloat(i)-0.5, y: CGFloat(y)+bounds.height/2-0.5)
            cotPoints.append(cotPoint)
        }
        guard !cotPoints.isEmpty else {return}
        let path = NSBezierPath()
        path.move(to: cotPoints[0])
        for i in 0..<cotPoints.count-1 {
            if fabsf(Float(cotPoints[i].y-cotPoints[i+1].y)) > 100 {
                path.line(to: cotPoints[i])
                path.move(to: cotPoints[i+1])
                continue
            }
            path.line(to: cotPoints[i])
        }
        NSColor.orange.setStroke()
        path.stroke()
        //assymptotes
        for i in 0...Int(bounds.width/2) {
            let x = (bounds.width/2+(CGFloat(Float.pi*Float(i))+CGFloat(c))*CGFloat(separatorInset)/CGFloat(b))-0.5
            let nX = (bounds.width/2-(CGFloat(Float.pi*Float(i))+CGFloat(c))*CGFloat(separatorInset)/CGFloat(b))-0.5
            let assymptote = NSBezierPath()
            let assymptote1 = NSBezierPath()
            assymptote.move(to: NSPoint(x: x, y: bounds.height))
            assymptote.line(to: NSPoint(x: x, y: 0))
            assymptote1.move(to: NSPoint(x: nX, y: bounds.height))
            assymptote1.line(to: NSPoint(x: nX, y: 0))
            NSColor.black.setStroke()
            assymptote.lineWidth = 1
            assymptote1.lineWidth = 1
            let dashes: [CGFloat] = [10,5]
            assymptote.setLineDash(dashes, count: dashes.count, phase: 5.0)
            assymptote1.setLineDash(dashes, count: dashes.count, phase: 5.0)
            assymptote.stroke()
            assymptote1.stroke()
        }
    }
    // .........................................................................DRAWING LEGEND
    func drawLegend() -> Void {
        let sin = NSBezierPath()
        let cos = NSBezierPath()
        let tan = NSBezierPath()
        let cot = NSBezierPath()
        
        let legend = [sin,cos,tan,cot]
        let colors: [NSColor] = [.magenta,.red,.blue,.orange]
        let check = [controller.sinCheck,controller.cosCheck,controller.tanCheck,controller.cotCheck]
        for i in 0..<legend.count {
            guard check[i]?.state == .on else {continue}
            let x0 = bounds.width-70
            let y0 = 20*CGFloat(i)+10
            legend[i].move(to: NSPoint(x: x0, y: y0))
            legend[i].line(to: NSPoint(x: x0+30, y: y0))
            colors[i].setStroke()
            legend[i].lineWidth = 2
            legend[i].stroke()
        }
    }
    
}
