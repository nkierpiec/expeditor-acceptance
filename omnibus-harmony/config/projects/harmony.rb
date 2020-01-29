name 'harmony'
maintainer "Chef Software Inc"
homepage   "https://www.chef.io"
license "Apache-2.0"
license_file "LICENSE"

install_dir "#{default_root}/#{name}"

build_version "0.0.76"
build_iteration 1

# creates required build directories
dependency 'preparation'

# harmony dependencies/components
dependency "libxml2"
dependency "libxslt"
dependency "libiconv"
dependency "liblzma"
dependency "zlib"
dependency 'openssl'

unless windows?
  # builds the 'discord' dummy project
  # see the discord software def. for more details
  dependency 'discord'
end

exclude '\.git*'
exclude 'bundler\/git'
exclude 'man\/'

package :rpm do
  signing_passphrase ENV["OMNIBUS_RPM_SIGNING_PASSPHRASE"]
end

package :pkg do
  identifier 'com.getchef.harmony'
  signing_identity 'Chef Software, Inc. (EU3VF8YLX2)'
end
compress :dmg

package :msi do
  upgrade_code 'D607A85C-BDFA-4F08-83ED-2ECB4DCD6BC5'
  signing_identity "AF21BA8C9E50AE20DA9907B6E2D4B0CC3306CA03", machine_store: true
end
