//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation
import Vision

//MARK: - CGImage Setup
public extension CGImage {
    
    @available(iOS 11.0, *)
    /// Function to find face within an image.
    /// - Parameters:
    ///   - margin: 200
    ///   - completion: FaceCropResult - success(CGImage), notFound, failure(Error).
    func faceCrop(margin: CGFloat = 200, completion: @escaping (FaceCropResult) -> Void) {
        let req = VNDetectFaceRectanglesRequest { request, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let results = request.results, !results.isEmpty else {
                completion(.notFound)
                return
            }
            
            var faces: [VNFaceObservation] = []
            for result in results {
                guard let face = result as? VNFaceObservation else { continue }
                faces.append(face)
            }
            
            let croppingRect = self.getCroppingRect(for: faces, margin: margin)
            let faceImage = self.cropping(to: croppingRect)
            
            guard let result = faceImage else {
                completion(.notFound)
                return
            }
            completion(.success(result))
        }
        
        do {
            try VNImageRequestHandler(cgImage: self, options: [:]).perform([req])
        } catch let error {
            completion(.failure(error))
        }
    }
    
    @available(iOS 11.0, *)
    
    /// To get rectangular area in which face will be detected.
    /// - Parameters:
    ///   - faces: array of faces detected
    ///   - margin: 200
    /// - Returns: return rectangular area in which face will be detected.
    private func getCroppingRect(for faces: [VNFaceObservation], margin: CGFloat) -> CGRect {
        var totalX = CGFloat(0)
        var totalY = CGFloat(0)
        var totalW = CGFloat(0)
        var totalH = CGFloat(0)
        var minX = CGFloat.greatestFiniteMagnitude
        var minY = CGFloat.greatestFiniteMagnitude
        let numFaces = CGFloat(faces.count)
        
        for face in faces {
            let w = face.boundingBox.width * CGFloat(width)
            let h = face.boundingBox.height * CGFloat(height)
            let x = face.boundingBox.origin.x * CGFloat(width)
            let y = (1 - face.boundingBox.origin.y) * CGFloat(height) - h
            totalX += x
            totalY += y
            totalW += w
            totalH += h
            minX = .minimum(minX, x)
            minY = .minimum(minY, y)
        }
        
        let avgX = totalX / numFaces
        let avgY = totalY / numFaces
        let avgW = totalW / numFaces
        let avgH = totalH / numFaces
        
        let offset = margin + avgX - minX
        
        return CGRect(x: avgX - offset, y: avgY - offset, width: avgW + (offset * 2), height: avgH + (offset * 2))
    }
}

/// Enum FaceCropResult
public enum FaceCropResult {
    case success(CGImage)
    case notFound
    case failure(Error)
}
