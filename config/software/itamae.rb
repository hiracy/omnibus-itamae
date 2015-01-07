name "itamae"
default_version "1.1.1"

dependency "ruby"
dependency "rubygems"

env = {
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  gem "install itamae --no-ri --no-rdoc -v #{version}", env: env
  command "sudo ln -fs #{install_dir}/embedded/bin/itamae /usr/local/bin/itamae", env: env
end
