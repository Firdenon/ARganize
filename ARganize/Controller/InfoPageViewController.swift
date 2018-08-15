//
//  InfoPageViewController.swift
//  ARganize
//
//  Created by Kristopher Chayadi on 15/08/18.
//  Copyright © 2018 MC3 RE:ceh. All rights reserved.
//

import UIKit

class InfoPageViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {

    let pageContentViewControllers = [
        UIViewController(nibName: "InfoPage1", bundle: nil),
        UIViewController(nibName: "InfoPage2", bundle: nil),
        UIViewController(nibName: "InfoPage3", bundle: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.setViewControllers([pageContentViewControllers.first!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
//        InfoPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
//        pageViewController = new UIPageViewController(UIPageViewControllerTransitionStyle.Scr‌​oll, UIPageViewControllerNavigationOrientation.Horizontal)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageContentViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0;
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageContentViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = index + 1
        guard pageContentViewControllers.count != nextIndex else {
            //return orderedViewController.first
            return nil
        }
        
        guard pageContentViewControllers.count > nextIndex else {
            return nil
        }
        
        return pageContentViewControllers[nextIndex]
        //let index = pageContentViewControllers.lastIndex(of: pageContentViewControllers)//find(pageContentViewControllers, viewController)
//        if index == nil || index + 1 == pageContentViewControllers.count {
//            return nil
//        } else {
//            return pageContentViewControllers[index + 1]
//        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageContentViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = index - 1
        
        guard previousIndex >= 0 else {
            //return orderedViewController.last
            return nil
        }
        
        guard pageContentViewControllers.count > previousIndex else {
            return nil
        }
        
        return pageContentViewControllers[previousIndex]
    }
}
