//
//  WelcomeView.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//
//
//
//import SwiftUI
//
//struct WelcomeView: View {
//    @State private var showLogin = false
//    @State private var showSignup = false
//    @State private var animateLogo = false
//    @State private var animateButtons = false
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 30) {
//                Image("AppLogo") // App logo
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 150, height: 150)
//                    .scaleEffect(animateLogo ? 1.0 : 0.5)
//                    .opacity(animateLogo ? 1 : 0)
//                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: animateLogo)
//
//                Text("Find what’s lost. Return what’s found.")
//                                    .font(.headline)
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.primary)
//                                    .opacity(animateLogo ? 1 : 0)
//                                    .offset(y: animateLogo ? 0 : 20)
//                                    .animation(.easeOut(duration: 0.6).delay(0.2), value: animateLogo)
//
//                Text("at Northeastern University, Boston")
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//                                    .opacity(animateLogo ? 1 : 0)
//                                    .offset(y: animateLogo ? 0 : 20)
//                                    .animation(.easeOut(duration: 0.6).delay(0.3), value: animateLogo)
//
//                Spacer()
//
//                VStack(spacing: 16) {
//                    Button(action: {
//                        withAnimation { showLogin = true }
//                    }) {
//                        Text("Log In")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                            .scaleEffect(animateButtons ? 1.0 : 0.8)
//                            .opacity(animateButtons ? 1 : 0)
//                            .animation(.spring().delay(0.5), value: animateButtons)
//                    }
//
//                    Button(action: {
//                        withAnimation { showSignup = true }
//                    }) {
//                        Text("Sign Up")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.gray.opacity(0.2))
//                            .foregroundColor(.blue)
//                            .cornerRadius(10)
//                            .scaleEffect(animateButtons ? 1.0 : 0.8)
//                            .opacity(animateButtons ? 1 : 0)
//                            .animation(.spring().delay(0.6), value: animateButtons)
//                    }
//                }
//                .padding(.horizontal)
//
//                Spacer()
//
//                // NavigationLinks
//                NavigationLink(destination: LoginView(), isActive: $showLogin) {
//                    EmptyView()
//                }
//
//                NavigationLink(destination: SignupView(), isActive: $showSignup) {
//                    EmptyView()
//                }
//            }
//            .padding()
//            .onAppear {
//                animateLogo = true
//                animateButtons = true
//            }
//        }
//    }
//}


import SwiftUI

struct WelcomeView: View {
    @State private var showLogin = false
    @State private var showSignup = false
    @State private var animateLogo = false
    @State private var animateButtons = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .scaleEffect(animateLogo ? 1.0 : 0.5)
                    .opacity(animateLogo ? 1 : 0)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: animateLogo)

                Text("Find what’s lost. Return what’s found.")
                    .font(.title3.bold())
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .opacity(animateLogo ? 1 : 0)
                    .offset(y: animateLogo ? 0 : 20)
                    .animation(.easeOut(duration: 0.6).delay(0.2), value: animateLogo)

                Text("at Northeastern University, Boston")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .opacity(animateLogo ? 1 : 0)
                    .offset(y: animateLogo ? 0 : 20)
                    .animation(.easeOut(duration: 0.6).delay(0.3), value: animateLogo)

                Spacer()

                VStack(spacing: 16) {
                    Button(action: {
                        withAnimation { showLogin = true }
                    }) {
                        Text("Log In")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.neuRed)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                            .scaleEffect(animateButtons ? 1.0 : 0.8)
                            .opacity(animateButtons ? 1 : 0)
                            .animation(.spring().delay(0.5), value: animateButtons)
                    }

                    Button(action: {
                        withAnimation { showSignup = true }
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.neuRed)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.neuRed, lineWidth: 2)
                            )
                            .cornerRadius(12)
                            .scaleEffect(animateButtons ? 1.0 : 0.8)
                            .opacity(animateButtons ? 1 : 0)
                            .animation(.spring().delay(0.6), value: animateButtons)
                    }
                }
                .padding(.horizontal)

                Spacer()

                // NavigationLinks
                NavigationLink(destination: LoginView(), isActive: $showLogin) {
                    EmptyView()
                }

                NavigationLink(destination: SignupView(), isActive: $showSignup) {
                    EmptyView()
                }
            }
            .padding()
            .background(Color.neuGray.ignoresSafeArea())
            .onAppear {
                animateLogo = true
                animateButtons = true
            }
        }
    }
}
