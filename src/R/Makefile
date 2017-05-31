# $Id$
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 5.6 (Emerald Boa)
# 		         version 6.1 (Emerald Boa)
# 
# Copyright (c) 2000 - 2013 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@
#
# $Log$

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk

$(NAME).spec: DESCRIPTION LICENSE

DESCRIPTION:
	$(MODULE_LOAD_CC); \
	( \
	  $(DESCRIBE_PKG); \
	  $(DESCRIBE_CC) \
	) > $@
	$(MODULE_LOAD_MKL); \
	if test -n "$${MKL_ROOT}"; then \
	  $(DESCRIBE_MKL) >> $@; \
	fi

LICENSE: $(SRC_DIRS)
	$(CHECK_LICENSE_FILES)
	echo GPL > $@

build: $(SRC_DIRS)
	# NOTE: per R doc, we compile w/out --with-blas if MKL missing
	patch $(BZIP2_DIR)/Makefile patch-files/Makefile.patch
	( \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_MKL); \
	  export CONFIG_OPTS="--enable-R-shlib --enable-threads=posix"; \
	  if test -n "$${MKL_ROOT}"; then \
	    export MKLLIB=`find $${MKL_ROOT}/lib/* -maxdepth 0 | head -1`; \
	    export MKLLINK="-L$${MKLLIB} -lmkl_rt"; \
	    export BLAS_LIBS="$${MKLLINK}"; \
	    export LAPACK_LIBS="$${MKLLINK}"; \
	    export CONFIG_OPTS="$${CONFIG_OPTS} --with-blas --with-lapack"; \
	  fi; \
	  export CC=$(CC); \
	  export CXX=$(CXX); \
	  export FC=$(FC); \
	  export F77=$(FC); \
          cd $(ZLIB_DIR); \
          ./configure --prefix=$(CURDIR)/zlib; \
          make; \
          make install; \
          cd ../$(BZIP2_DIR); \
          make install PREFIX=$(CURDIR)/bzip2; \
          cd ../$(XZ_DIR); \
          ./configure --prefix=$(CURDIR)/xz; \
          make; \
          make install; \
          cd ../$(PCRE_DIR); \
          ./configure --prefix=$(CURDIR)/pcre --enable-utf8; \
          make; \
          make install; \
          cd ../$(CURL_DIR); \
          ./configure --prefix=$(CURDIR)/curl; \ make; \
          make install; \
          cd ..; \
          mkdir pcre/include/pcre; \
          cp  pcre/include/pcre.h pcre/include/pcre; \
          export CPPFLAGS="-I$(CURDIR)/zlib/include -I$(CURDIR)/bzip2/include -I$(CURDIR)/xz/include -I$(CURDIR)/pcre/include -I$(CURDIR)/curl/include"; \
          export LDFLAGS="-L$(CURDIR)/zlib/lib -L$(CURDIR)/bzip2/lib -L$(CURDIR)/xz/lib -L$(CURDIR)/pcre/lib -L$(CURDIR)/curl/lib"; \
          export LD_LIBRARY_PATH=$(CURDIR)/zlib/lib:$(CURDIR)/bzip2/lib:$(CURDIR)/xz/lib:$(CURDIR)/pcre/lib:$(CURDIR)/curl/lib:$${LD_LIBRARY_PATH}; \
	  cd $(SOURCE_DIR); \
	  ./configure --prefix=$(PKGROOT) $${CONFIG_OPTS}; \
	  $(MAKE) \
	)
	@echo "::: Package $(NAME) build complete :::"

install::
	# Bind mount seems to be the only way to keep the install from writing
	# the install dir into binary files.
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	$(PKGROOT_BIND_MOUNT)
	( \
	  $(MODULE_LOAD_CC); \
	  cd $(SOURCE_DIR); \
	  $(MAKE) install; \
	  $(MAKE) install-tests; \
          cd ..; \
          cp -r bzip2/lib/* xz/lib/* pcre/lib/* curl/lib/* zlib/lib/* $(ROOT)/$(PKGROOT)/lib64/R/lib \
	)
	$(PKGROOT_BIND_UMOUNT)
	$(INSTALL_LICENSE_FILES)
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf $(SOURCE_DIR) DESCRIPTION LICENSE zlib bzip2 xz pcre curl
