#************parameter input*************
#※prepare the source list file  and then make add the soucefile name 
#for example ,the Verilog source file's name is vlog_list.f then :make norsim src_list=file_list
src_list =  filelist
simv_name = simv
vpdpluse_name = vcdpluse
cov_file_name = coverage
vdb_name = $(simv_name)
#************constant command************
#compile
NOR_VCS = vcs -full64 -sverilog +v2k -timescale=1ns/1ns            \
      -debug_all                               \
      +notimingcheck                                   \
      +nospecify                                       \
      +vcs+flush+all                                   \
      -o $(simv_name)   \
      -l compile.log	\
	  -f $(src_list).f 
 
#coverage compile switch 
COV_SW = -cm line+cond+fsm+branch+tgl
 
#verdi dump wave compile option 
VERDI_SW = -P /home/synopsys/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/linux64/novas.tab \
	/home/synopsys/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/linux64/pli.a   #根据实际路径进行修改

 
#run option
RUN_GUI = -R -gui -l run.log
RUN_VPD = -R +vpdfile+$(vpdpluse_name).vpd -l run.log
RUN_COV = -R $(COV_SW) -cm_name $(vdb_name) -cm_dir ./$(cov_file_name) -l run.log
RUN_VER = -R +fsdb+autoflush -l run.log
#************command************
#normally sim
norsim: 
	$(NOR_VCS) $(RUN_GUI) 
 
#post-process
postsim:
	$(NOR_VCS)  $(RUN_VPD) 
	dve -vpd $(vpdpluse_name).vpd
 
#coverage
covsim:
	$(NOR_VCS) $(COV_SW) $(RUN_COV) 
	dve -covdir $(cov_file_name).vdb
 
#verdi
#versim:
run_vcs:
	$(NOR_VCS) $(VERDI_SW) $(RUN_VER)
 
vd:
	verdi -sv -f $(src_list).f -ssf *.fsdb -nologo
 
 
#rm 
clr:
	rm -rf *csrc ./*.daidir $(simv_name) *simv* DVE* ucli* *.vpd *.vdb *.log *.fsdb *novas* *.dat *Log *rc *conf
