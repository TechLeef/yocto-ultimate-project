LICENSE = "CLOSED"

inherit core-image

# Common packages
IMAGE_INSTALL = "packagegroup-core-boot"
IMAGE_FEATURES += "ssh-server-openssh"

IMAGE_INSTALL:append = " bash"

# Dev
IMAGE_FEATURES:techleef-dev += "allow-empty-password allow-root-login"
IMAGE_INSTALL:append:techleef-dev = " packagegroup-build-essential"

MACHINE_ESSENTIAL_EXTRA_RRECOMMENDS = ""

INCOMPATIBLE_LICENSE = "GPL-3.0* LGPL-3.0* AGPL-3.0*"
INCOMPATIBLE_LICENSE_EXCEPTIONS:techleef-dev += "\
    bash:GPL-3.0-or-later \
"
