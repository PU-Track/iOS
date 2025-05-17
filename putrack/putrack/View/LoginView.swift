//
//  LoginView.swift
//  putrack
//
//  Created by 신지원 on 5/17/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.openURL) var openURL
    
    @State private var code: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            Text("로그인")
                .font(.largeTitle)
                .bold()

            TextField("부여된 코드를 입력하세요", text: $code)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button("로그인") {
                login()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button(action: {
                //TODO: 웹사이트로 만들어서 작성
                openURL(URL(string: "https://open.kakao.com/o/sNzYAPwh")!)
            }) {
                Text("Join")
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .underline()
            }
            .padding(.top, 10)
        }
        .padding()
    }

    private func login() {
        if code == "Putrack" {
            appState.isLoggedIn = true
        } else {
            errorMessage = "코드가 올바르지 않습니다."
        }
    }
}
