desc "Setup the application for the first time after installation. Does db:setup and creates the upload directory."
task setup: "db:setup" do
  path = Controller0Controller.new.upload_dir
  if not Dir.exists?(path)
    Dir.mkdir(path)
  end
end
