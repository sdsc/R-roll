NAME        = R-modules
RELEASE     = 3
PKGROOT     = /opt/modulefiles/applications/R

VERSION_SRC = $(REDHAT.ROOT)/src/R/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No
