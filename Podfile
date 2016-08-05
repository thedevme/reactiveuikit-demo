platform :ios, '8.0'
use_frameworks!
inhibit_all_warnings!


target 'ReactiveKitDemo' do
    pod 'ReactiveKit', '~> 2.1'
    pod 'ReactiveUIKit', '~> 2.0'
end

# Prevents embedding swift libraries in every embedded framework / module
post_install do |installer|
    system "sed -i '' -E 's/EMBEDDED_CONTENT_CONTAINS_SWIFT[[:space:]]=[[:space:]]YES/EMBEDDED_CONTENT_CONTAINS_SWIFT = NO/g' Pods/Target\\ Support\\ Files/*/*.xcconfig"
end
