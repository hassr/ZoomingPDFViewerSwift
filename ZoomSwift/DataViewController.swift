//
//  DataViewController.swift
//  ZoomSwift
//
//  Created by ryan on 5/2/15.
//  Copyright (c) 2015 ryan. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    @IBOutlet weak var scrollView: PDFScrollView!
    
    var pdf: CGPDFDocumentRef!
    var page: CGPDFPageRef!
    var pageNumber: Int = 0
    var myScale: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.page = CGPDFDocumentGetPage(self.pdf, self.pageNumber)
//        let pageExists = (self.page == nil)
        println("self.page == nil?" + ((self.page == nil) ? "true" : "false"))
        self.scrollView.changePDFPage(self.page)

    }
    
    override func viewWillAppear(animated: Bool) {
        // Disable zooming if our pages are currently shown in landscape
        if (self.interfaceOrientation == UIInterfaceOrientation.Portrait || self.interfaceOrientation == UIInterfaceOrientation.PortraitUpsideDown) {
            self.scrollView.userInteractionEnabled = true
        }
        else {
            self.scrollView.userInteractionEnabled = false
        }

        println("scrollView.zoomScale = \(self.scrollView.zoomScale) " + pretty_function_string())
    }
    
    override func viewDidLayoutSubviews() {
        pretty_function()
        self.restoreScale()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        pretty_function()
        if (fromInterfaceOrientation == UIInterfaceOrientation.Portrait) || (fromInterfaceOrientation == UIInterfaceOrientation.PortraitUpsideDown) {
            self.scrollView.userInteractionEnabled = false
        }
        else {
            self.scrollView.userInteractionEnabled = true
        }
    }
    func restoreScale() {
        // Called on orientation change.
        // We need to zoom out and basically reset the scrollview to look right in two-page spline view.
        let pageRect = CGPDFPageGetBoxRect(self.page, kCGPDFMediaBox)
        let yScale = self.view.frame.size.height / pageRect.size.height
        let xScale = self.view.frame.size.width / pageRect.size.width
        
        myScale = min(xScale, yScale)
        println("self.myScale = \(self.myScale) "  + pretty_function_string())
        self.scrollView.bounds = self.view.bounds
        self.scrollView.zoomScale = 1.0
        self.scrollView.PDFScale = self.myScale
        self.scrollView.tiledPDFView.bounds = self.view.bounds
        self.scrollView.tiledPDFView.myScale = self.myScale
        self.scrollView.tiledPDFView.layer.setNeedsDisplay()
    }
}
