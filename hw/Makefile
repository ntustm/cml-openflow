################################################################################
#
#  NetFPGA-1G-CML http://www.netfpga.org
#
#  File:
#        HW Makefile
#        
#  Project:
#        openflow_switch_nf1_cml
#
#  Author:
#        Chu,Teng-Wei
#
#  Description:
#
#
#

include system_incl.make

NF1_CML_NGC_FILES := implementation/$(SYSTEM)_axi_interconnect_0_wrapper.ngc

NF1_CML_SCR_FILES := nf1_cml/axi_interconnect_0_wrapper_xst.scr

# PHONY TARGETS
.PHONY: dummy
.PHONY: netlistclean
.PHONY: bitsclean
.PHONY: simclean
.PHONY: exporttosdk

# EXTERNAL TARGETS
all:
	@echo "Makefile to build a Microprocessor system :"
	@echo "Run make with any of the following targets"
	@echo " "
	@echo "  netlist  : Generates the netlist for the given MHS "
	@echo "  bits     : Runs Implementation tools to generate the bitstream"	@echo " "
	@echo "  netlistclean: Deletes netlist"
	@echo "  bitsclean: Deletes bit, ncd, bmm files"
	@echo "  hwclean  : Deletes implementation dir"
	@echo " "

bits: $(SYSTEM_BIT)

ace: $(SYSTEM_ACE)

exporttosdk: $(SYSTEM_HW_HANDOFF_DEP)
	appguru -hw $(SDK_EXPORT_DIR)/$(SYSTEM).xml -app empty_application $(PROJECT_SEARCHPATHOPT)../sw/ -od $(SDK_EXPORT_DIR)/../empty_application
	@mkdir -p $(SDK_EXPORT_DIR)/../libs
	libgen -mhs $(MHSFILE) -p $(DEVICE) $(PROJECT_SEARCHPATHOPT) $(PROJECT_SEARCHPATHOPT)../sw/ -lib -od $(SDK_EXPORT_DIR)/../libs $(SDK_EXPORT_DIR)/../empty_application/$(SYSTEM).mss
	@mkdir -p $(SDK_EXPORT_DIR)/../../../host/include/
	@cp -rf $(SDK_EXPORT_DIR)/../libs/microblaze_0/include/* $(SDK_EXPORT_DIR)/../../../host/include/
	@cp -rf $(SDK_EXPORT_DIR)/../libs/microblaze_0/libsrc $(SDK_EXPORT_DIR)/../../../host/include/
	@rm -rf $(SDK_EXPORT_DIR)/../empty_application
	@rm -rf $(SDK_EXPORT_DIR)/../libs

netlist: $(POSTSYN_NETLIST)

clean: hwclean 
	rm -f _impact.cmd
	rm -rf __xps
	rm -rf blockdiagram
	rm -rf etc
	rm -f *.opt
	rm -f *.opt
	rm -f *.log
	rm -f *.make
	rm -f system.mss

hwclean: netlistclean bitsclean
	rm -rf implementation synthesis xst hdl
	rm -rf xst.srp $(SYSTEM).srp
	rm -f __xps/ise/_xmsgs/bitinit.xmsgs

netlistclean:
	rm -f $(POSTSYN_NETLIST)
	rm -f platgen.log
	rm -f __xps/ise/_xmsgs/platgen.xmsgs
	rm -f $(BMM_FILE)

bitsclean:
	rm -f $(SYSTEM_BIT)
	rm -f implementation/$(SYSTEM).ncd
	rm -f implementation/$(SYSTEM)_bd.bmm 
	rm -f implementation/$(SYSTEM)_map.ncd 
	rm -f implementation/download.bit 
	rm -f __xps/$(SYSTEM)_routed

# HARDWARE IMPLEMENTATION FLOW
$(BMM_FILE) \
$(WRAPPER_NGC_FILES): $(MHSFILE) __xps/platgen.opt \
                      $(CORE_STATE_DEVELOPMENT_FILES)
	@echo "****************************************************"
	@echo "Creating system netlist for hardware specification.."
	@echo "****************************************************"
	platgen $(PLATGEN_OPTIONS) $(MHSFILE)

#James: Platgen cannot accept special xst switch. This is a dirty workaround.
$(NF1_CML_NGC_FILES): $(NF1_CML_SCR_FILES)
	@echo "Running NetFPGA-1G-CML specific synthesis..."
	cd synthesis ; for scr in $(NF1_CML_SCR_FILES); do \
		xst -ifn ../$$scr; \
	done;

$(POSTSYN_NETLIST): $(WRAPPER_NGC_FILES) $(NF1_CML_NGC_FILES)
	@echo "Running synthesis..."
	cd synthesis; xst -ifn "system_xst.scr"

#James: Use multi-core map and par. Parameters in nf1-cml/xflow.opt
__xps/$(SYSTEM)_routed: $(FPGA_IMP_DEPENDENCY)
	@echo "*********************************************"
	@echo "Running Xilinx Implementation tools.."
	@echo "*********************************************"
	@cp -f $(UCF_FILE) implementation/$(SYSTEM).ucf
	@cp -f nf1_cml/xflow.opt implementation/xflow.opt
	xflow -wd implementation -p $(DEVICE) -implement xflow.opt $(SYSTEM).ngc
	touch __xps/$(SYSTEM)_routed

$(SYSTEM_BIT): __xps/$(SYSTEM)_routed $(BITGEN_UT_FILE)
	xilperl $(XILINX_EDK_DIR)/data/fpga_impl/observe_par.pl $(OBSERVE_PAR_OPTIONS) implementation/$(SYSTEM).par
	@echo "*********************************************"
	@echo "Running Bitgen.."
	@echo "*********************************************"
	@cp -f $(BITGEN_UT_FILE) implementation/bitgen.ut
	cd implementation ; bitgen -w -f bitgen.ut $(SYSTEM) ; cd ..

$(SYSTEM_ACE):
	@echo "In order to generate ace file, you must have:-"
	@echo "- exactly one processor."
	@echo "- opb_mdm, if using microblaze."

#################################################################
# EXPORT_TO_SDK FLOW
# #################################################################
$(SYSTEM_HW_HANDOFF): $(MHSFILE) __xps/platgen.opt
	@mkdir -p $(SDK_EXPORT_DIR)
	psf2Edward -inp $(SYSTEM).xmp -exit_on_error -edwver 1.2 -xml $(SDK_EXPORT_DIR)/$(SYSTEM).xml $(GLOBAL_SEARCHPATHOPT)
	xdsgen -inp $(SYSTEM).xmp -report $(SDK_EXPORT_DIR)/$(SYSTEM).html $(GLOBAL_SEARCHPATHOPT) -make_docs_local

$(SYSTEM_HW_HANDOFF_BIT): $(SYSTEM_BIT)
	@rm -rf $(SYSTEM_HW_HANDOFF_BIT)
	@cp -f $(SYSTEM_BIT) $(SDK_EXPORT_DIR)

$(SYSTEM_HW_HANDOFF_BMM): implementation/$(SYSTEM)_bd.bmm
	@rm -rf $(SYSTEM_HW_HANDOFF_BMM)
	@cp -f implementation/$(SYSTEM)_bd.bmm $(SDK_EXPORT_DIR)


system_incl.make: Makefile
	@echo exit|xps -nw system.xmp
