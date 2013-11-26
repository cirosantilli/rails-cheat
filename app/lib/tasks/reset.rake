desc "Does db:reset, removes the upload directory then runs rake setup."
task reset: "db:drop" do
  #TODO why does this work for the setup, but not for reset???
  path = Controller0Controller.new.upload_dir
  if Dir.exists?(path)
    require 'fileutils'
    FileUtils.rm_rf(path)
  end
  Rake::Task[:setup].invoke
end
