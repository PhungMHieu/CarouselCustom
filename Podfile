# Đặt global platform cho toàn bộ project
platform :ios, '12.0'

target 'CustomCarousel' do
  # Sử dụng dynamic frameworks
  use_frameworks!

  # Thêm iCarousel
  pod 'iCarousel'

  # Giúp đồng bộ iOS Deployment Target cho tất cả pods (tránh lỗi libarclite)
  post_install do |installer|
    installer.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end
end
