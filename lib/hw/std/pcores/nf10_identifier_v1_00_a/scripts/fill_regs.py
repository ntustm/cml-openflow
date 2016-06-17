import time;

output_file = open("rom_data.txt", "w")

#(Reg1,Reg2) implement time
ticks = int(time.time())
epoch_upper = hex(ticks/pow(2,32))[2:]
epoch_lower = hex(ticks%pow(2,32))[2:]
output_file.write(epoch_upper.zfill(8)+"\n")
output_file.write(epoch_lower.zfill(8)+"\n")

#Reg3: project info
project_id = 0x2811 #14bit <3fff
is_reference = 0x0
dma_version = 0x0f #8bit ff magic num: 0x0f unique
phy_init_by = 0x1 #1:driver 0:microblaze
reg_in_pipeline = 0x1
test_suit_avail = 0x0
tool_flow = 0x02 #01:ise 02:edk 03:vivado
reg3 = project_id | (is_reference << 15) | (dma_version << 16) \
	| (phy_init_by << 24) | (reg_in_pipeline << 25) \
	| (test_suit_avail << 26) | (tool_flow << 27)
reg3 = hex(reg3)[2:]
output_file.write(reg3.zfill(8)+"\n")
#Reg4: git tag
git_tag = "CA0"
output_file.write(git_tag.zfill(8)+"\n")
#Reg5: 
board_asm_num = 0
pcb_version = 0
board_id = 0x3
board_revision = 0
reg5 = (board_asm_num << 24) | (pcb_version << 16) | (board_id << 8) | board_revision
reg5 = hex(reg5)[2:]
output_file.write(reg5.zfill(8)+"\n")
for i in range(11):
	output_file.write("00000000\n")
