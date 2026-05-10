// Manual outer wrapper for the full DTI SoC NoC compile ingress.
// Use the FCIP child filelists directly because vc/fcip.f embeds `ifndef guards
// that VCS -f parses as file names instead of preprocessing.
-f /home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/fcip/vc/arbiter.f
-f /home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/fcip/vc/async_fifo.f
-f /home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/fcip/vc/basic.f
-f /home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/fcip/vc/ecc_codec.f
-f /home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/fcip/vc/memory.f
-f /home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/fcip/vc/regslice.f
-f /home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/fcip/vc/stdcell_wrap.f
-f /home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/fcip/vc/sync_fifo.f
-f /home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/fcip/vc/handshake.f
-f /home/lgzhu/dev/noc_work/lwnoc_network_demo/subs/lwnoc_lowpower_component/src/vc/lwnoc_lp_core.f
-f $DTI_LOGIC_TOPO_DIR/dti_logic_topo/filelist.f