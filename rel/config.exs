use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: :dev

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set cookie: :"lYE/,Okebo0eg1|r*:Ns9n}J&md.QkH:30P9$6Y8)~Ijsg*25.c%v.j=`w85~=)1"
end

environment :prod do
  set cookie: :"lYE/,Okebo0eg1|r*:Ns9n}J&md.QkH:30P9$6Y8)~Ijsg*25.c%v.j=`w85~=)1"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :mygadget do
  set version: current_version(:mygadget)
  plugin Bootloader
  plugin Nerves
end

