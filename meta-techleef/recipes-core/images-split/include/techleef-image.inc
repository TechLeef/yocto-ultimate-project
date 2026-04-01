LICENSE = "CLOSED"

inherit core-image

IMAGE_INSTALL = "packagegroup-core-boot"

IMAGE_LINGUAS = ""
IMAGE_FEATURES = ""
IMAGE_INSTALL = ""

# Add base project packages
IMAGE_INSTALL:append = " packagegroup-techleef a b c"

