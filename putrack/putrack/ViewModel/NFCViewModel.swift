//
//  NFCViewModel.swift
//  putrack
//
//  Created by 신지원 on 5/15/25.
//

import Foundation
import CoreNFC

final class NFCViewModel: NSObject, ObservableObject {
    @Published var lastScannedText: String = "태그 해주세요"

    private var session: NFCNDEFReaderSession?

    func startScanning() {
        
        //MARK: ERROR-CASE1) NFC 태깅 권한 없음
        guard NFCNDEFReaderSession.readingAvailable else {
            lastScannedText = "현재 NFC 기능을 사용할 수 없습니다."
            return
        }

        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = "환자의 기기에 iPhone 을 가까이 해주세요."
        session?.begin()
    }
}

extension NFCViewModel: NFCNDEFReaderSessionDelegate {
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("✅ NFC 세션이 시작됐습니다.")
    }
    
    //MARK: ERROR-CASE2) NFC 태깅 실패
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        let nsError = error as NSError
        var message = "Session failed"

        if let code = NFCReaderError.Code(rawValue: nsError.code) {
            switch code {
            case .readerSessionInvalidationErrorUserCanceled:
                message = "스캔 취소버튼을 눌렀어요."
            case .readerSessionInvalidationErrorSessionTimeout:
                message = "세션이 시간 초과로 종료됐습니다."
            case .readerSessionInvalidationErrorFirstNDEFTagRead:
                message = "첫 태그를 읽은 후 세션이 자동 종료됐습니다."
            default:
                message = "NFC 오류 (\(code.rawValue))"
            }
        } else {
            message = "NFC 오류: \(nsError.localizedDescription)"
        }

        DispatchQueue.main.async {
            self.lastScannedText = message
        }
    }

    // SUCCESS) NFC 태그 성공
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        //MARK: ERROR-CASE3) 태그는 성공했지만 태그 내부 NDEF 가 비어있음
        guard let payload = messages.first?.records.first else {
            DispatchQueue.main.async {
                self.lastScannedText = "No valid payload found"
            }
            return
        }

        if let text = String(data: payload.payload.advanced(by: 3), encoding: .utf8) {
            DispatchQueue.main.async {
                self.lastScannedText = "Scanned: \(text)"
            }
        }
        
        //MARK: ERROR-CASE4) NDEF 내부 텍스트 레코더에 메타데이터 뒤 실제데이터가 존재하지 않음
        else {
            DispatchQueue.main.async {
                self.lastScannedText = "Scanned unknown data"
            }
        }
    }
}
