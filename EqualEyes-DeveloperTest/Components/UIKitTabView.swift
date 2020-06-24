//
//  UIKitTabView.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

public struct UIKitTabView: View {
    private var viewControllers: [UIHostingController<AnyView>]
    private var selectedIndex: Binding<Int>?
    @State private var fallbackSelectedIndex: Int = 0
    
    public init(selectedIndex: Binding<Int>? = nil, @TabBuilder _ views: () -> [Tab]) {
        self.viewControllers = views().map {
            let host = UIHostingController(rootView: $0.view)
            host.tabBarItem = $0.barItem
            return host
        }
        self.selectedIndex = selectedIndex
    }
    
    public var body: some View {
        TabBarController(controllers: viewControllers, selectedIndex: selectedIndex ?? $fallbackSelectedIndex)
            .edgesIgnoringSafeArea(.all)
    }
    
    public struct Tab {
        var view: AnyView
        var barItem: UITabBarItem
    }
}

@_functionBuilder
public struct TabBuilder {
    public static func buildBlock(_ items: UIKitTabView.Tab...) -> [UIKitTabView.Tab] {
        items
    }
}

extension View {
    public func tab(title: String, image: String? = nil, selectedImage: String? = nil, badgeValue: String? = nil) -> UIKitTabView.Tab {
        func imageOrSystemImage(named: String?) -> UIImage? {
            guard let name = named else { return nil }
            return UIImage(named: name) ?? UIImage(systemName: name)
        }
        let image = imageOrSystemImage(named: image)
        let selectedImage = imageOrSystemImage(named: selectedImage)
        let barItem = UITabBarItem(title: title.localized, image: image, selectedImage: selectedImage)
        barItem.badgeValue = badgeValue
        return UIKitTabView.Tab(view: AnyView(self), barItem: barItem)
    }
}

fileprivate struct TabBarController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    @Binding var selectedIndex: Int

    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        tabBarController.delegate = context.coordinator
        tabBarController.selectedIndex = 0
        // FIXME: only needed because of bug in latest beta
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            tabBarController.selectedIndex = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                tabBarController.selectedIndex = 0
            }
        }
        return tabBarController
    }

    func updateUIViewController(_ tabBarController: UITabBarController, context: Context) {
        tabBarController.selectedIndex = selectedIndex
        tabBarController.viewDidAppear(true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITabBarControllerDelegate {
        var parent: TabBarController

        init(_ tabBarController: TabBarController) {
            self.parent = tabBarController
        }
        
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            if parent.selectedIndex == tabBarController.selectedIndex {
                popToRootOrScrollUp(on: viewController)
            }
            parent.selectedIndex = tabBarController.selectedIndex
        }
        
        private func popToRootOrScrollUp(on viewController: UIViewController) {
            let nav = navigationController(for: viewController)
            let popped = nav?.popToRootViewController(animated: true)
            
            if (popped ?? []).isEmpty {
                let rootViewController = nav?.viewControllers.first ?? viewController
                if let scrollView = firstScrollView(in: rootViewController.view ?? UIView()) {
                    let preservedX = scrollView.contentOffset.x
                    let y = -scrollView.adjustedContentInset.top
                    scrollView.setContentOffset(CGPoint(x: preservedX, y: y), animated: true)
                }
            }
        }
        
        private func navigationController(for viewController: UIViewController) -> UINavigationController? {
            for child in viewController.children {
                if let nav = viewController as? UINavigationController {
                    return nav
                } else if let nav = navigationController(for: child) {
                    return nav
                }
            }
            return nil
        }
        
        public func firstScrollView(in view: UIView) -> UIScrollView? {
            for subview in view.subviews {
                if let scrollView = view as? UIScrollView {
                    return scrollView
                } else if let scrollView = firstScrollView(in: subview) {
                    return scrollView
                }
            }
            return nil
        }
    }
}

struct UIKitTabView_Previews: PreviewProvider {
    static var previews: some View {
        UIKitTabView {
                Text("123")
                    .tab(title: "Numbers", image: "number.circle", selectedImage: "number.circle.fill")
                Text("ABC")
                    .tab(title: "Letters", image: "a.circle", selectedImage: "a.circle.fill")
        }
    }
}
