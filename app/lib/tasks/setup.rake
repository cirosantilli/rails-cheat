desc "Setup the application for the first time after installation. Implies db:setup."
task setup: "db:setup" do
  path = Controller0Controller.new.upload_dir
  if not Dir.exists?(path)
    Dir.mkdir(path)
  end
end
