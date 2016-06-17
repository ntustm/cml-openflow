###########################################################
#  File:
#        Makefile
#  Project:
#        openflow-cml
#  Author:
#        Chu,Teng-Wei
#  Description:
#        make : 		Generate bitfile
#		 make download: Power on NetFPGA-CML and run this to download bitfile
#        make clean : 	clean all generation files

SYSTEM = system
HW = hw
SW = sw
PROJECT_NAME = openflow_cml

all: 
	$(MAKE) -C $(HW) bits
	mkdir -p bitfiles
	cp $(HW)/implementation/system.bit bitfiles/$(PROJECT_NAME).bit

download: bitfiles/$(PROJECT_NAME).bit
	cp bitfiles/$(PROJECT_NAME).bit bitfiles/download.bit
	impact -batch nf1_cml/program.bat
	rm -f bitfiles/download.bit

clean:
	$(MAKE) -C $(HW) clean
	rm -f bitfiles/

