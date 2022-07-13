

Pod::Spec.new do |spec|

 

  spec.name         = "CocoaDemoSpec"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of CocoaDemoSpec."

  
  spec.description  = <<-DESC
                   CocoaDemo is the demo for creating our own new Cocoapod
                   DESC

  spec.homepage =  "https://github.com/Wasim2708/Project"
  #spec.homepage     = "/Users/wasim-zstk238/Desktop/"



   spec.license      = { :type => "MIT", :file => "LICENSE" }



  spec.author             = { "Wasim2708" => "wasim.27a@gmail.com" }


  spec.platform     = :ios, "13.0"

  spec.source = { :git => "https://github.com/Wasim2708/Project.git" , :tag  => "#{spec.version}"}
  #spec.source  =  { :svn => 'file:' + __dir__ + "/CocoaDemo_Project/" }

  spec.source_files  = "CocoaDemo_Project/**/*.{h,swift}"


end
