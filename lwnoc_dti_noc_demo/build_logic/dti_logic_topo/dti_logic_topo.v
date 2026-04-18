//[UHDL]Content Start [md5:4508e29c3e48a802c45c48d0950a25c4]
module dti_logic_topo (
	input         clk_noc                                                       ,
	input         rst_noc_n                                                     ,
	input         pcie_eth_iniu_node_clk_sys_porting_clk_sys_clk                ,
	input         pcie_eth_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n          ,
	input  [79:0] pcie_eth_iniu_node_dti_req_porting_dti_req_req_tdata          ,
	input  [9:0]  pcie_eth_iniu_node_dti_req_porting_dti_req_req_tkeep          ,
	input         pcie_eth_iniu_node_dti_req_porting_dti_req_req_tlast          ,
	output        pcie_eth_iniu_node_dti_req_porting_dti_req_req_tready         ,
	input  [5:0]  pcie_eth_iniu_node_dti_req_porting_dti_req_req_ttid           ,
	input         pcie_eth_iniu_node_dti_req_porting_dti_req_req_tvalid         ,
	output [79:0] pcie_eth_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata          ,
	output [9:0]  pcie_eth_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep          ,
	output        pcie_eth_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast          ,
	input         pcie_eth_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready         ,
	output [5:0]  pcie_eth_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid           ,
	output        pcie_eth_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid         ,
	input  [9:0]  pcie_eth_iniu_node_timeout_val_porting_timeout_val_timeout_val,
	output        pcie_eth_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept      ,
	output [1:0]  pcie_eth_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive      ,
	output        pcie_eth_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny        ,
	input         pcie_eth_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq         ,
	input  [1:0]  pcie_eth_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate       ,
	input         vpu_iniu_node_clk_sys_porting_clk_sys_clk                     ,
	input         vpu_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n               ,
	input  [79:0] vpu_iniu_node_dti_req_porting_dti_req_req_tdata               ,
	input  [9:0]  vpu_iniu_node_dti_req_porting_dti_req_req_tkeep               ,
	input         vpu_iniu_node_dti_req_porting_dti_req_req_tlast               ,
	output        vpu_iniu_node_dti_req_porting_dti_req_req_tready              ,
	input  [5:0]  vpu_iniu_node_dti_req_porting_dti_req_req_ttid                ,
	input         vpu_iniu_node_dti_req_porting_dti_req_req_tvalid              ,
	output [79:0] vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata               ,
	output [9:0]  vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep               ,
	output        vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast               ,
	input         vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready              ,
	output [5:0]  vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid                ,
	output        vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid              ,
	input  [9:0]  vpu_iniu_node_timeout_val_porting_timeout_val_timeout_val     ,
	output        vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept           ,
	output [1:0]  vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive           ,
	output        vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny             ,
	input         vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq              ,
	input  [1:0]  vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate            ,
	input         dsp2_iniu_node_clk_sys_porting_clk_sys_clk                    ,
	input         dsp2_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n              ,
	input  [79:0] dsp2_iniu_node_dti_req_porting_dti_req_req_tdata              ,
	input  [9:0]  dsp2_iniu_node_dti_req_porting_dti_req_req_tkeep              ,
	input         dsp2_iniu_node_dti_req_porting_dti_req_req_tlast              ,
	output        dsp2_iniu_node_dti_req_porting_dti_req_req_tready             ,
	input  [5:0]  dsp2_iniu_node_dti_req_porting_dti_req_req_ttid               ,
	input         dsp2_iniu_node_dti_req_porting_dti_req_req_tvalid             ,
	output [79:0] dsp2_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata              ,
	output [9:0]  dsp2_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep              ,
	output        dsp2_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast              ,
	input         dsp2_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready             ,
	output [5:0]  dsp2_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid               ,
	output        dsp2_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid             ,
	input  [9:0]  dsp2_iniu_node_timeout_val_porting_timeout_val_timeout_val    ,
	output        dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept          ,
	output [1:0]  dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive          ,
	output        dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny            ,
	input         dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq             ,
	input  [1:0]  dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate           ,
	input         dsp1_iniu_node_clk_sys_porting_clk_sys_clk                    ,
	input         dsp1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n              ,
	input  [79:0] dsp1_iniu_node_dti_req_porting_dti_req_req_tdata              ,
	input  [9:0]  dsp1_iniu_node_dti_req_porting_dti_req_req_tkeep              ,
	input         dsp1_iniu_node_dti_req_porting_dti_req_req_tlast              ,
	output        dsp1_iniu_node_dti_req_porting_dti_req_req_tready             ,
	input  [5:0]  dsp1_iniu_node_dti_req_porting_dti_req_req_ttid               ,
	input         dsp1_iniu_node_dti_req_porting_dti_req_req_tvalid             ,
	output [79:0] dsp1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata              ,
	output [9:0]  dsp1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep              ,
	output        dsp1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast              ,
	input         dsp1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready             ,
	output [5:0]  dsp1_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid               ,
	output        dsp1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid             ,
	input  [9:0]  dsp1_iniu_node_timeout_val_porting_timeout_val_timeout_val    ,
	output        dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept          ,
	output [1:0]  dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive          ,
	output        dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny            ,
	input         dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq             ,
	input  [1:0]  dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate           ,
	input         dsp0_iniu_node_clk_sys_porting_clk_sys_clk                    ,
	input         dsp0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n              ,
	input  [79:0] dsp0_iniu_node_dti_req_porting_dti_req_req_tdata              ,
	input  [9:0]  dsp0_iniu_node_dti_req_porting_dti_req_req_tkeep              ,
	input         dsp0_iniu_node_dti_req_porting_dti_req_req_tlast              ,
	output        dsp0_iniu_node_dti_req_porting_dti_req_req_tready             ,
	input  [5:0]  dsp0_iniu_node_dti_req_porting_dti_req_req_ttid               ,
	input         dsp0_iniu_node_dti_req_porting_dti_req_req_tvalid             ,
	output [79:0] dsp0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata              ,
	output [9:0]  dsp0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep              ,
	output        dsp0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast              ,
	input         dsp0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready             ,
	output [5:0]  dsp0_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid               ,
	output        dsp0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid             ,
	input  [9:0]  dsp0_iniu_node_timeout_val_porting_timeout_val_timeout_val    ,
	output        dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept          ,
	output [1:0]  dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive          ,
	output        dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny            ,
	input         dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq             ,
	input  [1:0]  dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate           ,
	input         noc_tbu1_iniu_node_clk_sys_porting_clk_sys_clk                ,
	input         noc_tbu1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n          ,
	input  [79:0] noc_tbu1_iniu_node_dti_req_porting_dti_req_req_tdata          ,
	input  [9:0]  noc_tbu1_iniu_node_dti_req_porting_dti_req_req_tkeep          ,
	input         noc_tbu1_iniu_node_dti_req_porting_dti_req_req_tlast          ,
	output        noc_tbu1_iniu_node_dti_req_porting_dti_req_req_tready         ,
	input  [5:0]  noc_tbu1_iniu_node_dti_req_porting_dti_req_req_ttid           ,
	input         noc_tbu1_iniu_node_dti_req_porting_dti_req_req_tvalid         ,
	output [79:0] noc_tbu1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata          ,
	output [9:0]  noc_tbu1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep          ,
	output        noc_tbu1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast          ,
	input         noc_tbu1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready         ,
	output [5:0]  noc_tbu1_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid           ,
	output        noc_tbu1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid         ,
	input  [9:0]  noc_tbu1_iniu_node_timeout_val_porting_timeout_val_timeout_val,
	output        noc_tbu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept      ,
	output [1:0]  noc_tbu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive      ,
	output        noc_tbu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny        ,
	input         noc_tbu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq         ,
	input  [1:0]  noc_tbu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate       ,
	input         usb_ufs_iniu_node_clk_sys_porting_clk_sys_clk                 ,
	input         usb_ufs_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n           ,
	input  [79:0] usb_ufs_iniu_node_dti_req_porting_dti_req_req_tdata           ,
	input  [9:0]  usb_ufs_iniu_node_dti_req_porting_dti_req_req_tkeep           ,
	input         usb_ufs_iniu_node_dti_req_porting_dti_req_req_tlast           ,
	output        usb_ufs_iniu_node_dti_req_porting_dti_req_req_tready          ,
	input  [5:0]  usb_ufs_iniu_node_dti_req_porting_dti_req_req_ttid            ,
	input         usb_ufs_iniu_node_dti_req_porting_dti_req_req_tvalid          ,
	output [79:0] usb_ufs_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata           ,
	output [9:0]  usb_ufs_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep           ,
	output        usb_ufs_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast           ,
	input         usb_ufs_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready          ,
	output [5:0]  usb_ufs_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid            ,
	output        usb_ufs_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid          ,
	input  [9:0]  usb_ufs_iniu_node_timeout_val_porting_timeout_val_timeout_val ,
	output        usb_ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept       ,
	output [1:0]  usb_ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive       ,
	output        usb_ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny         ,
	input         usb_ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq          ,
	input  [1:0]  usb_ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate        ,
	input         mipi0_iniu_node_clk_sys_porting_clk_sys_clk                   ,
	input         mipi0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n             ,
	input  [79:0] mipi0_iniu_node_dti_req_porting_dti_req_req_tdata             ,
	input  [9:0]  mipi0_iniu_node_dti_req_porting_dti_req_req_tkeep             ,
	input         mipi0_iniu_node_dti_req_porting_dti_req_req_tlast             ,
	output        mipi0_iniu_node_dti_req_porting_dti_req_req_tready            ,
	input  [5:0]  mipi0_iniu_node_dti_req_porting_dti_req_req_ttid              ,
	input         mipi0_iniu_node_dti_req_porting_dti_req_req_tvalid            ,
	output [79:0] mipi0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata             ,
	output [9:0]  mipi0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep             ,
	output        mipi0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast             ,
	input         mipi0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready            ,
	output [5:0]  mipi0_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid              ,
	output        mipi0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid            ,
	input  [9:0]  mipi0_iniu_node_timeout_val_porting_timeout_val_timeout_val   ,
	output        mipi0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept         ,
	output [1:0]  mipi0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive         ,
	output        mipi0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny           ,
	input         mipi0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq            ,
	input  [1:0]  mipi0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate          ,
	input         mipi1_iniu_node_clk_sys_porting_clk_sys_clk                   ,
	input         mipi1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n             ,
	input  [79:0] mipi1_iniu_node_dti_req_porting_dti_req_req_tdata             ,
	input  [9:0]  mipi1_iniu_node_dti_req_porting_dti_req_req_tkeep             ,
	input         mipi1_iniu_node_dti_req_porting_dti_req_req_tlast             ,
	output        mipi1_iniu_node_dti_req_porting_dti_req_req_tready            ,
	input  [5:0]  mipi1_iniu_node_dti_req_porting_dti_req_req_ttid              ,
	input         mipi1_iniu_node_dti_req_porting_dti_req_req_tvalid            ,
	output [79:0] mipi1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata             ,
	output [9:0]  mipi1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep             ,
	output        mipi1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast             ,
	input         mipi1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready            ,
	output [5:0]  mipi1_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid              ,
	output        mipi1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid            ,
	input  [9:0]  mipi1_iniu_node_timeout_val_porting_timeout_val_timeout_val   ,
	output        mipi1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept         ,
	output [1:0]  mipi1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive         ,
	output        mipi1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny           ,
	input         mipi1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq            ,
	input  [1:0]  mipi1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate          ,
	input         camera_iniu_node_clk_sys_porting_clk_sys_clk                  ,
	input         camera_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n            ,
	input  [79:0] camera_iniu_node_dti_req_porting_dti_req_req_tdata            ,
	input  [9:0]  camera_iniu_node_dti_req_porting_dti_req_req_tkeep            ,
	input         camera_iniu_node_dti_req_porting_dti_req_req_tlast            ,
	output        camera_iniu_node_dti_req_porting_dti_req_req_tready           ,
	input  [5:0]  camera_iniu_node_dti_req_porting_dti_req_req_ttid             ,
	input         camera_iniu_node_dti_req_porting_dti_req_req_tvalid           ,
	output [79:0] camera_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata            ,
	output [9:0]  camera_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep            ,
	output        camera_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast            ,
	input         camera_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready           ,
	output [5:0]  camera_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid             ,
	output        camera_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid           ,
	input  [9:0]  camera_iniu_node_timeout_val_porting_timeout_val_timeout_val  ,
	output        camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept        ,
	output [1:0]  camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive        ,
	output        camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny          ,
	input         camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq           ,
	input  [1:0]  camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate         ,
	input         noc_tbu0_iniu_node_clk_sys_porting_clk_sys_clk                ,
	input         noc_tbu0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n          ,
	input  [79:0] noc_tbu0_iniu_node_dti_req_porting_dti_req_req_tdata          ,
	input  [9:0]  noc_tbu0_iniu_node_dti_req_porting_dti_req_req_tkeep          ,
	input         noc_tbu0_iniu_node_dti_req_porting_dti_req_req_tlast          ,
	output        noc_tbu0_iniu_node_dti_req_porting_dti_req_req_tready         ,
	input  [5:0]  noc_tbu0_iniu_node_dti_req_porting_dti_req_req_ttid           ,
	input         noc_tbu0_iniu_node_dti_req_porting_dti_req_req_tvalid         ,
	output [79:0] noc_tbu0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata          ,
	output [9:0]  noc_tbu0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep          ,
	output        noc_tbu0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast          ,
	input         noc_tbu0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready         ,
	output [5:0]  noc_tbu0_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid           ,
	output        noc_tbu0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid         ,
	input  [9:0]  noc_tbu0_iniu_node_timeout_val_porting_timeout_val_timeout_val,
	output        noc_tbu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept      ,
	output [1:0]  noc_tbu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive      ,
	output        noc_tbu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny        ,
	input         noc_tbu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq         ,
	input  [1:0]  noc_tbu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate       ,
	input         tcu_tniu_node_clk_sys_porting_clk_sys_clk                     ,
	input         tcu_tniu_node_rst_sys_n_porting_rst_sys_n_rst_n               ,
	output [79:0] tcu_tniu_node_dti_req_porting_dti_req_req_tdata               ,
	output [9:0]  tcu_tniu_node_dti_req_porting_dti_req_req_tkeep               ,
	output        tcu_tniu_node_dti_req_porting_dti_req_req_tlast               ,
	input         tcu_tniu_node_dti_req_porting_dti_req_req_tready              ,
	output [5:0]  tcu_tniu_node_dti_req_porting_dti_req_req_ttid                ,
	output        tcu_tniu_node_dti_req_porting_dti_req_req_tvalid              ,
	input  [79:0] tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tdata               ,
	input  [9:0]  tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep               ,
	input         tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tlast               ,
	output        tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tready              ,
	input  [5:0]  tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_ttid                ,
	input         tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid              ,
	output        tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept           ,
	output [1:0]  tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive           ,
	output        tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny             ,
	input         tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq              ,
	input  [1:0]  tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate            );

	//Wire define for this module.

	//Wire define for sub module.
	wire        pcie_eth_iniu_TO_sw_left3_SIG_top_req_req_valid       ;
	wire [89:0] pcie_eth_iniu_TO_sw_left3_SIG_top_req_req_payload     ;
	wire [5:0]  pcie_eth_iniu_TO_sw_left3_SIG_top_req_req_srcid       ;
	wire        pcie_eth_iniu_TO_sw_left3_SIG_top_req_req_last        ;
	wire        pcie_eth_iniu_TO_sw_left3_SIG_top_rsp_rsp_ready       ;
	wire        vpu_iniu_TO_sw_left3_SIG_top_req_req_valid            ;
	wire [89:0] vpu_iniu_TO_sw_left3_SIG_top_req_req_payload          ;
	wire [5:0]  vpu_iniu_TO_sw_left3_SIG_top_req_req_srcid            ;
	wire        vpu_iniu_TO_sw_left3_SIG_top_req_req_last             ;
	wire        vpu_iniu_TO_sw_left3_SIG_top_rsp_rsp_ready            ;
	wire        dsp2_iniu_TO_sw_left3_SIG_top_req_req_valid           ;
	wire [89:0] dsp2_iniu_TO_sw_left3_SIG_top_req_req_payload         ;
	wire [5:0]  dsp2_iniu_TO_sw_left3_SIG_top_req_req_srcid           ;
	wire        dsp2_iniu_TO_sw_left3_SIG_top_req_req_last            ;
	wire        dsp2_iniu_TO_sw_left3_SIG_top_rsp_rsp_ready           ;
	wire        sw_left_dsp1_TO_sw_left3_SIG_iniu0_req_ready          ;
	wire        sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_valid          ;
	wire [89:0] sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_payload        ;
	wire [5:0]  sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_srcid          ;
	wire        sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_last           ;
	wire        sw_left3_TO_sw_left_dsp1_SIG_tniu_req_valid           ;
	wire [89:0] sw_left3_TO_sw_left_dsp1_SIG_tniu_req_payload         ;
	wire [5:0]  sw_left3_TO_sw_left_dsp1_SIG_tniu_req_srcid           ;
	wire        sw_left3_TO_sw_left_dsp1_SIG_tniu_req_last            ;
	wire        sw_left3_TO_sw_left_dsp1_SIG_tniu_rsp_ready           ;
	wire        dsp1_iniu_TO_sw_left_dsp1_SIG_top_req_req_valid       ;
	wire [89:0] dsp1_iniu_TO_sw_left_dsp1_SIG_top_req_req_payload     ;
	wire [5:0]  dsp1_iniu_TO_sw_left_dsp1_SIG_top_req_req_srcid       ;
	wire        dsp1_iniu_TO_sw_left_dsp1_SIG_top_req_req_last        ;
	wire        dsp1_iniu_TO_sw_left_dsp1_SIG_top_rsp_rsp_ready       ;
	wire        sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_req_ready      ;
	wire        sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_valid      ;
	wire [89:0] sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_payload    ;
	wire [5:0]  sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_srcid      ;
	wire        sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_last       ;
	wire        sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_valid       ;
	wire [89:0] sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_payload     ;
	wire [5:0]  sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_srcid       ;
	wire        sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_last        ;
	wire        sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_rsp_ready       ;
	wire        dsp0_iniu_TO_sw_left_dsp0_SIG_top_req_req_valid       ;
	wire [89:0] dsp0_iniu_TO_sw_left_dsp0_SIG_top_req_req_payload     ;
	wire [5:0]  dsp0_iniu_TO_sw_left_dsp0_SIG_top_req_req_srcid       ;
	wire        dsp0_iniu_TO_sw_left_dsp0_SIG_top_req_req_last        ;
	wire        dsp0_iniu_TO_sw_left_dsp0_SIG_top_rsp_rsp_ready       ;
	wire        sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_req_ready      ;
	wire        sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_valid      ;
	wire [89:0] sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_payload    ;
	wire [5:0]  sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_srcid      ;
	wire        sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_last       ;
	wire        sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_valid       ;
	wire [89:0] sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_payload     ;
	wire [5:0]  sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_srcid       ;
	wire        sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_last        ;
	wire        sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_rsp_ready       ;
	wire        noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_req_req_valid   ;
	wire [89:0] noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_req_req_payload ;
	wire [5:0]  noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_req_req_srcid   ;
	wire        noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_req_req_last    ;
	wire        noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_rsp_rsp_ready   ;
	wire        sw_root_TO_sw_left_noc1_SIG_iniu0_req_ready           ;
	wire        sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_valid           ;
	wire [89:0] sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_payload         ;
	wire [5:0]  sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_srcid           ;
	wire        sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_last            ;
	wire        usb_ufs_iniu_TO_sw_right4_SIG_top_req_req_valid       ;
	wire [89:0] usb_ufs_iniu_TO_sw_right4_SIG_top_req_req_payload     ;
	wire [5:0]  usb_ufs_iniu_TO_sw_right4_SIG_top_req_req_srcid       ;
	wire        usb_ufs_iniu_TO_sw_right4_SIG_top_req_req_last        ;
	wire        usb_ufs_iniu_TO_sw_right4_SIG_top_rsp_rsp_ready       ;
	wire        mipi0_iniu_TO_sw_right4_SIG_top_req_req_valid         ;
	wire [89:0] mipi0_iniu_TO_sw_right4_SIG_top_req_req_payload       ;
	wire [5:0]  mipi0_iniu_TO_sw_right4_SIG_top_req_req_srcid         ;
	wire        mipi0_iniu_TO_sw_right4_SIG_top_req_req_last          ;
	wire        mipi0_iniu_TO_sw_right4_SIG_top_rsp_rsp_ready         ;
	wire        mipi1_iniu_TO_sw_right4_SIG_top_req_req_valid         ;
	wire [89:0] mipi1_iniu_TO_sw_right4_SIG_top_req_req_payload       ;
	wire [5:0]  mipi1_iniu_TO_sw_right4_SIG_top_req_req_srcid         ;
	wire        mipi1_iniu_TO_sw_right4_SIG_top_req_req_last          ;
	wire        mipi1_iniu_TO_sw_right4_SIG_top_rsp_rsp_ready         ;
	wire        camera_iniu_TO_sw_right4_SIG_top_req_req_valid        ;
	wire [89:0] camera_iniu_TO_sw_right4_SIG_top_req_req_payload      ;
	wire [5:0]  camera_iniu_TO_sw_right4_SIG_top_req_req_srcid        ;
	wire        camera_iniu_TO_sw_right4_SIG_top_req_req_last         ;
	wire        camera_iniu_TO_sw_right4_SIG_top_rsp_rsp_ready        ;
	wire        sw_right_noc0_TO_sw_right4_SIG_iniu0_req_ready        ;
	wire        sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_valid        ;
	wire [89:0] sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_payload      ;
	wire [5:0]  sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_srcid        ;
	wire        sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_last         ;
	wire        sw_right4_TO_sw_right_noc0_SIG_tniu_req_valid         ;
	wire [89:0] sw_right4_TO_sw_right_noc0_SIG_tniu_req_payload       ;
	wire [5:0]  sw_right4_TO_sw_right_noc0_SIG_tniu_req_srcid         ;
	wire        sw_right4_TO_sw_right_noc0_SIG_tniu_req_last          ;
	wire        sw_right4_TO_sw_right_noc0_SIG_tniu_rsp_ready         ;
	wire        noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_req_req_valid  ;
	wire [89:0] noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_req_req_payload;
	wire [5:0]  noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_req_req_srcid  ;
	wire        noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_req_req_last   ;
	wire        noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_rsp_rsp_ready  ;
	wire        sw_root_TO_sw_right_noc0_SIG_iniu1_req_ready          ;
	wire        sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_valid          ;
	wire [89:0] sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_payload        ;
	wire [5:0]  sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_srcid          ;
	wire        sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_last           ;
	wire        sw_left_noc1_TO_sw_root_SIG_tniu_req_valid            ;
	wire [89:0] sw_left_noc1_TO_sw_root_SIG_tniu_req_payload          ;
	wire [5:0]  sw_left_noc1_TO_sw_root_SIG_tniu_req_srcid            ;
	wire        sw_left_noc1_TO_sw_root_SIG_tniu_req_last             ;
	wire        sw_left_noc1_TO_sw_root_SIG_tniu_rsp_ready            ;
	wire        sw_right_noc0_TO_sw_root_SIG_tniu_req_valid           ;
	wire [89:0] sw_right_noc0_TO_sw_root_SIG_tniu_req_payload         ;
	wire [5:0]  sw_right_noc0_TO_sw_root_SIG_tniu_req_srcid           ;
	wire        sw_right_noc0_TO_sw_root_SIG_tniu_req_last            ;
	wire        sw_right_noc0_TO_sw_root_SIG_tniu_rsp_ready           ;
	wire        tcu_tniu_TO_sw_root_SIG_top_req_req_ready             ;
	wire        tcu_tniu_TO_sw_root_SIG_top_rsp_rsp_valid             ;
	wire [89:0] tcu_tniu_TO_sw_root_SIG_top_rsp_rsp_payload           ;
	wire [5:0]  tcu_tniu_TO_sw_root_SIG_top_rsp_rsp_srcid             ;
	wire        tcu_tniu_TO_sw_root_SIG_top_rsp_rsp_last              ;
	wire        sw_left3_TO_pcie_eth_iniu_SIG_iniu0_req_ready         ;
	wire        sw_left3_TO_pcie_eth_iniu_SIG_iniu0_rsp_last          ;
	wire [89:0] sw_left3_TO_pcie_eth_iniu_SIG_iniu0_rsp_payload       ;
	wire [5:0]  sw_left3_TO_pcie_eth_iniu_SIG_iniu0_rsp_srcid         ;
	wire        sw_left3_TO_pcie_eth_iniu_SIG_iniu0_rsp_valid         ;
	wire        sw_left3_TO_vpu_iniu_SIG_iniu1_req_ready              ;
	wire        sw_left3_TO_vpu_iniu_SIG_iniu1_rsp_last               ;
	wire [89:0] sw_left3_TO_vpu_iniu_SIG_iniu1_rsp_payload            ;
	wire [5:0]  sw_left3_TO_vpu_iniu_SIG_iniu1_rsp_srcid              ;
	wire        sw_left3_TO_vpu_iniu_SIG_iniu1_rsp_valid              ;
	wire        sw_left3_TO_dsp2_iniu_SIG_iniu2_req_ready             ;
	wire        sw_left3_TO_dsp2_iniu_SIG_iniu2_rsp_last              ;
	wire [89:0] sw_left3_TO_dsp2_iniu_SIG_iniu2_rsp_payload           ;
	wire [5:0]  sw_left3_TO_dsp2_iniu_SIG_iniu2_rsp_srcid             ;
	wire        sw_left3_TO_dsp2_iniu_SIG_iniu2_rsp_valid             ;
	wire        sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_req_ready         ;
	wire        sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_rsp_last          ;
	wire [89:0] sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_rsp_payload       ;
	wire [5:0]  sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_rsp_srcid         ;
	wire        sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_rsp_valid         ;
	wire        sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_req_ready         ;
	wire        sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_rsp_last          ;
	wire [89:0] sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_rsp_payload       ;
	wire [5:0]  sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_rsp_srcid         ;
	wire        sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_rsp_valid         ;
	wire        sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_req_ready     ;
	wire        sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_rsp_last      ;
	wire [89:0] sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_rsp_payload   ;
	wire [5:0]  sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_rsp_srcid     ;
	wire        sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_rsp_valid     ;
	wire        sw_right4_TO_usb_ufs_iniu_SIG_iniu0_req_ready         ;
	wire        sw_right4_TO_usb_ufs_iniu_SIG_iniu0_rsp_last          ;
	wire [89:0] sw_right4_TO_usb_ufs_iniu_SIG_iniu0_rsp_payload       ;
	wire [5:0]  sw_right4_TO_usb_ufs_iniu_SIG_iniu0_rsp_srcid         ;
	wire        sw_right4_TO_usb_ufs_iniu_SIG_iniu0_rsp_valid         ;
	wire        sw_right4_TO_mipi0_iniu_SIG_iniu1_req_ready           ;
	wire        sw_right4_TO_mipi0_iniu_SIG_iniu1_rsp_last            ;
	wire [89:0] sw_right4_TO_mipi0_iniu_SIG_iniu1_rsp_payload         ;
	wire [5:0]  sw_right4_TO_mipi0_iniu_SIG_iniu1_rsp_srcid           ;
	wire        sw_right4_TO_mipi0_iniu_SIG_iniu1_rsp_valid           ;
	wire        sw_right4_TO_mipi1_iniu_SIG_iniu2_req_ready           ;
	wire        sw_right4_TO_mipi1_iniu_SIG_iniu2_rsp_last            ;
	wire [89:0] sw_right4_TO_mipi1_iniu_SIG_iniu2_rsp_payload         ;
	wire [5:0]  sw_right4_TO_mipi1_iniu_SIG_iniu2_rsp_srcid           ;
	wire        sw_right4_TO_mipi1_iniu_SIG_iniu2_rsp_valid           ;
	wire        sw_right4_TO_camera_iniu_SIG_iniu3_req_ready          ;
	wire        sw_right4_TO_camera_iniu_SIG_iniu3_rsp_last           ;
	wire [89:0] sw_right4_TO_camera_iniu_SIG_iniu3_rsp_payload        ;
	wire [5:0]  sw_right4_TO_camera_iniu_SIG_iniu3_rsp_srcid          ;
	wire        sw_right4_TO_camera_iniu_SIG_iniu3_rsp_valid          ;
	wire        sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_req_ready    ;
	wire        sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_rsp_last     ;
	wire [89:0] sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_rsp_payload  ;
	wire [5:0]  sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_rsp_srcid    ;
	wire        sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_rsp_valid    ;
	wire        sw_root_TO_tcu_tniu_SIG_tniu_req_last                 ;
	wire [89:0] sw_root_TO_tcu_tniu_SIG_tniu_req_payload              ;
	wire [5:0]  sw_root_TO_tcu_tniu_SIG_tniu_req_srcid                ;
	wire        sw_root_TO_tcu_tniu_SIG_tniu_req_valid                ;
	wire        sw_root_TO_tcu_tniu_SIG_tniu_rsp_ready                ;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.

	//Wire this module connect to sub module.

	//module inst.
	dti_sw_left3_dti_switch_3i1o_wrap #(
		.DTI_INIU0_MIN(32'd0),
		.DTI_INIU0_MAX(32'd0),
		.DTI_INIU1_MIN(32'd1),
		.DTI_INIU1_MAX(32'd1),
		.DTI_INIU2_MIN(32'd2),
		.DTI_INIU2_MAX(32'd2),
		.DTI_TNIU_MIN(32'd0),
		.DTI_TNIU_MAX(32'd2))
	sw_left3 (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(pcie_eth_iniu_TO_sw_left3_SIG_top_req_req_valid),
		.iniu0_req_ready(sw_left3_TO_pcie_eth_iniu_SIG_iniu0_req_ready),
		.iniu0_req_payload(pcie_eth_iniu_TO_sw_left3_SIG_top_req_req_payload),
		.iniu0_req_srcid(pcie_eth_iniu_TO_sw_left3_SIG_top_req_req_srcid),
		.iniu0_req_last(pcie_eth_iniu_TO_sw_left3_SIG_top_req_req_last),
		.iniu0_rsp_valid(sw_left3_TO_pcie_eth_iniu_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(pcie_eth_iniu_TO_sw_left3_SIG_top_rsp_rsp_ready),
		.iniu0_rsp_payload(sw_left3_TO_pcie_eth_iniu_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_left3_TO_pcie_eth_iniu_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_last(sw_left3_TO_pcie_eth_iniu_SIG_iniu0_rsp_last),
		.iniu1_req_valid(vpu_iniu_TO_sw_left3_SIG_top_req_req_valid),
		.iniu1_req_ready(sw_left3_TO_vpu_iniu_SIG_iniu1_req_ready),
		.iniu1_req_payload(vpu_iniu_TO_sw_left3_SIG_top_req_req_payload),
		.iniu1_req_srcid(vpu_iniu_TO_sw_left3_SIG_top_req_req_srcid),
		.iniu1_req_last(vpu_iniu_TO_sw_left3_SIG_top_req_req_last),
		.iniu1_rsp_valid(sw_left3_TO_vpu_iniu_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(vpu_iniu_TO_sw_left3_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_payload(sw_left3_TO_vpu_iniu_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_left3_TO_vpu_iniu_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_last(sw_left3_TO_vpu_iniu_SIG_iniu1_rsp_last),
		.iniu2_req_valid(dsp2_iniu_TO_sw_left3_SIG_top_req_req_valid),
		.iniu2_req_ready(sw_left3_TO_dsp2_iniu_SIG_iniu2_req_ready),
		.iniu2_req_payload(dsp2_iniu_TO_sw_left3_SIG_top_req_req_payload),
		.iniu2_req_srcid(dsp2_iniu_TO_sw_left3_SIG_top_req_req_srcid),
		.iniu2_req_last(dsp2_iniu_TO_sw_left3_SIG_top_req_req_last),
		.iniu2_rsp_valid(sw_left3_TO_dsp2_iniu_SIG_iniu2_rsp_valid),
		.iniu2_rsp_ready(dsp2_iniu_TO_sw_left3_SIG_top_rsp_rsp_ready),
		.iniu2_rsp_payload(sw_left3_TO_dsp2_iniu_SIG_iniu2_rsp_payload),
		.iniu2_rsp_srcid(sw_left3_TO_dsp2_iniu_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_last(sw_left3_TO_dsp2_iniu_SIG_iniu2_rsp_last),
		.tniu_req_valid(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_valid),
		.tniu_req_ready(sw_left_dsp1_TO_sw_left3_SIG_iniu0_req_ready),
		.tniu_req_payload(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_srcid),
		.tniu_req_last(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_last),
		.tniu_rsp_valid(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw_left3_TO_sw_left_dsp1_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_srcid),
		.tniu_rsp_last(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_last));
	dti_sw_left_dsp1_dti_switch_2i1o_wrap #(
		.DTI_INIU0_MIN(32'd0),
		.DTI_INIU0_MAX(32'd2),
		.DTI_INIU1_MIN(32'd3),
		.DTI_INIU1_MAX(32'd3),
		.DTI_TNIU_MIN(32'd0),
		.DTI_TNIU_MAX(32'd3))
	sw_left_dsp1 (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_valid),
		.iniu0_req_ready(sw_left_dsp1_TO_sw_left3_SIG_iniu0_req_ready),
		.iniu0_req_payload(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_payload),
		.iniu0_req_srcid(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_srcid),
		.iniu0_req_last(sw_left3_TO_sw_left_dsp1_SIG_tniu_req_last),
		.iniu0_rsp_valid(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(sw_left3_TO_sw_left_dsp1_SIG_tniu_rsp_ready),
		.iniu0_rsp_payload(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_last(sw_left_dsp1_TO_sw_left3_SIG_iniu0_rsp_last),
		.iniu1_req_valid(dsp1_iniu_TO_sw_left_dsp1_SIG_top_req_req_valid),
		.iniu1_req_ready(sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_req_ready),
		.iniu1_req_payload(dsp1_iniu_TO_sw_left_dsp1_SIG_top_req_req_payload),
		.iniu1_req_srcid(dsp1_iniu_TO_sw_left_dsp1_SIG_top_req_req_srcid),
		.iniu1_req_last(dsp1_iniu_TO_sw_left_dsp1_SIG_top_req_req_last),
		.iniu1_rsp_valid(sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(dsp1_iniu_TO_sw_left_dsp1_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_payload(sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_last(sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_rsp_last),
		.tniu_req_valid(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_valid),
		.tniu_req_ready(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_req_ready),
		.tniu_req_payload(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_srcid),
		.tniu_req_last(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_last),
		.tniu_rsp_valid(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_srcid),
		.tniu_rsp_last(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_last));
	dti_sw_left_dsp0_dti_switch_2i1o_wrap #(
		.DTI_INIU0_MIN(32'd0),
		.DTI_INIU0_MAX(32'd3),
		.DTI_INIU1_MIN(32'd4),
		.DTI_INIU1_MAX(32'd4),
		.DTI_TNIU_MIN(32'd0),
		.DTI_TNIU_MAX(32'd4))
	sw_left_dsp0 (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_valid),
		.iniu0_req_ready(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_req_ready),
		.iniu0_req_payload(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_payload),
		.iniu0_req_srcid(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_srcid),
		.iniu0_req_last(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_req_last),
		.iniu0_rsp_valid(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(sw_left_dsp1_TO_sw_left_dsp0_SIG_tniu_rsp_ready),
		.iniu0_rsp_payload(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_last(sw_left_dsp0_TO_sw_left_dsp1_SIG_iniu0_rsp_last),
		.iniu1_req_valid(dsp0_iniu_TO_sw_left_dsp0_SIG_top_req_req_valid),
		.iniu1_req_ready(sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_req_ready),
		.iniu1_req_payload(dsp0_iniu_TO_sw_left_dsp0_SIG_top_req_req_payload),
		.iniu1_req_srcid(dsp0_iniu_TO_sw_left_dsp0_SIG_top_req_req_srcid),
		.iniu1_req_last(dsp0_iniu_TO_sw_left_dsp0_SIG_top_req_req_last),
		.iniu1_rsp_valid(sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(dsp0_iniu_TO_sw_left_dsp0_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_payload(sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_last(sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_rsp_last),
		.tniu_req_valid(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_valid),
		.tniu_req_ready(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_req_ready),
		.tniu_req_payload(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_srcid),
		.tniu_req_last(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_last),
		.tniu_rsp_valid(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_srcid),
		.tniu_rsp_last(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_last));
	dti_sw_left_noc1_dti_switch_2i1o_wrap #(
		.DTI_INIU0_MIN(32'd0),
		.DTI_INIU0_MAX(32'd4),
		.DTI_INIU1_MIN(32'd5),
		.DTI_INIU1_MAX(32'd5),
		.DTI_TNIU_MIN(32'd0),
		.DTI_TNIU_MAX(32'd5))
	sw_left_noc1 (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_valid),
		.iniu0_req_ready(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_req_ready),
		.iniu0_req_payload(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_payload),
		.iniu0_req_srcid(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_srcid),
		.iniu0_req_last(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_req_last),
		.iniu0_rsp_valid(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(sw_left_dsp0_TO_sw_left_noc1_SIG_tniu_rsp_ready),
		.iniu0_rsp_payload(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_last(sw_left_noc1_TO_sw_left_dsp0_SIG_iniu0_rsp_last),
		.iniu1_req_valid(noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_req_req_valid),
		.iniu1_req_ready(sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_req_ready),
		.iniu1_req_payload(noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_req_req_payload),
		.iniu1_req_srcid(noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_req_req_srcid),
		.iniu1_req_last(noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_req_req_last),
		.iniu1_rsp_valid(sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_payload(sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_last(sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_rsp_last),
		.tniu_req_valid(sw_left_noc1_TO_sw_root_SIG_tniu_req_valid),
		.tniu_req_ready(sw_root_TO_sw_left_noc1_SIG_iniu0_req_ready),
		.tniu_req_payload(sw_left_noc1_TO_sw_root_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_left_noc1_TO_sw_root_SIG_tniu_req_srcid),
		.tniu_req_last(sw_left_noc1_TO_sw_root_SIG_tniu_req_last),
		.tniu_rsp_valid(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw_left_noc1_TO_sw_root_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_srcid),
		.tniu_rsp_last(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_last));
	dti_sw_right4_dti_switch_4i1o_wrap #(
		.DTI_INIU0_MIN(32'd6),
		.DTI_INIU0_MAX(32'd6),
		.DTI_INIU1_MIN(32'd7),
		.DTI_INIU1_MAX(32'd7),
		.DTI_INIU2_MIN(32'd8),
		.DTI_INIU2_MAX(32'd8),
		.DTI_INIU3_MIN(32'd9),
		.DTI_INIU3_MAX(32'd9),
		.DTI_TNIU_MIN(32'd6),
		.DTI_TNIU_MAX(32'd9))
	sw_right4 (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(usb_ufs_iniu_TO_sw_right4_SIG_top_req_req_valid),
		.iniu0_req_ready(sw_right4_TO_usb_ufs_iniu_SIG_iniu0_req_ready),
		.iniu0_req_payload(usb_ufs_iniu_TO_sw_right4_SIG_top_req_req_payload),
		.iniu0_req_srcid(usb_ufs_iniu_TO_sw_right4_SIG_top_req_req_srcid),
		.iniu0_req_last(usb_ufs_iniu_TO_sw_right4_SIG_top_req_req_last),
		.iniu0_rsp_valid(sw_right4_TO_usb_ufs_iniu_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(usb_ufs_iniu_TO_sw_right4_SIG_top_rsp_rsp_ready),
		.iniu0_rsp_payload(sw_right4_TO_usb_ufs_iniu_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_right4_TO_usb_ufs_iniu_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_last(sw_right4_TO_usb_ufs_iniu_SIG_iniu0_rsp_last),
		.iniu1_req_valid(mipi0_iniu_TO_sw_right4_SIG_top_req_req_valid),
		.iniu1_req_ready(sw_right4_TO_mipi0_iniu_SIG_iniu1_req_ready),
		.iniu1_req_payload(mipi0_iniu_TO_sw_right4_SIG_top_req_req_payload),
		.iniu1_req_srcid(mipi0_iniu_TO_sw_right4_SIG_top_req_req_srcid),
		.iniu1_req_last(mipi0_iniu_TO_sw_right4_SIG_top_req_req_last),
		.iniu1_rsp_valid(sw_right4_TO_mipi0_iniu_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(mipi0_iniu_TO_sw_right4_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_payload(sw_right4_TO_mipi0_iniu_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_right4_TO_mipi0_iniu_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_last(sw_right4_TO_mipi0_iniu_SIG_iniu1_rsp_last),
		.iniu2_req_valid(mipi1_iniu_TO_sw_right4_SIG_top_req_req_valid),
		.iniu2_req_ready(sw_right4_TO_mipi1_iniu_SIG_iniu2_req_ready),
		.iniu2_req_payload(mipi1_iniu_TO_sw_right4_SIG_top_req_req_payload),
		.iniu2_req_srcid(mipi1_iniu_TO_sw_right4_SIG_top_req_req_srcid),
		.iniu2_req_last(mipi1_iniu_TO_sw_right4_SIG_top_req_req_last),
		.iniu2_rsp_valid(sw_right4_TO_mipi1_iniu_SIG_iniu2_rsp_valid),
		.iniu2_rsp_ready(mipi1_iniu_TO_sw_right4_SIG_top_rsp_rsp_ready),
		.iniu2_rsp_payload(sw_right4_TO_mipi1_iniu_SIG_iniu2_rsp_payload),
		.iniu2_rsp_srcid(sw_right4_TO_mipi1_iniu_SIG_iniu2_rsp_srcid),
		.iniu2_rsp_last(sw_right4_TO_mipi1_iniu_SIG_iniu2_rsp_last),
		.iniu3_req_valid(camera_iniu_TO_sw_right4_SIG_top_req_req_valid),
		.iniu3_req_ready(sw_right4_TO_camera_iniu_SIG_iniu3_req_ready),
		.iniu3_req_payload(camera_iniu_TO_sw_right4_SIG_top_req_req_payload),
		.iniu3_req_srcid(camera_iniu_TO_sw_right4_SIG_top_req_req_srcid),
		.iniu3_req_last(camera_iniu_TO_sw_right4_SIG_top_req_req_last),
		.iniu3_rsp_valid(sw_right4_TO_camera_iniu_SIG_iniu3_rsp_valid),
		.iniu3_rsp_ready(camera_iniu_TO_sw_right4_SIG_top_rsp_rsp_ready),
		.iniu3_rsp_payload(sw_right4_TO_camera_iniu_SIG_iniu3_rsp_payload),
		.iniu3_rsp_srcid(sw_right4_TO_camera_iniu_SIG_iniu3_rsp_srcid),
		.iniu3_rsp_last(sw_right4_TO_camera_iniu_SIG_iniu3_rsp_last),
		.tniu_req_valid(sw_right4_TO_sw_right_noc0_SIG_tniu_req_valid),
		.tniu_req_ready(sw_right_noc0_TO_sw_right4_SIG_iniu0_req_ready),
		.tniu_req_payload(sw_right4_TO_sw_right_noc0_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_right4_TO_sw_right_noc0_SIG_tniu_req_srcid),
		.tniu_req_last(sw_right4_TO_sw_right_noc0_SIG_tniu_req_last),
		.tniu_rsp_valid(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_valid),
		.tniu_rsp_ready(sw_right4_TO_sw_right_noc0_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_payload),
		.tniu_rsp_srcid(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_srcid),
		.tniu_rsp_last(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_last));
	dti_sw_right_noc0_dti_switch_2i1o_wrap #(
		.DTI_INIU0_MIN(32'd6),
		.DTI_INIU0_MAX(32'd9),
		.DTI_INIU1_MIN(32'd10),
		.DTI_INIU1_MAX(32'd10),
		.DTI_TNIU_MIN(32'd6),
		.DTI_TNIU_MAX(32'd10))
	sw_right_noc0 (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(sw_right4_TO_sw_right_noc0_SIG_tniu_req_valid),
		.iniu0_req_ready(sw_right_noc0_TO_sw_right4_SIG_iniu0_req_ready),
		.iniu0_req_payload(sw_right4_TO_sw_right_noc0_SIG_tniu_req_payload),
		.iniu0_req_srcid(sw_right4_TO_sw_right_noc0_SIG_tniu_req_srcid),
		.iniu0_req_last(sw_right4_TO_sw_right_noc0_SIG_tniu_req_last),
		.iniu0_rsp_valid(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(sw_right4_TO_sw_right_noc0_SIG_tniu_rsp_ready),
		.iniu0_rsp_payload(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_last(sw_right_noc0_TO_sw_right4_SIG_iniu0_rsp_last),
		.iniu1_req_valid(noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_req_req_valid),
		.iniu1_req_ready(sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_req_ready),
		.iniu1_req_payload(noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_req_req_payload),
		.iniu1_req_srcid(noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_req_req_srcid),
		.iniu1_req_last(noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_req_req_last),
		.iniu1_rsp_valid(sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_rsp_rsp_ready),
		.iniu1_rsp_payload(sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_last(sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_rsp_last),
		.tniu_req_valid(sw_right_noc0_TO_sw_root_SIG_tniu_req_valid),
		.tniu_req_ready(sw_root_TO_sw_right_noc0_SIG_iniu1_req_ready),
		.tniu_req_payload(sw_right_noc0_TO_sw_root_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_right_noc0_TO_sw_root_SIG_tniu_req_srcid),
		.tniu_req_last(sw_right_noc0_TO_sw_root_SIG_tniu_req_last),
		.tniu_rsp_valid(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_valid),
		.tniu_rsp_ready(sw_right_noc0_TO_sw_root_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_payload),
		.tniu_rsp_srcid(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_srcid),
		.tniu_rsp_last(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_last));
	dti_sw_root_dti_switch_2i1o_wrap #(
		.DTI_INIU0_MIN(32'd0),
		.DTI_INIU0_MAX(32'd5),
		.DTI_INIU1_MIN(32'd6),
		.DTI_INIU1_MAX(32'd10),
		.DTI_TNIU_MIN(32'd0),
		.DTI_TNIU_MAX(32'd43))
	sw_root (
		.clk(clk_noc),
		.rst_n(rst_noc_n),
		.iniu0_req_valid(sw_left_noc1_TO_sw_root_SIG_tniu_req_valid),
		.iniu0_req_ready(sw_root_TO_sw_left_noc1_SIG_iniu0_req_ready),
		.iniu0_req_payload(sw_left_noc1_TO_sw_root_SIG_tniu_req_payload),
		.iniu0_req_srcid(sw_left_noc1_TO_sw_root_SIG_tniu_req_srcid),
		.iniu0_req_last(sw_left_noc1_TO_sw_root_SIG_tniu_req_last),
		.iniu0_rsp_valid(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_valid),
		.iniu0_rsp_ready(sw_left_noc1_TO_sw_root_SIG_tniu_rsp_ready),
		.iniu0_rsp_payload(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_payload),
		.iniu0_rsp_srcid(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_srcid),
		.iniu0_rsp_last(sw_root_TO_sw_left_noc1_SIG_iniu0_rsp_last),
		.iniu1_req_valid(sw_right_noc0_TO_sw_root_SIG_tniu_req_valid),
		.iniu1_req_ready(sw_root_TO_sw_right_noc0_SIG_iniu1_req_ready),
		.iniu1_req_payload(sw_right_noc0_TO_sw_root_SIG_tniu_req_payload),
		.iniu1_req_srcid(sw_right_noc0_TO_sw_root_SIG_tniu_req_srcid),
		.iniu1_req_last(sw_right_noc0_TO_sw_root_SIG_tniu_req_last),
		.iniu1_rsp_valid(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_valid),
		.iniu1_rsp_ready(sw_right_noc0_TO_sw_root_SIG_tniu_rsp_ready),
		.iniu1_rsp_payload(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_payload),
		.iniu1_rsp_srcid(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_srcid),
		.iniu1_rsp_last(sw_root_TO_sw_right_noc0_SIG_iniu1_rsp_last),
		.tniu_req_valid(sw_root_TO_tcu_tniu_SIG_tniu_req_valid),
		.tniu_req_ready(tcu_tniu_TO_sw_root_SIG_top_req_req_ready),
		.tniu_req_payload(sw_root_TO_tcu_tniu_SIG_tniu_req_payload),
		.tniu_req_srcid(sw_root_TO_tcu_tniu_SIG_tniu_req_srcid),
		.tniu_req_last(sw_root_TO_tcu_tniu_SIG_tniu_req_last),
		.tniu_rsp_valid(tcu_tniu_TO_sw_root_SIG_top_rsp_rsp_valid),
		.tniu_rsp_ready(sw_root_TO_tcu_tniu_SIG_tniu_rsp_ready),
		.tniu_rsp_payload(tcu_tniu_TO_sw_root_SIG_top_rsp_rsp_payload),
		.tniu_rsp_srcid(tcu_tniu_TO_sw_root_SIG_top_rsp_rsp_srcid),
		.tniu_rsp_last(tcu_tniu_TO_sw_root_SIG_top_rsp_rsp_last));
	pcie_eth_iniu_node pcie_eth_iniu (
		.clk_sys_clk(pcie_eth_iniu_node_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(pcie_eth_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_req_tdata(pcie_eth_iniu_node_dti_req_porting_dti_req_req_tdata),
		.dti_req_req_tkeep(pcie_eth_iniu_node_dti_req_porting_dti_req_req_tkeep),
		.dti_req_req_tlast(pcie_eth_iniu_node_dti_req_porting_dti_req_req_tlast),
		.dti_req_req_tready(pcie_eth_iniu_node_dti_req_porting_dti_req_req_tready),
		.dti_req_req_ttid(pcie_eth_iniu_node_dti_req_porting_dti_req_req_ttid),
		.dti_req_req_tvalid(pcie_eth_iniu_node_dti_req_porting_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(pcie_eth_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(pcie_eth_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(pcie_eth_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(pcie_eth_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(pcie_eth_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(pcie_eth_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid),
		.timeout_val_timeout_val(pcie_eth_iniu_node_timeout_val_porting_timeout_val_timeout_val),
		.pchnl_ctrl_paccept(pcie_eth_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(pcie_eth_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(pcie_eth_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(pcie_eth_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(pcie_eth_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate),
		.top_req_req_last(pcie_eth_iniu_TO_sw_left3_SIG_top_req_req_last),
		.top_req_req_payload(pcie_eth_iniu_TO_sw_left3_SIG_top_req_req_payload),
		.top_req_req_ready(sw_left3_TO_pcie_eth_iniu_SIG_iniu0_req_ready),
		.top_req_req_srcid(pcie_eth_iniu_TO_sw_left3_SIG_top_req_req_srcid),
		.top_req_req_valid(pcie_eth_iniu_TO_sw_left3_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_left3_TO_pcie_eth_iniu_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(sw_left3_TO_pcie_eth_iniu_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_ready(pcie_eth_iniu_TO_sw_left3_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_left3_TO_pcie_eth_iniu_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_valid(sw_left3_TO_pcie_eth_iniu_SIG_iniu0_rsp_valid));
	vpu_iniu_node vpu_iniu (
		.clk_sys_clk(vpu_iniu_node_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(vpu_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_req_tdata(vpu_iniu_node_dti_req_porting_dti_req_req_tdata),
		.dti_req_req_tkeep(vpu_iniu_node_dti_req_porting_dti_req_req_tkeep),
		.dti_req_req_tlast(vpu_iniu_node_dti_req_porting_dti_req_req_tlast),
		.dti_req_req_tready(vpu_iniu_node_dti_req_porting_dti_req_req_tready),
		.dti_req_req_ttid(vpu_iniu_node_dti_req_porting_dti_req_req_ttid),
		.dti_req_req_tvalid(vpu_iniu_node_dti_req_porting_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(vpu_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid),
		.timeout_val_timeout_val(vpu_iniu_node_timeout_val_porting_timeout_val_timeout_val),
		.pchnl_ctrl_paccept(vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(vpu_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate),
		.top_req_req_last(vpu_iniu_TO_sw_left3_SIG_top_req_req_last),
		.top_req_req_payload(vpu_iniu_TO_sw_left3_SIG_top_req_req_payload),
		.top_req_req_ready(sw_left3_TO_vpu_iniu_SIG_iniu1_req_ready),
		.top_req_req_srcid(vpu_iniu_TO_sw_left3_SIG_top_req_req_srcid),
		.top_req_req_valid(vpu_iniu_TO_sw_left3_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_left3_TO_vpu_iniu_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(sw_left3_TO_vpu_iniu_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_ready(vpu_iniu_TO_sw_left3_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_left3_TO_vpu_iniu_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_valid(sw_left3_TO_vpu_iniu_SIG_iniu1_rsp_valid));
	dsp2_iniu_node dsp2_iniu (
		.clk_sys_clk(dsp2_iniu_node_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(dsp2_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_req_tdata(dsp2_iniu_node_dti_req_porting_dti_req_req_tdata),
		.dti_req_req_tkeep(dsp2_iniu_node_dti_req_porting_dti_req_req_tkeep),
		.dti_req_req_tlast(dsp2_iniu_node_dti_req_porting_dti_req_req_tlast),
		.dti_req_req_tready(dsp2_iniu_node_dti_req_porting_dti_req_req_tready),
		.dti_req_req_ttid(dsp2_iniu_node_dti_req_porting_dti_req_req_ttid),
		.dti_req_req_tvalid(dsp2_iniu_node_dti_req_porting_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(dsp2_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(dsp2_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(dsp2_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(dsp2_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(dsp2_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(dsp2_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid),
		.timeout_val_timeout_val(dsp2_iniu_node_timeout_val_porting_timeout_val_timeout_val),
		.pchnl_ctrl_paccept(dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(dsp2_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate),
		.top_req_req_last(dsp2_iniu_TO_sw_left3_SIG_top_req_req_last),
		.top_req_req_payload(dsp2_iniu_TO_sw_left3_SIG_top_req_req_payload),
		.top_req_req_ready(sw_left3_TO_dsp2_iniu_SIG_iniu2_req_ready),
		.top_req_req_srcid(dsp2_iniu_TO_sw_left3_SIG_top_req_req_srcid),
		.top_req_req_valid(dsp2_iniu_TO_sw_left3_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_left3_TO_dsp2_iniu_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(sw_left3_TO_dsp2_iniu_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_ready(dsp2_iniu_TO_sw_left3_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_left3_TO_dsp2_iniu_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_valid(sw_left3_TO_dsp2_iniu_SIG_iniu2_rsp_valid));
	dsp1_iniu_node dsp1_iniu (
		.clk_sys_clk(dsp1_iniu_node_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(dsp1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_req_tdata(dsp1_iniu_node_dti_req_porting_dti_req_req_tdata),
		.dti_req_req_tkeep(dsp1_iniu_node_dti_req_porting_dti_req_req_tkeep),
		.dti_req_req_tlast(dsp1_iniu_node_dti_req_porting_dti_req_req_tlast),
		.dti_req_req_tready(dsp1_iniu_node_dti_req_porting_dti_req_req_tready),
		.dti_req_req_ttid(dsp1_iniu_node_dti_req_porting_dti_req_req_ttid),
		.dti_req_req_tvalid(dsp1_iniu_node_dti_req_porting_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(dsp1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(dsp1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(dsp1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(dsp1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(dsp1_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(dsp1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid),
		.timeout_val_timeout_val(dsp1_iniu_node_timeout_val_porting_timeout_val_timeout_val),
		.pchnl_ctrl_paccept(dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(dsp1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate),
		.top_req_req_last(dsp1_iniu_TO_sw_left_dsp1_SIG_top_req_req_last),
		.top_req_req_payload(dsp1_iniu_TO_sw_left_dsp1_SIG_top_req_req_payload),
		.top_req_req_ready(sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_req_ready),
		.top_req_req_srcid(dsp1_iniu_TO_sw_left_dsp1_SIG_top_req_req_srcid),
		.top_req_req_valid(dsp1_iniu_TO_sw_left_dsp1_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_ready(dsp1_iniu_TO_sw_left_dsp1_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_valid(sw_left_dsp1_TO_dsp1_iniu_SIG_iniu1_rsp_valid));
	dsp0_iniu_node dsp0_iniu (
		.clk_sys_clk(dsp0_iniu_node_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(dsp0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_req_tdata(dsp0_iniu_node_dti_req_porting_dti_req_req_tdata),
		.dti_req_req_tkeep(dsp0_iniu_node_dti_req_porting_dti_req_req_tkeep),
		.dti_req_req_tlast(dsp0_iniu_node_dti_req_porting_dti_req_req_tlast),
		.dti_req_req_tready(dsp0_iniu_node_dti_req_porting_dti_req_req_tready),
		.dti_req_req_ttid(dsp0_iniu_node_dti_req_porting_dti_req_req_ttid),
		.dti_req_req_tvalid(dsp0_iniu_node_dti_req_porting_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(dsp0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(dsp0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(dsp0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(dsp0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(dsp0_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(dsp0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid),
		.timeout_val_timeout_val(dsp0_iniu_node_timeout_val_porting_timeout_val_timeout_val),
		.pchnl_ctrl_paccept(dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(dsp0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate),
		.top_req_req_last(dsp0_iniu_TO_sw_left_dsp0_SIG_top_req_req_last),
		.top_req_req_payload(dsp0_iniu_TO_sw_left_dsp0_SIG_top_req_req_payload),
		.top_req_req_ready(sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_req_ready),
		.top_req_req_srcid(dsp0_iniu_TO_sw_left_dsp0_SIG_top_req_req_srcid),
		.top_req_req_valid(dsp0_iniu_TO_sw_left_dsp0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_ready(dsp0_iniu_TO_sw_left_dsp0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_valid(sw_left_dsp0_TO_dsp0_iniu_SIG_iniu1_rsp_valid));
	noc_tbu1_iniu_node noc_tbu1_iniu (
		.clk_sys_clk(noc_tbu1_iniu_node_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(noc_tbu1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_req_tdata(noc_tbu1_iniu_node_dti_req_porting_dti_req_req_tdata),
		.dti_req_req_tkeep(noc_tbu1_iniu_node_dti_req_porting_dti_req_req_tkeep),
		.dti_req_req_tlast(noc_tbu1_iniu_node_dti_req_porting_dti_req_req_tlast),
		.dti_req_req_tready(noc_tbu1_iniu_node_dti_req_porting_dti_req_req_tready),
		.dti_req_req_ttid(noc_tbu1_iniu_node_dti_req_porting_dti_req_req_ttid),
		.dti_req_req_tvalid(noc_tbu1_iniu_node_dti_req_porting_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(noc_tbu1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(noc_tbu1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(noc_tbu1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(noc_tbu1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(noc_tbu1_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(noc_tbu1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid),
		.timeout_val_timeout_val(noc_tbu1_iniu_node_timeout_val_porting_timeout_val_timeout_val),
		.pchnl_ctrl_paccept(noc_tbu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(noc_tbu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(noc_tbu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(noc_tbu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(noc_tbu1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate),
		.top_req_req_last(noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_req_req_last),
		.top_req_req_payload(noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_req_req_payload),
		.top_req_req_ready(sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_req_ready),
		.top_req_req_srcid(noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_req_req_srcid),
		.top_req_req_valid(noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_ready(noc_tbu1_iniu_TO_sw_left_noc1_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_valid(sw_left_noc1_TO_noc_tbu1_iniu_SIG_iniu1_rsp_valid));
	usb_ufs_iniu_node usb_ufs_iniu (
		.clk_sys_clk(usb_ufs_iniu_node_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(usb_ufs_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_req_tdata(usb_ufs_iniu_node_dti_req_porting_dti_req_req_tdata),
		.dti_req_req_tkeep(usb_ufs_iniu_node_dti_req_porting_dti_req_req_tkeep),
		.dti_req_req_tlast(usb_ufs_iniu_node_dti_req_porting_dti_req_req_tlast),
		.dti_req_req_tready(usb_ufs_iniu_node_dti_req_porting_dti_req_req_tready),
		.dti_req_req_ttid(usb_ufs_iniu_node_dti_req_porting_dti_req_req_ttid),
		.dti_req_req_tvalid(usb_ufs_iniu_node_dti_req_porting_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(usb_ufs_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(usb_ufs_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(usb_ufs_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(usb_ufs_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(usb_ufs_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(usb_ufs_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid),
		.timeout_val_timeout_val(usb_ufs_iniu_node_timeout_val_porting_timeout_val_timeout_val),
		.pchnl_ctrl_paccept(usb_ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(usb_ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(usb_ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(usb_ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(usb_ufs_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate),
		.top_req_req_last(usb_ufs_iniu_TO_sw_right4_SIG_top_req_req_last),
		.top_req_req_payload(usb_ufs_iniu_TO_sw_right4_SIG_top_req_req_payload),
		.top_req_req_ready(sw_right4_TO_usb_ufs_iniu_SIG_iniu0_req_ready),
		.top_req_req_srcid(usb_ufs_iniu_TO_sw_right4_SIG_top_req_req_srcid),
		.top_req_req_valid(usb_ufs_iniu_TO_sw_right4_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_right4_TO_usb_ufs_iniu_SIG_iniu0_rsp_last),
		.top_rsp_rsp_payload(sw_right4_TO_usb_ufs_iniu_SIG_iniu0_rsp_payload),
		.top_rsp_rsp_ready(usb_ufs_iniu_TO_sw_right4_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_right4_TO_usb_ufs_iniu_SIG_iniu0_rsp_srcid),
		.top_rsp_rsp_valid(sw_right4_TO_usb_ufs_iniu_SIG_iniu0_rsp_valid));
	mipi0_iniu_node mipi0_iniu (
		.clk_sys_clk(mipi0_iniu_node_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(mipi0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_req_tdata(mipi0_iniu_node_dti_req_porting_dti_req_req_tdata),
		.dti_req_req_tkeep(mipi0_iniu_node_dti_req_porting_dti_req_req_tkeep),
		.dti_req_req_tlast(mipi0_iniu_node_dti_req_porting_dti_req_req_tlast),
		.dti_req_req_tready(mipi0_iniu_node_dti_req_porting_dti_req_req_tready),
		.dti_req_req_ttid(mipi0_iniu_node_dti_req_porting_dti_req_req_ttid),
		.dti_req_req_tvalid(mipi0_iniu_node_dti_req_porting_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(mipi0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(mipi0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(mipi0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(mipi0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(mipi0_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(mipi0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid),
		.timeout_val_timeout_val(mipi0_iniu_node_timeout_val_porting_timeout_val_timeout_val),
		.pchnl_ctrl_paccept(mipi0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(mipi0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(mipi0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(mipi0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(mipi0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate),
		.top_req_req_last(mipi0_iniu_TO_sw_right4_SIG_top_req_req_last),
		.top_req_req_payload(mipi0_iniu_TO_sw_right4_SIG_top_req_req_payload),
		.top_req_req_ready(sw_right4_TO_mipi0_iniu_SIG_iniu1_req_ready),
		.top_req_req_srcid(mipi0_iniu_TO_sw_right4_SIG_top_req_req_srcid),
		.top_req_req_valid(mipi0_iniu_TO_sw_right4_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_right4_TO_mipi0_iniu_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(sw_right4_TO_mipi0_iniu_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_ready(mipi0_iniu_TO_sw_right4_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_right4_TO_mipi0_iniu_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_valid(sw_right4_TO_mipi0_iniu_SIG_iniu1_rsp_valid));
	mipi1_iniu_node mipi1_iniu (
		.clk_sys_clk(mipi1_iniu_node_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(mipi1_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_req_tdata(mipi1_iniu_node_dti_req_porting_dti_req_req_tdata),
		.dti_req_req_tkeep(mipi1_iniu_node_dti_req_porting_dti_req_req_tkeep),
		.dti_req_req_tlast(mipi1_iniu_node_dti_req_porting_dti_req_req_tlast),
		.dti_req_req_tready(mipi1_iniu_node_dti_req_porting_dti_req_req_tready),
		.dti_req_req_ttid(mipi1_iniu_node_dti_req_porting_dti_req_req_ttid),
		.dti_req_req_tvalid(mipi1_iniu_node_dti_req_porting_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(mipi1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(mipi1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(mipi1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(mipi1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(mipi1_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(mipi1_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid),
		.timeout_val_timeout_val(mipi1_iniu_node_timeout_val_porting_timeout_val_timeout_val),
		.pchnl_ctrl_paccept(mipi1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(mipi1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(mipi1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(mipi1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(mipi1_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate),
		.top_req_req_last(mipi1_iniu_TO_sw_right4_SIG_top_req_req_last),
		.top_req_req_payload(mipi1_iniu_TO_sw_right4_SIG_top_req_req_payload),
		.top_req_req_ready(sw_right4_TO_mipi1_iniu_SIG_iniu2_req_ready),
		.top_req_req_srcid(mipi1_iniu_TO_sw_right4_SIG_top_req_req_srcid),
		.top_req_req_valid(mipi1_iniu_TO_sw_right4_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_right4_TO_mipi1_iniu_SIG_iniu2_rsp_last),
		.top_rsp_rsp_payload(sw_right4_TO_mipi1_iniu_SIG_iniu2_rsp_payload),
		.top_rsp_rsp_ready(mipi1_iniu_TO_sw_right4_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_right4_TO_mipi1_iniu_SIG_iniu2_rsp_srcid),
		.top_rsp_rsp_valid(sw_right4_TO_mipi1_iniu_SIG_iniu2_rsp_valid));
	camera_iniu_node camera_iniu (
		.clk_sys_clk(camera_iniu_node_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(camera_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_req_tdata(camera_iniu_node_dti_req_porting_dti_req_req_tdata),
		.dti_req_req_tkeep(camera_iniu_node_dti_req_porting_dti_req_req_tkeep),
		.dti_req_req_tlast(camera_iniu_node_dti_req_porting_dti_req_req_tlast),
		.dti_req_req_tready(camera_iniu_node_dti_req_porting_dti_req_req_tready),
		.dti_req_req_ttid(camera_iniu_node_dti_req_porting_dti_req_req_ttid),
		.dti_req_req_tvalid(camera_iniu_node_dti_req_porting_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(camera_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(camera_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(camera_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(camera_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(camera_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(camera_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid),
		.timeout_val_timeout_val(camera_iniu_node_timeout_val_porting_timeout_val_timeout_val),
		.pchnl_ctrl_paccept(camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(camera_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate),
		.top_req_req_last(camera_iniu_TO_sw_right4_SIG_top_req_req_last),
		.top_req_req_payload(camera_iniu_TO_sw_right4_SIG_top_req_req_payload),
		.top_req_req_ready(sw_right4_TO_camera_iniu_SIG_iniu3_req_ready),
		.top_req_req_srcid(camera_iniu_TO_sw_right4_SIG_top_req_req_srcid),
		.top_req_req_valid(camera_iniu_TO_sw_right4_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_right4_TO_camera_iniu_SIG_iniu3_rsp_last),
		.top_rsp_rsp_payload(sw_right4_TO_camera_iniu_SIG_iniu3_rsp_payload),
		.top_rsp_rsp_ready(camera_iniu_TO_sw_right4_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_right4_TO_camera_iniu_SIG_iniu3_rsp_srcid),
		.top_rsp_rsp_valid(sw_right4_TO_camera_iniu_SIG_iniu3_rsp_valid));
	noc_tbu0_iniu_node noc_tbu0_iniu (
		.clk_sys_clk(noc_tbu0_iniu_node_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(noc_tbu0_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_req_tdata(noc_tbu0_iniu_node_dti_req_porting_dti_req_req_tdata),
		.dti_req_req_tkeep(noc_tbu0_iniu_node_dti_req_porting_dti_req_req_tkeep),
		.dti_req_req_tlast(noc_tbu0_iniu_node_dti_req_porting_dti_req_req_tlast),
		.dti_req_req_tready(noc_tbu0_iniu_node_dti_req_porting_dti_req_req_tready),
		.dti_req_req_ttid(noc_tbu0_iniu_node_dti_req_porting_dti_req_req_ttid),
		.dti_req_req_tvalid(noc_tbu0_iniu_node_dti_req_porting_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(noc_tbu0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(noc_tbu0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(noc_tbu0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(noc_tbu0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(noc_tbu0_iniu_node_dti_rsp_porting_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(noc_tbu0_iniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid),
		.timeout_val_timeout_val(noc_tbu0_iniu_node_timeout_val_porting_timeout_val_timeout_val),
		.pchnl_ctrl_paccept(noc_tbu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(noc_tbu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(noc_tbu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(noc_tbu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(noc_tbu0_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate),
		.top_req_req_last(noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_req_req_last),
		.top_req_req_payload(noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_req_req_payload),
		.top_req_req_ready(sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_req_ready),
		.top_req_req_srcid(noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_req_req_srcid),
		.top_req_req_valid(noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_req_req_valid),
		.top_rsp_rsp_last(sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_rsp_last),
		.top_rsp_rsp_payload(sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_rsp_payload),
		.top_rsp_rsp_ready(noc_tbu0_iniu_TO_sw_right_noc0_SIG_top_rsp_rsp_ready),
		.top_rsp_rsp_srcid(sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_rsp_srcid),
		.top_rsp_rsp_valid(sw_right_noc0_TO_noc_tbu0_iniu_SIG_iniu1_rsp_valid));
	tcu_tniu_node tcu_tniu (
		.clk_sys_clk(tcu_tniu_node_clk_sys_porting_clk_sys_clk),
		.rst_sys_n_rst_n(tcu_tniu_node_rst_sys_n_porting_rst_sys_n_rst_n),
		.clk_top(clk_noc),
		.rst_top_n(rst_noc_n),
		.dti_req_req_tdata(tcu_tniu_node_dti_req_porting_dti_req_req_tdata),
		.dti_req_req_tkeep(tcu_tniu_node_dti_req_porting_dti_req_req_tkeep),
		.dti_req_req_tlast(tcu_tniu_node_dti_req_porting_dti_req_req_tlast),
		.dti_req_req_tready(tcu_tniu_node_dti_req_porting_dti_req_req_tready),
		.dti_req_req_ttid(tcu_tniu_node_dti_req_porting_dti_req_req_ttid),
		.dti_req_req_tvalid(tcu_tniu_node_dti_req_porting_dti_req_req_tvalid),
		.dti_rsp_rsp_tdata(tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tdata),
		.dti_rsp_rsp_tkeep(tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tkeep),
		.dti_rsp_rsp_tlast(tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tlast),
		.dti_rsp_rsp_tready(tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tready),
		.dti_rsp_rsp_ttid(tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_ttid),
		.dti_rsp_rsp_tvalid(tcu_tniu_node_dti_rsp_porting_dti_rsp_rsp_tvalid),
		.pchnl_ctrl_paccept(tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_paccept),
		.pchnl_ctrl_pactive(tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pactive),
		.pchnl_ctrl_pdeny(tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pdeny),
		.pchnl_ctrl_preq(tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_preq),
		.pchnl_ctrl_pstate(tcu_tniu_node_pchnl_ctrl_porting_pchnl_ctrl_pstate),
		.top_req_req_last(sw_root_TO_tcu_tniu_SIG_tniu_req_last),
		.top_req_req_payload(sw_root_TO_tcu_tniu_SIG_tniu_req_payload),
		.top_req_req_ready(tcu_tniu_TO_sw_root_SIG_top_req_req_ready),
		.top_req_req_srcid(sw_root_TO_tcu_tniu_SIG_tniu_req_srcid),
		.top_req_req_valid(sw_root_TO_tcu_tniu_SIG_tniu_req_valid),
		.top_rsp_rsp_last(tcu_tniu_TO_sw_root_SIG_top_rsp_rsp_last),
		.top_rsp_rsp_payload(tcu_tniu_TO_sw_root_SIG_top_rsp_rsp_payload),
		.top_rsp_rsp_ready(sw_root_TO_tcu_tniu_SIG_tniu_rsp_ready),
		.top_rsp_rsp_srcid(tcu_tniu_TO_sw_root_SIG_top_rsp_rsp_srcid),
		.top_rsp_rsp_valid(tcu_tniu_TO_sw_root_SIG_top_rsp_rsp_valid));

endmodule
//[UHDL]Content End [md5:4508e29c3e48a802c45c48d0950a25c4]

