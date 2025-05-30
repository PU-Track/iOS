//
//  LoginView.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: Property
    
    @EnvironmentObject var appState: AppState
    @Environment(\.openURL) var openURL
    
    @State private var userCode: String = ""
    @State private var errorMessage: String?
    @FocusState private var isFocused: Bool
    
    //MARK: UI
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(.main)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea(edges: .bottom)
            
            VStack {
                HStack {
                    Spacer()
                    Image(.wave)
                        .resizable()
                        .frame(height: 300)
                        .padding(.leading)
                }
                Spacer()
            }
            
            VStack(spacing: 20) {
                
                Spacer()
                
                Text("ENTER YOUR CODE")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 20)
                
                ZStack {
                    // 기본 텍스트필드 설정
                    TextField("", text: $userCode)
                        .onChange(of: userCode) { newValue in
                            // 4글자까지만 작성가능하도록 수정
                            let filtered = newValue.uppercased().filter { $0.isLetter && $0.isASCII }
                            userCode = String(filtered.prefix(4))
                        }
                        .keyboardType(.asciiCapable)
                        .textContentType(.oneTimeCode)
                        .foregroundColor(.clear)
                        .accentColor(.clear)
                        .disableAutocorrection(true)
                        .focused($isFocused)
                        .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { isFocused = true } }
                    
                    // 커스텀 텍스트필드 설정
                    HStack(spacing: 13) {
                        ForEach(0..<4, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 53, height: 65)
                                Text(index < userCode.count ? String(userCode[userCode.index(userCode.startIndex, offsetBy: index)]) : "")
                                    .font(.title)
                                    .bold()
                            }
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isFocused = true
                    }
                }
                
                // 에러메세지 발생할 때만 나타남
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                // 로그인 버튼
                Button("LOGIN") {
                    login()
                }
                .disabled(userCode.count != 4)
                .padding()
                .background(userCode.count == 4 ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                // 등록 페이지로 이동하는 버튼
                //TODO: 웹사이트로 연결
                HStack(spacing: 4) {
                    Text("Don't have a code?       ")
                    Button("Get one here") {
                        openURL(URL(string: "https://open.kakao.com/o/sNzYAPwh")!)
                    }
                    .foregroundColor(.blue)
                    .underline()
                }
                .font(.footnote)
                
                Spacer(minLength: 350)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}

//MARK: API

extension LoginView {
    private func login() {
        print("userCode: ", userCode)
        errorMessage = nil
        
        // 로그인 성공 후 FCM 토큰 전송
        if let token = UserDefaults.standard.string(forKey: "fcmToken") {
            Task {
                do {
                    try await FCMManager.shared.sendFCMToken(code: userCode, token: token)
                    appState.userCode = userCode
                    appState.isLoggedIn = true
                } catch {
                    print("❌ FCM 토큰 전송 실패: \(error.localizedDescription)")
                    errorMessage = "코드가 올바르지 않습니다."
                    appState.isLoggedIn = false
                }
            }
        } else { print("❗ 저장된 FCM 토큰이 없습니다.") }
    }
}
