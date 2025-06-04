//
//  FirebaseService.swift
//  putrack
//
//  Created by 신지원 on 6/5/25.
//

import FirebaseDatabase
import FirebaseCore
import Combine

final class FirebaseService: ObservableObject {
    @Published var airTemperature: Double = 0.0
    @Published var airHumidity: Double = 0.0
    @Published var cushionTemperature: Double = 0.0
    
    private var sensorRef: DatabaseReference?

    private var sensorApp: FirebaseApp? {
        return FirebaseApp.app(name: "SensorApp")
    }

    private var sensorDatabase: Database? {
        guard let app = sensorApp else { return nil }
        return Database.database(app: app)
    }

    func observeSensorData(patientCode: String) {
        guard let db = sensorDatabase else {
            print("❌ Sensor FirebaseApp or DB is nil")
            return
        }

        sensorRef = db.reference().child("sensor").child(patientCode)
        
        sensorRef?.observe(.value) { [weak self] snapshot in
            guard let value = snapshot.value as? [String: Any] else { return }

            if let temp = value["airTemperature"] as? Double {
                self?.airTemperature = temp
            }
            if let humid = value["airHumidity"] as? Double {
                self?.airHumidity = humid
            }
            if let cushionTemp = value["cushionTemperature"] as? Double {
                self?.cushionTemperature = cushionTemp
            }
        }
    }
    
    func stopObserving() {
        sensorRef?.removeAllObservers()
    }
}
