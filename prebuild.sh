cd endstream
flutter clean
flutter pub get
cd ios
rm -rf Podfile.lock || true
pod install
cd ..
