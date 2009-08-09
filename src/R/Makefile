#
# $Id$
#
# @Copyright@
#
# 				Rocks(tm)
# 		         www.rocksclusters.org
# 		        version 4.3 (Mars Hill)
#
# Copyright (c) 2000 - 2007 The Regents of the University of California.
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
# 	"This product includes software developed by the Rocks(tm)
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
# Revision 1.1  2009/08/09 20:31:19  jhayes
# Build R from source so that it can be installed in /opt/R and packages can be
# built and added during the roll building process, rather than during cluster
# install.
#
# Revision 1.8  2009/06/09 21:45:38  jhayes
# Correction to installation of cgi.cfg.
#
# Revision 1.7  2009/04/28 18:23:47  jhayes
# Remove disused include.
#
# Revision 1.6  2009/04/15 16:50:26  jhayes
# Allow specification of per-service monitoring timeperiod.  Remove copying of
# sample configuration to target.
#
# Revision 1.5  2009/03/27 22:58:28  jhayes
# Debugging.
#
# Revision 1.4  2009/03/26 21:26:50  jhayes
# Begin working on using rocks command to manipulate nagios config.
#
# Revision 1.3  2009/03/13 19:07:55  jhayes
# Clean up node XML and Makefile.
#
# Revision 1.2  2009/03/12 18:44:35  jhayes
# Initial version working on triton.
#
# Revision 1.1  2009/02/05 18:36:05  bruno
# added
#
#

PKGROOT = /opt/R
REDHAT.ROOT = $(PWD)/../../

-include $(ROCKSROOT)/etc/Rules.mk

build:
	yum -y install curl-devel
	yum -y install readline-devel
	tar zxvf $(NAME)-$(VERSION).tar.gz
	( \
	  cd $(NAME)-$(VERSION); \
	  ./configure --prefix=$(PKGROOT); \
	  make \
	)

install::
	mkdir -p $(ROOT)/$(PKGROOT)
	( \
	  cd $(NAME)-$(VERSION); \
	  make install; \
	  cd ..; \
	  if test -r install_packages.sh; then \
	    bash install_packages.sh $(PKGROOT); \
	  fi; \
	  mv $(PKGROOT)/* $(ROOT)/$(PKGROOT); \
	  rmdir $(PKGROOT) \
	)

clean::
	rm -rf $(NAME)-$(VERSION)
