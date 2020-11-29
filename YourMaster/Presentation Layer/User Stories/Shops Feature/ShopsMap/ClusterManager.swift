

import Foundation
import GoogleMapsUtils
import GoogleMaps

final class ClusterManager {
    private let iconGenerator: GMUDefaultClusterIconGenerator
    private let algorithm: GMUClusterAlgorithm
    
    private var clusterManager: GMUClusterManager?
    private var renderer: GMUDefaultClusterRenderer?
    
    private var items: [ClusterItem]
    private var filteredItems: [ClusterItem]
    
    init() {
        self.items = []
        self.filteredItems = []
        self.iconGenerator = GMUDefaultClusterIconGenerator()
        self.algorithm = GMUGridBasedClusterAlgorithm()
    }
    
    func setup(mapView: GMSMapView, mapDelegate: GMUClusterManagerDelegate & GMSMapViewDelegate) {
        self.renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        self.clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer ?? GMUDefaultClusterRenderer())
        self.clusterManager?.setDelegate(mapDelegate, mapDelegate: mapDelegate)
    }
    
    func addItem(_ item: ClusterItem) {
        items.append(item)
        clusterManager?.add(item)
        clusterManager?.cluster()
    }
    
    func addItems(_ items: [ClusterItem]) {
        self.items.append(contentsOf: items)
        clusterManager?.add(items)
        clusterManager?.cluster()
    }
    
    func removeItem(_ item: ClusterItem) {
        clusterManager?.remove(item)
    }
    
    func clear() {
        clusterManager?.clearItems()
    }
    
    func search(text: String) {
        filteredItems = items.filter({ !$0.name.lowercased().hasPrefix(text.lowercased()) })
        for item in filteredItems {
            clusterManager?.remove(item)
        }
        clusterManager?.cluster()
    }
    
    func renderAllMarkers() {
        clusterManager?.add(filteredItems)
        clusterManager?.cluster()
    }
}
