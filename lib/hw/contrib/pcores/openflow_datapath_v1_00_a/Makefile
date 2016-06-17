################################################################################
#
#  NetFPGA-CML http://www.netfpga.org
#
#  File:
#        Makefile
#
#  Project:
#        openflowswitch
#
#  Author:
#        Chu,Teng-Wei
#
#  Description:
#        pcore makefile
#

COREGEN_DIR:= coregen

install: hdl/verilog/dp_bram_1024x256.v hdl/verilog/dp_bram_1024x64.v hdl/verilog/dp_bram_32x64.v hdl/verilog/dp_bram_1024x384.v hdl/verilog/dp_bram_32x384.v hdl/verilog/cam.v

hdl/verilog/dp_bram_1024x256.v: xco/dp_bram_1024x256.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cp coregen.cgp $(COREGEN_DIR)/
	@cd $(COREGEN_DIR) &&	coregen -p coregen.cgp -b ../xco/dp_bram_1024x256.xco
	@cp $(COREGEN_DIR)/dp_bram_1024x256.v hdl/verilog/
	@cp $(COREGEN_DIR)/dp_bram_1024x256.ngc netlist/
	@echo "/////////////////////////////////////////////";
	@echo "//Xilinx Dual Port Bram (1024x256) installed.";
	@echo "/////////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/dp_bram_1024x384.v: xco/dp_bram_1024x384.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cp coregen.cgp $(COREGEN_DIR)/
	@cd $(COREGEN_DIR) &&	coregen -p coregen.cgp -b ../xco/dp_bram_1024x384.xco
	@cp $(COREGEN_DIR)/dp_bram_1024x384.v hdl/verilog/
	@cp $(COREGEN_DIR)/dp_bram_1024x384.ngc netlist/
	@echo "/////////////////////////////////////////////";
	@echo "//Xilinx Dual Port Bram (1024x384) installed.";
	@echo "/////////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/dp_bram_1024x64.v: xco/dp_bram_1024x64.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cp coregen.cgp $(COREGEN_DIR)/
	@cd $(COREGEN_DIR) &&	coregen -p coregen.cgp -b ../xco/dp_bram_1024x64.xco
	@cp $(COREGEN_DIR)/dp_bram_1024x64.v hdl/verilog/
	@cp $(COREGEN_DIR)/dp_bram_1024x64.ngc netlist/
	@echo "/////////////////////////////////////////////";
	@echo "//Xilinx Dual Port Bram (1024x64) installed.";
	@echo "/////////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/dp_bram_32x384.v: xco/dp_bram_32x384.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cp coregen.cgp $(COREGEN_DIR)/
	@cd $(COREGEN_DIR) &&	coregen -p coregen.cgp -b ../xco/dp_bram_32x384.xco
	@cp $(COREGEN_DIR)/dp_bram_32x384.v hdl/verilog/
	@cp $(COREGEN_DIR)/dp_bram_32x384.ngc netlist/
	@echo "/////////////////////////////////////////////";
	@echo "//Xilinx Dual Port Bram (32x384) installed.";
	@echo "/////////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/dp_bram_32x64.v: xco/dp_bram_32x64.xco
	@mkdir -p netlist;
	@mkdir -p $(COREGEN_DIR);
	@cp coregen.cgp $(COREGEN_DIR)/
	@cd $(COREGEN_DIR) &&	coregen -p coregen.cgp -b ../xco/dp_bram_32x64.xco
	@cp $(COREGEN_DIR)/dp_bram_32x64.v hdl/verilog/
	@cp $(COREGEN_DIR)/dp_bram_32x64.ngc netlist/
	@echo "/////////////////////////////////////////////";
	@echo "//Xilinx Dual Port Bram (32x64) installed.";
	@echo "/////////////////////////////////////////////";
	@rm -rf $(COREGEN_DIR);

hdl/verilog/cam.v: cam_work/xapp1151_cam_v1_1/implement/vhdl_xst.scr
	@mkdir -p netlist;
	@cd cam_work/xapp1151_cam_v1_1/implement/ && xilperl RunXST.pl
	@cp cam_work/cam.v hdl/verilog/
	@cp cam_work/xapp1151_cam_v1_1/implement/results/cam.ngc netlist/
	@cd

clean:
	@rm -rf hdl/verilog/dp_bram_*
	@rm -rf netlist
	@rm -rf hdl/verilog/cam.v
	@rm -rf simhdl
	@rm -rf $(COREGEN_DIR)
