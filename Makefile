###########################################################
#
#  NetFPGA-1G-CML http://www.netfpga.org
#
#  File:
#        Makefile
#
#  Project:
#        openflow_switch_nf1_cml
#
#  Author:
#        Chu,Teng-Wei
#
#  Description:
#        make : 
#
#        make clean : 
#

SYSTEM = system
HW = hw
SW = sw
PROJECT_NAME = openflow_switch_nf1_cml

all: 
	$(MAKE) -C $(HW)
	$(MAKE) -C $(SW)
	mkdir -p bitfiles
	cp $(SW)/result/download.bit bitfiles/$(PROJECT_NAME).bit

download: bitfiles/$(PROJECT_NAME).bit
	cp bitfiles/$(PROJECT_NAME).bit bitfiles/download.bit
	impact -batch nf1_cml/program.bat
	rm -f bitfiles/download.bit

clean:
	$(MAKE) -C $(HW) clean
	$(MAKE) -C $(SW) clean
	rm -f bitfiles/

