
require include/techleef-image.inc

IMAGE_FEATURES += "allow-empty-password allow-root-login dev-pkgs ..."
IMAGE_INSTALL:append = " "

blabla(){
    # action ${IMAGE_ROOTFS}
}

ROOTFS_PREPROCESS_COMMAND += ";blabla"
