// Auto-generated ATB smoke TB for the current atb_soc_topo publish root
// `timescale set via VCS command line

module tb_atb_soc_topo;
    localparam int NUM_SOURCES = 15;

    // Clocks
    logic clk_dsp_ss0_sys = 1'b0;
    logic clk_dsp_ss1_sys = 1'b0;
    logic clk_dsp_ss2_sys = 1'b0;
    logic clk_dsp_ss3_sys = 1'b0;
    logic clk_dsp_ss4_sys = 1'b0;
    logic clk_dsp_ss5_sys = 1'b0;
    logic clk_camera_ss_sys = 1'b0;
    logic clk_mipi_ss_sys = 1'b0;
    logic clk_gpu1_ss_sys = 1'b0;
    logic clk_usb_dp_ss_sys = 1'b0;
    logic clk_display_ss_sys = 1'b0;
    logic clk_aon_ss_sys = 1'b0;
    logic clk_gpu_ss0_sys = 1'b0;
    logic clk_cpu_ss_sys = 1'b0;
    logic clk_mcu_ss_sys = 1'b0;
    logic clk_peri_ss_sys = 1'b0;
    logic clk_noc = 1'b0;

    // Resets
    logic rst_dsp_ss0_sys_n = 1'b0;
    logic rst_dsp_ss1_sys_n = 1'b0;
    logic rst_dsp_ss2_sys_n = 1'b0;
    logic rst_dsp_ss3_sys_n = 1'b0;
    logic rst_dsp_ss4_sys_n = 1'b0;
    logic rst_dsp_ss5_sys_n = 1'b0;
    logic rst_camera_ss_sys_n = 1'b0;
    logic rst_mipi_ss_sys_n = 1'b0;
    logic rst_gpu1_ss_sys_n = 1'b0;
    logic rst_usb_dp_ss_sys_n = 1'b0;
    logic rst_display_ss_sys_n = 1'b0;
    logic rst_aon_ss_sys_n = 1'b0;
    logic rst_gpu_ss0_sys_n = 1'b0;
    logic rst_cpu_ss_sys_n = 1'b0;
    logic rst_mcu_ss_sys_n = 1'b0;
    logic rst_peri_ss_sys_n = 1'b0;
    logic rst_noc_n = 1'b0;

    // Source-side stimulus and observation
    logic [9:0] dsp_ss0_timeout_val = 10'd1023;
    logic        dsp_ss0_s_atvalid = 1'b0;
    logic        dsp_ss0_s_atready;
    logic [127:0] dsp_ss0_s_atdata = '0;
    logic [6:0] dsp_ss0_s_atid = 7'd0;
    logic [3:0] dsp_ss0_s_atbytes = 4'd8;
    logic        dsp_ss0_s_afvalid;
    logic        dsp_ss0_s_afready = 1'b1;
    logic        dsp_ss0_s_syncreq;
    logic        dsp_ss0_s_atwakeup = 1'b0;
    logic        dsp_ss0_preq = 1'b0;
    logic [1:0] dsp_ss0_pstate = 2'b00;
    logic [1:0] dsp_ss0_pactive;
    logic        dsp_ss0_paccept;
    logic        dsp_ss0_pdeny;

    logic [9:0] dsp_ss1_timeout_val = 10'd1023;
    logic        dsp_ss1_s_atvalid = 1'b0;
    logic        dsp_ss1_s_atready;
    logic [127:0] dsp_ss1_s_atdata = '0;
    logic [6:0] dsp_ss1_s_atid = 7'd1;
    logic [3:0] dsp_ss1_s_atbytes = 4'd8;
    logic        dsp_ss1_s_afvalid;
    logic        dsp_ss1_s_afready = 1'b1;
    logic        dsp_ss1_s_syncreq;
    logic        dsp_ss1_s_atwakeup = 1'b0;
    logic        dsp_ss1_preq = 1'b0;
    logic [1:0] dsp_ss1_pstate = 2'b00;
    logic [1:0] dsp_ss1_pactive;
    logic        dsp_ss1_paccept;
    logic        dsp_ss1_pdeny;

    logic [9:0] dsp_ss2_timeout_val = 10'd1023;
    logic        dsp_ss2_s_atvalid = 1'b0;
    logic        dsp_ss2_s_atready;
    logic [127:0] dsp_ss2_s_atdata = '0;
    logic [6:0] dsp_ss2_s_atid = 7'd2;
    logic [3:0] dsp_ss2_s_atbytes = 4'd8;
    logic        dsp_ss2_s_afvalid;
    logic        dsp_ss2_s_afready = 1'b1;
    logic        dsp_ss2_s_syncreq;
    logic        dsp_ss2_s_atwakeup = 1'b0;
    logic        dsp_ss2_preq = 1'b0;
    logic [1:0] dsp_ss2_pstate = 2'b00;
    logic [1:0] dsp_ss2_pactive;
    logic        dsp_ss2_paccept;
    logic        dsp_ss2_pdeny;

    logic [9:0] dsp_ss3_timeout_val = 10'd1023;
    logic        dsp_ss3_s_atvalid = 1'b0;
    logic        dsp_ss3_s_atready;
    logic [127:0] dsp_ss3_s_atdata = '0;
    logic [6:0] dsp_ss3_s_atid = 7'd3;
    logic [3:0] dsp_ss3_s_atbytes = 4'd8;
    logic        dsp_ss3_s_afvalid;
    logic        dsp_ss3_s_afready = 1'b1;
    logic        dsp_ss3_s_syncreq;
    logic        dsp_ss3_s_atwakeup = 1'b0;
    logic        dsp_ss3_preq = 1'b0;
    logic [1:0] dsp_ss3_pstate = 2'b00;
    logic [1:0] dsp_ss3_pactive;
    logic        dsp_ss3_paccept;
    logic        dsp_ss3_pdeny;

    logic [9:0] dsp_ss4_timeout_val = 10'd1023;
    logic        dsp_ss4_s_atvalid = 1'b0;
    logic        dsp_ss4_s_atready;
    logic [127:0] dsp_ss4_s_atdata = '0;
    logic [6:0] dsp_ss4_s_atid = 7'd4;
    logic [3:0] dsp_ss4_s_atbytes = 4'd8;
    logic        dsp_ss4_s_afvalid;
    logic        dsp_ss4_s_afready = 1'b1;
    logic        dsp_ss4_s_syncreq;
    logic        dsp_ss4_s_atwakeup = 1'b0;
    logic        dsp_ss4_preq = 1'b0;
    logic [1:0] dsp_ss4_pstate = 2'b00;
    logic [1:0] dsp_ss4_pactive;
    logic        dsp_ss4_paccept;
    logic        dsp_ss4_pdeny;

    logic [9:0] dsp_ss5_timeout_val = 10'd1023;
    logic        dsp_ss5_s_atvalid = 1'b0;
    logic        dsp_ss5_s_atready;
    logic [127:0] dsp_ss5_s_atdata = '0;
    logic [6:0] dsp_ss5_s_atid = 7'd5;
    logic [3:0] dsp_ss5_s_atbytes = 4'd8;
    logic        dsp_ss5_s_afvalid;
    logic        dsp_ss5_s_afready = 1'b1;
    logic        dsp_ss5_s_syncreq;
    logic        dsp_ss5_s_atwakeup = 1'b0;
    logic        dsp_ss5_preq = 1'b0;
    logic [1:0] dsp_ss5_pstate = 2'b00;
    logic [1:0] dsp_ss5_pactive;
    logic        dsp_ss5_paccept;
    logic        dsp_ss5_pdeny;

    logic [9:0] camera_ss_timeout_val = 10'd1023;
    logic        camera_ss_s_atvalid = 1'b0;
    logic        camera_ss_s_atready;
    logic [127:0] camera_ss_s_atdata = '0;
    logic [6:0] camera_ss_s_atid = 7'd6;
    logic [3:0] camera_ss_s_atbytes = 4'd8;
    logic        camera_ss_s_afvalid;
    logic        camera_ss_s_afready = 1'b1;
    logic        camera_ss_s_syncreq;
    logic        camera_ss_s_atwakeup = 1'b0;
    logic        camera_ss_preq = 1'b0;
    logic [1:0] camera_ss_pstate = 2'b00;
    logic [1:0] camera_ss_pactive;
    logic        camera_ss_paccept;
    logic        camera_ss_pdeny;

    logic [9:0] mipi_ss_timeout_val = 10'd1023;
    logic        mipi_ss_s_atvalid = 1'b0;
    logic        mipi_ss_s_atready;
    logic [127:0] mipi_ss_s_atdata = '0;
    logic [6:0] mipi_ss_s_atid = 7'd7;
    logic [3:0] mipi_ss_s_atbytes = 4'd8;
    logic        mipi_ss_s_afvalid;
    logic        mipi_ss_s_afready = 1'b1;
    logic        mipi_ss_s_syncreq;
    logic        mipi_ss_s_atwakeup = 1'b0;
    logic        mipi_ss_preq = 1'b0;
    logic [1:0] mipi_ss_pstate = 2'b00;
    logic [1:0] mipi_ss_pactive;
    logic        mipi_ss_paccept;
    logic        mipi_ss_pdeny;

    logic [9:0] gpu1_ss_timeout_val = 10'd1023;
    logic        gpu1_ss_s_atvalid = 1'b0;
    logic        gpu1_ss_s_atready;
    logic [127:0] gpu1_ss_s_atdata = '0;
    logic [6:0] gpu1_ss_s_atid = 7'd8;
    logic [3:0] gpu1_ss_s_atbytes = 4'd8;
    logic        gpu1_ss_s_afvalid;
    logic        gpu1_ss_s_afready = 1'b1;
    logic        gpu1_ss_s_syncreq;
    logic        gpu1_ss_s_atwakeup = 1'b0;
    logic        gpu1_ss_preq = 1'b0;
    logic [1:0] gpu1_ss_pstate = 2'b00;
    logic [1:0] gpu1_ss_pactive;
    logic        gpu1_ss_paccept;
    logic        gpu1_ss_pdeny;

    logic [9:0] usb_dp_ss_timeout_val = 10'd1023;
    logic        usb_dp_ss_s_atvalid = 1'b0;
    logic        usb_dp_ss_s_atready;
    logic [127:0] usb_dp_ss_s_atdata = '0;
    logic [6:0] usb_dp_ss_s_atid = 7'd9;
    logic [3:0] usb_dp_ss_s_atbytes = 4'd8;
    logic        usb_dp_ss_s_afvalid;
    logic        usb_dp_ss_s_afready = 1'b1;
    logic        usb_dp_ss_s_syncreq;
    logic        usb_dp_ss_s_atwakeup = 1'b0;
    logic        usb_dp_ss_preq = 1'b0;
    logic [1:0] usb_dp_ss_pstate = 2'b00;
    logic [1:0] usb_dp_ss_pactive;
    logic        usb_dp_ss_paccept;
    logic        usb_dp_ss_pdeny;

    logic [9:0] display_ss_timeout_val = 10'd1023;
    logic        display_ss_s_atvalid = 1'b0;
    logic        display_ss_s_atready;
    logic [127:0] display_ss_s_atdata = '0;
    logic [6:0] display_ss_s_atid = 7'd10;
    logic [3:0] display_ss_s_atbytes = 4'd8;
    logic        display_ss_s_afvalid;
    logic        display_ss_s_afready = 1'b1;
    logic        display_ss_s_syncreq;
    logic        display_ss_s_atwakeup = 1'b0;
    logic        display_ss_preq = 1'b0;
    logic [1:0] display_ss_pstate = 2'b00;
    logic [1:0] display_ss_pactive;
    logic        display_ss_paccept;
    logic        display_ss_pdeny;

    logic [9:0] aon_ss_timeout_val = 10'd1023;
    logic        aon_ss_s_atvalid = 1'b0;
    logic        aon_ss_s_atready;
    logic [127:0] aon_ss_s_atdata = '0;
    logic [6:0] aon_ss_s_atid = 7'd11;
    logic [3:0] aon_ss_s_atbytes = 4'd8;
    logic        aon_ss_s_afvalid;
    logic        aon_ss_s_afready = 1'b1;
    logic        aon_ss_s_syncreq;
    logic        aon_ss_s_atwakeup = 1'b0;
    logic        aon_ss_preq = 1'b0;
    logic [1:0] aon_ss_pstate = 2'b00;
    logic [1:0] aon_ss_pactive;
    logic        aon_ss_paccept;
    logic        aon_ss_pdeny;

    logic [9:0] gpu_ss0_timeout_val = 10'd1023;
    logic        gpu_ss0_s_atvalid = 1'b0;
    logic        gpu_ss0_s_atready;
    logic [127:0] gpu_ss0_s_atdata = '0;
    logic [6:0] gpu_ss0_s_atid = 7'd12;
    logic [3:0] gpu_ss0_s_atbytes = 4'd8;
    logic        gpu_ss0_s_afvalid;
    logic        gpu_ss0_s_afready = 1'b1;
    logic        gpu_ss0_s_syncreq;
    logic        gpu_ss0_s_atwakeup = 1'b0;
    logic        gpu_ss0_preq = 1'b0;
    logic [1:0] gpu_ss0_pstate = 2'b00;
    logic [1:0] gpu_ss0_pactive;
    logic        gpu_ss0_paccept;
    logic        gpu_ss0_pdeny;

    logic [9:0] cpu_ss_timeout_val = 10'd1023;
    logic        cpu_ss_s_atvalid = 1'b0;
    logic        cpu_ss_s_atready;
    logic [127:0] cpu_ss_s_atdata = '0;
    logic [6:0] cpu_ss_s_atid = 7'd13;
    logic [3:0] cpu_ss_s_atbytes = 4'd8;
    logic        cpu_ss_s_afvalid;
    logic        cpu_ss_s_afready = 1'b1;
    logic        cpu_ss_s_syncreq;
    logic        cpu_ss_s_atwakeup = 1'b0;
    logic        cpu_ss_preq = 1'b0;
    logic [1:0] cpu_ss_pstate = 2'b00;
    logic [1:0] cpu_ss_pactive;
    logic        cpu_ss_paccept;
    logic        cpu_ss_pdeny;

    logic [9:0] mcu_ss_timeout_val = 10'd1023;
    logic        mcu_ss_s_atvalid = 1'b0;
    logic        mcu_ss_s_atready;
    logic [127:0] mcu_ss_s_atdata = '0;
    logic [6:0] mcu_ss_s_atid = 7'd14;
    logic [3:0] mcu_ss_s_atbytes = 4'd8;
    logic        mcu_ss_s_afvalid;
    logic        mcu_ss_s_afready = 1'b1;
    logic        mcu_ss_s_syncreq;
    logic        mcu_ss_s_atwakeup = 1'b0;
    logic        mcu_ss_preq = 1'b0;
    logic [1:0] mcu_ss_pstate = 2'b00;
    logic [1:0] mcu_ss_pactive;
    logic        mcu_ss_paccept;
    logic        mcu_ss_pdeny;

    // Peri sink-side stimulus and observation
    logic [9:0] peri_ss_timeout_val = 10'd1023;
    logic        peri_ss_m_atvalid;
    logic        peri_ss_m_atready = 1'b1;
    logic [127:0] peri_ss_m_atdata;
    logic [6:0] peri_ss_m_atid;
    logic [3:0] peri_ss_m_atbytes;
    logic        peri_ss_m_afvalid = 1'b0;
    logic        peri_ss_m_afready;
    logic        peri_ss_m_syncreq = 1'b0;
    logic        peri_ss_m_atwakeup;
    logic        peri_ss_preq = 1'b0;
    logic [1:0] peri_ss_pstate = 2'b00;
    logic [1:0] peri_ss_pactive;
    logic        peri_ss_paccept;
    logic        peri_ss_pdeny;

    integer rx_count_total;
    integer rx_count_by_tid [0:127];
    integer dbg_noc_prints;
    integer dbg_peri_prints;
    integer dbg_dsp0_prints;
    integer dbg_dsp0_sys_prints;
    integer dbg_dsp0_afifo_window;
    integer dbg_dsp0_finish_window;
    integer dbg_dsp0_finish_stg2_window;
    logic [127:0] expected_data_by_tid [0:127];
    logic         expected_valid_by_tid [0:127];
    logic [31:0] flush_seen;
    logic        data_mismatch_seen;
    integer      early_finish_ps;
    integer      stop_after_dsp0_afifo_cycles;
    integer      stop_after_dsp0_afifo_stg2_cycles;

    atb_soc_topo dut (
        .clk_dsp_ss0_sys(clk_dsp_ss0_sys),
        .rst_dsp_ss0_sys_n(rst_dsp_ss0_sys_n),
        .clk_dsp_ss1_sys(clk_dsp_ss1_sys),
        .rst_dsp_ss1_sys_n(rst_dsp_ss1_sys_n),
        .clk_dsp_ss2_sys(clk_dsp_ss2_sys),
        .rst_dsp_ss2_sys_n(rst_dsp_ss2_sys_n),
        .clk_dsp_ss3_sys(clk_dsp_ss3_sys),
        .rst_dsp_ss3_sys_n(rst_dsp_ss3_sys_n),
        .clk_dsp_ss4_sys(clk_dsp_ss4_sys),
        .rst_dsp_ss4_sys_n(rst_dsp_ss4_sys_n),
        .clk_dsp_ss5_sys(clk_dsp_ss5_sys),
        .rst_dsp_ss5_sys_n(rst_dsp_ss5_sys_n),
        .clk_camera_ss_sys(clk_camera_ss_sys),
        .rst_camera_ss_sys_n(rst_camera_ss_sys_n),
        .clk_mipi_ss_sys(clk_mipi_ss_sys),
        .rst_mipi_ss_sys_n(rst_mipi_ss_sys_n),
        .clk_gpu1_ss_sys(clk_gpu1_ss_sys),
        .rst_gpu1_ss_sys_n(rst_gpu1_ss_sys_n),
        .clk_usb_dp_ss_sys(clk_usb_dp_ss_sys),
        .rst_usb_dp_ss_sys_n(rst_usb_dp_ss_sys_n),
        .clk_display_ss_sys(clk_display_ss_sys),
        .rst_display_ss_sys_n(rst_display_ss_sys_n),
        .clk_aon_ss_sys(clk_aon_ss_sys),
        .rst_aon_ss_sys_n(rst_aon_ss_sys_n),
        .clk_gpu_ss0_sys(clk_gpu_ss0_sys),
        .rst_gpu_ss0_sys_n(rst_gpu_ss0_sys_n),
        .clk_cpu_ss_sys(clk_cpu_ss_sys),
        .rst_cpu_ss_sys_n(rst_cpu_ss_sys_n),
        .clk_mcu_ss_sys(clk_mcu_ss_sys),
        .rst_mcu_ss_sys_n(rst_mcu_ss_sys_n),
        .clk_peri_ss_sys(clk_peri_ss_sys),
        .rst_peri_ss_sys_n(rst_peri_ss_sys_n),
        .clk_noc(clk_noc),
        .rst_noc_n(rst_noc_n),
        .dsp_ss0_node_timeout_val_porting(dsp_ss0_timeout_val),
        .dsp_ss0_node_dsp_ss0_sys_node_s_chan_porting_dsp_ss0_sys_node_s_chan_porting_s_atvalid(dsp_ss0_s_atvalid),
        .dsp_ss0_node_dsp_ss0_sys_node_s_chan_porting_dsp_ss0_sys_node_s_chan_porting_s_atready(dsp_ss0_s_atready),
        .dsp_ss0_node_dsp_ss0_sys_node_s_chan_porting_dsp_ss0_sys_node_s_chan_porting_s_atdata(dsp_ss0_s_atdata),
        .dsp_ss0_node_dsp_ss0_sys_node_s_chan_porting_dsp_ss0_sys_node_s_chan_porting_s_atid(dsp_ss0_s_atid),
        .dsp_ss0_node_dsp_ss0_sys_node_s_chan_porting_dsp_ss0_sys_node_s_chan_porting_s_atbytes(dsp_ss0_s_atbytes),
        .dsp_ss0_node_dsp_ss0_sys_node_s_chan_porting_dsp_ss0_sys_node_s_chan_porting_s_afvalid(dsp_ss0_s_afvalid),
        .dsp_ss0_node_dsp_ss0_sys_node_s_chan_porting_dsp_ss0_sys_node_s_chan_porting_s_afready(dsp_ss0_s_afready),
        .dsp_ss0_node_dsp_ss0_sys_node_s_chan_porting_dsp_ss0_sys_node_s_chan_porting_s_syncreq(dsp_ss0_s_syncreq),
        .dsp_ss0_node_dsp_ss0_sys_node_s_chan_porting_dsp_ss0_sys_node_s_chan_porting_s_atwakeup(dsp_ss0_s_atwakeup),
        .dsp_ss0_node_dsp_ss0_sys_node_pchnl_ctrl_porting_dsp_ss0_sys_node_pchnl_ctrl_porting_preq(dsp_ss0_preq),
        .dsp_ss0_node_dsp_ss0_sys_node_pchnl_ctrl_porting_dsp_ss0_sys_node_pchnl_ctrl_porting_pstate(dsp_ss0_pstate),
        .dsp_ss0_node_dsp_ss0_sys_node_pchnl_ctrl_porting_dsp_ss0_sys_node_pchnl_ctrl_porting_pactive(dsp_ss0_pactive),
        .dsp_ss0_node_dsp_ss0_sys_node_pchnl_ctrl_porting_dsp_ss0_sys_node_pchnl_ctrl_porting_paccept(dsp_ss0_paccept),
        .dsp_ss0_node_dsp_ss0_sys_node_pchnl_ctrl_porting_dsp_ss0_sys_node_pchnl_ctrl_porting_pdeny(dsp_ss0_pdeny),
        .dsp_ss1_node_timeout_val_porting(dsp_ss1_timeout_val),
        .dsp_ss1_node_dsp_ss1_sys_node_s_chan_porting_dsp_ss1_sys_node_s_chan_porting_s_atvalid(dsp_ss1_s_atvalid),
        .dsp_ss1_node_dsp_ss1_sys_node_s_chan_porting_dsp_ss1_sys_node_s_chan_porting_s_atready(dsp_ss1_s_atready),
        .dsp_ss1_node_dsp_ss1_sys_node_s_chan_porting_dsp_ss1_sys_node_s_chan_porting_s_atdata(dsp_ss1_s_atdata),
        .dsp_ss1_node_dsp_ss1_sys_node_s_chan_porting_dsp_ss1_sys_node_s_chan_porting_s_atid(dsp_ss1_s_atid),
        .dsp_ss1_node_dsp_ss1_sys_node_s_chan_porting_dsp_ss1_sys_node_s_chan_porting_s_atbytes(dsp_ss1_s_atbytes),
        .dsp_ss1_node_dsp_ss1_sys_node_s_chan_porting_dsp_ss1_sys_node_s_chan_porting_s_afvalid(dsp_ss1_s_afvalid),
        .dsp_ss1_node_dsp_ss1_sys_node_s_chan_porting_dsp_ss1_sys_node_s_chan_porting_s_afready(dsp_ss1_s_afready),
        .dsp_ss1_node_dsp_ss1_sys_node_s_chan_porting_dsp_ss1_sys_node_s_chan_porting_s_syncreq(dsp_ss1_s_syncreq),
        .dsp_ss1_node_dsp_ss1_sys_node_s_chan_porting_dsp_ss1_sys_node_s_chan_porting_s_atwakeup(dsp_ss1_s_atwakeup),
        .dsp_ss1_node_dsp_ss1_sys_node_pchnl_ctrl_porting_dsp_ss1_sys_node_pchnl_ctrl_porting_preq(dsp_ss1_preq),
        .dsp_ss1_node_dsp_ss1_sys_node_pchnl_ctrl_porting_dsp_ss1_sys_node_pchnl_ctrl_porting_pstate(dsp_ss1_pstate),
        .dsp_ss1_node_dsp_ss1_sys_node_pchnl_ctrl_porting_dsp_ss1_sys_node_pchnl_ctrl_porting_pactive(dsp_ss1_pactive),
        .dsp_ss1_node_dsp_ss1_sys_node_pchnl_ctrl_porting_dsp_ss1_sys_node_pchnl_ctrl_porting_paccept(dsp_ss1_paccept),
        .dsp_ss1_node_dsp_ss1_sys_node_pchnl_ctrl_porting_dsp_ss1_sys_node_pchnl_ctrl_porting_pdeny(dsp_ss1_pdeny),
        .dsp_ss2_node_timeout_val_porting(dsp_ss2_timeout_val),
        .dsp_ss2_node_dsp_ss2_sys_node_s_chan_porting_dsp_ss2_sys_node_s_chan_porting_s_atvalid(dsp_ss2_s_atvalid),
        .dsp_ss2_node_dsp_ss2_sys_node_s_chan_porting_dsp_ss2_sys_node_s_chan_porting_s_atready(dsp_ss2_s_atready),
        .dsp_ss2_node_dsp_ss2_sys_node_s_chan_porting_dsp_ss2_sys_node_s_chan_porting_s_atdata(dsp_ss2_s_atdata),
        .dsp_ss2_node_dsp_ss2_sys_node_s_chan_porting_dsp_ss2_sys_node_s_chan_porting_s_atid(dsp_ss2_s_atid),
        .dsp_ss2_node_dsp_ss2_sys_node_s_chan_porting_dsp_ss2_sys_node_s_chan_porting_s_atbytes(dsp_ss2_s_atbytes),
        .dsp_ss2_node_dsp_ss2_sys_node_s_chan_porting_dsp_ss2_sys_node_s_chan_porting_s_afvalid(dsp_ss2_s_afvalid),
        .dsp_ss2_node_dsp_ss2_sys_node_s_chan_porting_dsp_ss2_sys_node_s_chan_porting_s_afready(dsp_ss2_s_afready),
        .dsp_ss2_node_dsp_ss2_sys_node_s_chan_porting_dsp_ss2_sys_node_s_chan_porting_s_syncreq(dsp_ss2_s_syncreq),
        .dsp_ss2_node_dsp_ss2_sys_node_s_chan_porting_dsp_ss2_sys_node_s_chan_porting_s_atwakeup(dsp_ss2_s_atwakeup),
        .dsp_ss2_node_dsp_ss2_sys_node_pchnl_ctrl_porting_dsp_ss2_sys_node_pchnl_ctrl_porting_preq(dsp_ss2_preq),
        .dsp_ss2_node_dsp_ss2_sys_node_pchnl_ctrl_porting_dsp_ss2_sys_node_pchnl_ctrl_porting_pstate(dsp_ss2_pstate),
        .dsp_ss2_node_dsp_ss2_sys_node_pchnl_ctrl_porting_dsp_ss2_sys_node_pchnl_ctrl_porting_pactive(dsp_ss2_pactive),
        .dsp_ss2_node_dsp_ss2_sys_node_pchnl_ctrl_porting_dsp_ss2_sys_node_pchnl_ctrl_porting_paccept(dsp_ss2_paccept),
        .dsp_ss2_node_dsp_ss2_sys_node_pchnl_ctrl_porting_dsp_ss2_sys_node_pchnl_ctrl_porting_pdeny(dsp_ss2_pdeny),
        .dsp_ss3_node_timeout_val_porting(dsp_ss3_timeout_val),
        .dsp_ss3_node_dsp_ss3_sys_node_s_chan_porting_dsp_ss3_sys_node_s_chan_porting_s_atvalid(dsp_ss3_s_atvalid),
        .dsp_ss3_node_dsp_ss3_sys_node_s_chan_porting_dsp_ss3_sys_node_s_chan_porting_s_atready(dsp_ss3_s_atready),
        .dsp_ss3_node_dsp_ss3_sys_node_s_chan_porting_dsp_ss3_sys_node_s_chan_porting_s_atdata(dsp_ss3_s_atdata),
        .dsp_ss3_node_dsp_ss3_sys_node_s_chan_porting_dsp_ss3_sys_node_s_chan_porting_s_atid(dsp_ss3_s_atid),
        .dsp_ss3_node_dsp_ss3_sys_node_s_chan_porting_dsp_ss3_sys_node_s_chan_porting_s_atbytes(dsp_ss3_s_atbytes),
        .dsp_ss3_node_dsp_ss3_sys_node_s_chan_porting_dsp_ss3_sys_node_s_chan_porting_s_afvalid(dsp_ss3_s_afvalid),
        .dsp_ss3_node_dsp_ss3_sys_node_s_chan_porting_dsp_ss3_sys_node_s_chan_porting_s_afready(dsp_ss3_s_afready),
        .dsp_ss3_node_dsp_ss3_sys_node_s_chan_porting_dsp_ss3_sys_node_s_chan_porting_s_syncreq(dsp_ss3_s_syncreq),
        .dsp_ss3_node_dsp_ss3_sys_node_s_chan_porting_dsp_ss3_sys_node_s_chan_porting_s_atwakeup(dsp_ss3_s_atwakeup),
        .dsp_ss3_node_dsp_ss3_sys_node_pchnl_ctrl_porting_dsp_ss3_sys_node_pchnl_ctrl_porting_preq(dsp_ss3_preq),
        .dsp_ss3_node_dsp_ss3_sys_node_pchnl_ctrl_porting_dsp_ss3_sys_node_pchnl_ctrl_porting_pstate(dsp_ss3_pstate),
        .dsp_ss3_node_dsp_ss3_sys_node_pchnl_ctrl_porting_dsp_ss3_sys_node_pchnl_ctrl_porting_pactive(dsp_ss3_pactive),
        .dsp_ss3_node_dsp_ss3_sys_node_pchnl_ctrl_porting_dsp_ss3_sys_node_pchnl_ctrl_porting_paccept(dsp_ss3_paccept),
        .dsp_ss3_node_dsp_ss3_sys_node_pchnl_ctrl_porting_dsp_ss3_sys_node_pchnl_ctrl_porting_pdeny(dsp_ss3_pdeny),
        .dsp_ss4_node_timeout_val_porting(dsp_ss4_timeout_val),
        .dsp_ss4_node_dsp_ss4_sys_node_s_chan_porting_dsp_ss4_sys_node_s_chan_porting_s_atvalid(dsp_ss4_s_atvalid),
        .dsp_ss4_node_dsp_ss4_sys_node_s_chan_porting_dsp_ss4_sys_node_s_chan_porting_s_atready(dsp_ss4_s_atready),
        .dsp_ss4_node_dsp_ss4_sys_node_s_chan_porting_dsp_ss4_sys_node_s_chan_porting_s_atdata(dsp_ss4_s_atdata),
        .dsp_ss4_node_dsp_ss4_sys_node_s_chan_porting_dsp_ss4_sys_node_s_chan_porting_s_atid(dsp_ss4_s_atid),
        .dsp_ss4_node_dsp_ss4_sys_node_s_chan_porting_dsp_ss4_sys_node_s_chan_porting_s_atbytes(dsp_ss4_s_atbytes),
        .dsp_ss4_node_dsp_ss4_sys_node_s_chan_porting_dsp_ss4_sys_node_s_chan_porting_s_afvalid(dsp_ss4_s_afvalid),
        .dsp_ss4_node_dsp_ss4_sys_node_s_chan_porting_dsp_ss4_sys_node_s_chan_porting_s_afready(dsp_ss4_s_afready),
        .dsp_ss4_node_dsp_ss4_sys_node_s_chan_porting_dsp_ss4_sys_node_s_chan_porting_s_syncreq(dsp_ss4_s_syncreq),
        .dsp_ss4_node_dsp_ss4_sys_node_s_chan_porting_dsp_ss4_sys_node_s_chan_porting_s_atwakeup(dsp_ss4_s_atwakeup),
        .dsp_ss4_node_dsp_ss4_sys_node_pchnl_ctrl_porting_dsp_ss4_sys_node_pchnl_ctrl_porting_preq(dsp_ss4_preq),
        .dsp_ss4_node_dsp_ss4_sys_node_pchnl_ctrl_porting_dsp_ss4_sys_node_pchnl_ctrl_porting_pstate(dsp_ss4_pstate),
        .dsp_ss4_node_dsp_ss4_sys_node_pchnl_ctrl_porting_dsp_ss4_sys_node_pchnl_ctrl_porting_pactive(dsp_ss4_pactive),
        .dsp_ss4_node_dsp_ss4_sys_node_pchnl_ctrl_porting_dsp_ss4_sys_node_pchnl_ctrl_porting_paccept(dsp_ss4_paccept),
        .dsp_ss4_node_dsp_ss4_sys_node_pchnl_ctrl_porting_dsp_ss4_sys_node_pchnl_ctrl_porting_pdeny(dsp_ss4_pdeny),
        .dsp_ss5_node_timeout_val_porting(dsp_ss5_timeout_val),
        .dsp_ss5_node_dsp_ss5_sys_node_s_chan_porting_dsp_ss5_sys_node_s_chan_porting_s_atvalid(dsp_ss5_s_atvalid),
        .dsp_ss5_node_dsp_ss5_sys_node_s_chan_porting_dsp_ss5_sys_node_s_chan_porting_s_atready(dsp_ss5_s_atready),
        .dsp_ss5_node_dsp_ss5_sys_node_s_chan_porting_dsp_ss5_sys_node_s_chan_porting_s_atdata(dsp_ss5_s_atdata),
        .dsp_ss5_node_dsp_ss5_sys_node_s_chan_porting_dsp_ss5_sys_node_s_chan_porting_s_atid(dsp_ss5_s_atid),
        .dsp_ss5_node_dsp_ss5_sys_node_s_chan_porting_dsp_ss5_sys_node_s_chan_porting_s_atbytes(dsp_ss5_s_atbytes),
        .dsp_ss5_node_dsp_ss5_sys_node_s_chan_porting_dsp_ss5_sys_node_s_chan_porting_s_afvalid(dsp_ss5_s_afvalid),
        .dsp_ss5_node_dsp_ss5_sys_node_s_chan_porting_dsp_ss5_sys_node_s_chan_porting_s_afready(dsp_ss5_s_afready),
        .dsp_ss5_node_dsp_ss5_sys_node_s_chan_porting_dsp_ss5_sys_node_s_chan_porting_s_syncreq(dsp_ss5_s_syncreq),
        .dsp_ss5_node_dsp_ss5_sys_node_s_chan_porting_dsp_ss5_sys_node_s_chan_porting_s_atwakeup(dsp_ss5_s_atwakeup),
        .dsp_ss5_node_dsp_ss5_sys_node_pchnl_ctrl_porting_dsp_ss5_sys_node_pchnl_ctrl_porting_preq(dsp_ss5_preq),
        .dsp_ss5_node_dsp_ss5_sys_node_pchnl_ctrl_porting_dsp_ss5_sys_node_pchnl_ctrl_porting_pstate(dsp_ss5_pstate),
        .dsp_ss5_node_dsp_ss5_sys_node_pchnl_ctrl_porting_dsp_ss5_sys_node_pchnl_ctrl_porting_pactive(dsp_ss5_pactive),
        .dsp_ss5_node_dsp_ss5_sys_node_pchnl_ctrl_porting_dsp_ss5_sys_node_pchnl_ctrl_porting_paccept(dsp_ss5_paccept),
        .dsp_ss5_node_dsp_ss5_sys_node_pchnl_ctrl_porting_dsp_ss5_sys_node_pchnl_ctrl_porting_pdeny(dsp_ss5_pdeny),
        .camera_ss_node_timeout_val_porting(camera_ss_timeout_val),
        .camera_ss_node_camera_ss_sys_node_s_chan_porting_camera_ss_sys_node_s_chan_porting_s_atvalid(camera_ss_s_atvalid),
        .camera_ss_node_camera_ss_sys_node_s_chan_porting_camera_ss_sys_node_s_chan_porting_s_atready(camera_ss_s_atready),
        .camera_ss_node_camera_ss_sys_node_s_chan_porting_camera_ss_sys_node_s_chan_porting_s_atdata(camera_ss_s_atdata),
        .camera_ss_node_camera_ss_sys_node_s_chan_porting_camera_ss_sys_node_s_chan_porting_s_atid(camera_ss_s_atid),
        .camera_ss_node_camera_ss_sys_node_s_chan_porting_camera_ss_sys_node_s_chan_porting_s_atbytes(camera_ss_s_atbytes),
        .camera_ss_node_camera_ss_sys_node_s_chan_porting_camera_ss_sys_node_s_chan_porting_s_afvalid(camera_ss_s_afvalid),
        .camera_ss_node_camera_ss_sys_node_s_chan_porting_camera_ss_sys_node_s_chan_porting_s_afready(camera_ss_s_afready),
        .camera_ss_node_camera_ss_sys_node_s_chan_porting_camera_ss_sys_node_s_chan_porting_s_syncreq(camera_ss_s_syncreq),
        .camera_ss_node_camera_ss_sys_node_s_chan_porting_camera_ss_sys_node_s_chan_porting_s_atwakeup(camera_ss_s_atwakeup),
        .camera_ss_node_camera_ss_sys_node_pchnl_ctrl_porting_camera_ss_sys_node_pchnl_ctrl_porting_preq(camera_ss_preq),
        .camera_ss_node_camera_ss_sys_node_pchnl_ctrl_porting_camera_ss_sys_node_pchnl_ctrl_porting_pstate(camera_ss_pstate),
        .camera_ss_node_camera_ss_sys_node_pchnl_ctrl_porting_camera_ss_sys_node_pchnl_ctrl_porting_pactive(camera_ss_pactive),
        .camera_ss_node_camera_ss_sys_node_pchnl_ctrl_porting_camera_ss_sys_node_pchnl_ctrl_porting_paccept(camera_ss_paccept),
        .camera_ss_node_camera_ss_sys_node_pchnl_ctrl_porting_camera_ss_sys_node_pchnl_ctrl_porting_pdeny(camera_ss_pdeny),
        .mipi_ss_node_timeout_val_porting(mipi_ss_timeout_val),
        .mipi_ss_node_mipi_ss_sys_node_s_chan_porting_mipi_ss_sys_node_s_chan_porting_s_atvalid(mipi_ss_s_atvalid),
        .mipi_ss_node_mipi_ss_sys_node_s_chan_porting_mipi_ss_sys_node_s_chan_porting_s_atready(mipi_ss_s_atready),
        .mipi_ss_node_mipi_ss_sys_node_s_chan_porting_mipi_ss_sys_node_s_chan_porting_s_atdata(mipi_ss_s_atdata),
        .mipi_ss_node_mipi_ss_sys_node_s_chan_porting_mipi_ss_sys_node_s_chan_porting_s_atid(mipi_ss_s_atid),
        .mipi_ss_node_mipi_ss_sys_node_s_chan_porting_mipi_ss_sys_node_s_chan_porting_s_atbytes(mipi_ss_s_atbytes),
        .mipi_ss_node_mipi_ss_sys_node_s_chan_porting_mipi_ss_sys_node_s_chan_porting_s_afvalid(mipi_ss_s_afvalid),
        .mipi_ss_node_mipi_ss_sys_node_s_chan_porting_mipi_ss_sys_node_s_chan_porting_s_afready(mipi_ss_s_afready),
        .mipi_ss_node_mipi_ss_sys_node_s_chan_porting_mipi_ss_sys_node_s_chan_porting_s_syncreq(mipi_ss_s_syncreq),
        .mipi_ss_node_mipi_ss_sys_node_s_chan_porting_mipi_ss_sys_node_s_chan_porting_s_atwakeup(mipi_ss_s_atwakeup),
        .mipi_ss_node_mipi_ss_sys_node_pchnl_ctrl_porting_mipi_ss_sys_node_pchnl_ctrl_porting_preq(mipi_ss_preq),
        .mipi_ss_node_mipi_ss_sys_node_pchnl_ctrl_porting_mipi_ss_sys_node_pchnl_ctrl_porting_pstate(mipi_ss_pstate),
        .mipi_ss_node_mipi_ss_sys_node_pchnl_ctrl_porting_mipi_ss_sys_node_pchnl_ctrl_porting_pactive(mipi_ss_pactive),
        .mipi_ss_node_mipi_ss_sys_node_pchnl_ctrl_porting_mipi_ss_sys_node_pchnl_ctrl_porting_paccept(mipi_ss_paccept),
        .mipi_ss_node_mipi_ss_sys_node_pchnl_ctrl_porting_mipi_ss_sys_node_pchnl_ctrl_porting_pdeny(mipi_ss_pdeny),
        .gpu1_ss_node_timeout_val_porting(gpu1_ss_timeout_val),
        .gpu1_ss_node_gpu1_ss_sys_node_s_chan_porting_gpu1_ss_sys_node_s_chan_porting_s_atvalid(gpu1_ss_s_atvalid),
        .gpu1_ss_node_gpu1_ss_sys_node_s_chan_porting_gpu1_ss_sys_node_s_chan_porting_s_atready(gpu1_ss_s_atready),
        .gpu1_ss_node_gpu1_ss_sys_node_s_chan_porting_gpu1_ss_sys_node_s_chan_porting_s_atdata(gpu1_ss_s_atdata),
        .gpu1_ss_node_gpu1_ss_sys_node_s_chan_porting_gpu1_ss_sys_node_s_chan_porting_s_atid(gpu1_ss_s_atid),
        .gpu1_ss_node_gpu1_ss_sys_node_s_chan_porting_gpu1_ss_sys_node_s_chan_porting_s_atbytes(gpu1_ss_s_atbytes),
        .gpu1_ss_node_gpu1_ss_sys_node_s_chan_porting_gpu1_ss_sys_node_s_chan_porting_s_afvalid(gpu1_ss_s_afvalid),
        .gpu1_ss_node_gpu1_ss_sys_node_s_chan_porting_gpu1_ss_sys_node_s_chan_porting_s_afready(gpu1_ss_s_afready),
        .gpu1_ss_node_gpu1_ss_sys_node_s_chan_porting_gpu1_ss_sys_node_s_chan_porting_s_syncreq(gpu1_ss_s_syncreq),
        .gpu1_ss_node_gpu1_ss_sys_node_s_chan_porting_gpu1_ss_sys_node_s_chan_porting_s_atwakeup(gpu1_ss_s_atwakeup),
        .gpu1_ss_node_gpu1_ss_sys_node_pchnl_ctrl_porting_gpu1_ss_sys_node_pchnl_ctrl_porting_preq(gpu1_ss_preq),
        .gpu1_ss_node_gpu1_ss_sys_node_pchnl_ctrl_porting_gpu1_ss_sys_node_pchnl_ctrl_porting_pstate(gpu1_ss_pstate),
        .gpu1_ss_node_gpu1_ss_sys_node_pchnl_ctrl_porting_gpu1_ss_sys_node_pchnl_ctrl_porting_pactive(gpu1_ss_pactive),
        .gpu1_ss_node_gpu1_ss_sys_node_pchnl_ctrl_porting_gpu1_ss_sys_node_pchnl_ctrl_porting_paccept(gpu1_ss_paccept),
        .gpu1_ss_node_gpu1_ss_sys_node_pchnl_ctrl_porting_gpu1_ss_sys_node_pchnl_ctrl_porting_pdeny(gpu1_ss_pdeny),
        .usb_dp_ss_node_timeout_val_porting(usb_dp_ss_timeout_val),
        .usb_dp_ss_node_usb_dp_ss_sys_node_s_chan_porting_usb_dp_ss_sys_node_s_chan_porting_s_atvalid(usb_dp_ss_s_atvalid),
        .usb_dp_ss_node_usb_dp_ss_sys_node_s_chan_porting_usb_dp_ss_sys_node_s_chan_porting_s_atready(usb_dp_ss_s_atready),
        .usb_dp_ss_node_usb_dp_ss_sys_node_s_chan_porting_usb_dp_ss_sys_node_s_chan_porting_s_atdata(usb_dp_ss_s_atdata),
        .usb_dp_ss_node_usb_dp_ss_sys_node_s_chan_porting_usb_dp_ss_sys_node_s_chan_porting_s_atid(usb_dp_ss_s_atid),
        .usb_dp_ss_node_usb_dp_ss_sys_node_s_chan_porting_usb_dp_ss_sys_node_s_chan_porting_s_atbytes(usb_dp_ss_s_atbytes),
        .usb_dp_ss_node_usb_dp_ss_sys_node_s_chan_porting_usb_dp_ss_sys_node_s_chan_porting_s_afvalid(usb_dp_ss_s_afvalid),
        .usb_dp_ss_node_usb_dp_ss_sys_node_s_chan_porting_usb_dp_ss_sys_node_s_chan_porting_s_afready(usb_dp_ss_s_afready),
        .usb_dp_ss_node_usb_dp_ss_sys_node_s_chan_porting_usb_dp_ss_sys_node_s_chan_porting_s_syncreq(usb_dp_ss_s_syncreq),
        .usb_dp_ss_node_usb_dp_ss_sys_node_s_chan_porting_usb_dp_ss_sys_node_s_chan_porting_s_atwakeup(usb_dp_ss_s_atwakeup),
        .usb_dp_ss_node_usb_dp_ss_sys_node_pchnl_ctrl_porting_usb_dp_ss_sys_node_pchnl_ctrl_porting_preq(usb_dp_ss_preq),
        .usb_dp_ss_node_usb_dp_ss_sys_node_pchnl_ctrl_porting_usb_dp_ss_sys_node_pchnl_ctrl_porting_pstate(usb_dp_ss_pstate),
        .usb_dp_ss_node_usb_dp_ss_sys_node_pchnl_ctrl_porting_usb_dp_ss_sys_node_pchnl_ctrl_porting_pactive(usb_dp_ss_pactive),
        .usb_dp_ss_node_usb_dp_ss_sys_node_pchnl_ctrl_porting_usb_dp_ss_sys_node_pchnl_ctrl_porting_paccept(usb_dp_ss_paccept),
        .usb_dp_ss_node_usb_dp_ss_sys_node_pchnl_ctrl_porting_usb_dp_ss_sys_node_pchnl_ctrl_porting_pdeny(usb_dp_ss_pdeny),
        .display_ss_node_timeout_val_porting(display_ss_timeout_val),
        .display_ss_node_display_ss_sys_node_s_chan_porting_display_ss_sys_node_s_chan_porting_s_atvalid(display_ss_s_atvalid),
        .display_ss_node_display_ss_sys_node_s_chan_porting_display_ss_sys_node_s_chan_porting_s_atready(display_ss_s_atready),
        .display_ss_node_display_ss_sys_node_s_chan_porting_display_ss_sys_node_s_chan_porting_s_atdata(display_ss_s_atdata),
        .display_ss_node_display_ss_sys_node_s_chan_porting_display_ss_sys_node_s_chan_porting_s_atid(display_ss_s_atid),
        .display_ss_node_display_ss_sys_node_s_chan_porting_display_ss_sys_node_s_chan_porting_s_atbytes(display_ss_s_atbytes),
        .display_ss_node_display_ss_sys_node_s_chan_porting_display_ss_sys_node_s_chan_porting_s_afvalid(display_ss_s_afvalid),
        .display_ss_node_display_ss_sys_node_s_chan_porting_display_ss_sys_node_s_chan_porting_s_afready(display_ss_s_afready),
        .display_ss_node_display_ss_sys_node_s_chan_porting_display_ss_sys_node_s_chan_porting_s_syncreq(display_ss_s_syncreq),
        .display_ss_node_display_ss_sys_node_s_chan_porting_display_ss_sys_node_s_chan_porting_s_atwakeup(display_ss_s_atwakeup),
        .display_ss_node_display_ss_sys_node_pchnl_ctrl_porting_display_ss_sys_node_pchnl_ctrl_porting_preq(display_ss_preq),
        .display_ss_node_display_ss_sys_node_pchnl_ctrl_porting_display_ss_sys_node_pchnl_ctrl_porting_pstate(display_ss_pstate),
        .display_ss_node_display_ss_sys_node_pchnl_ctrl_porting_display_ss_sys_node_pchnl_ctrl_porting_pactive(display_ss_pactive),
        .display_ss_node_display_ss_sys_node_pchnl_ctrl_porting_display_ss_sys_node_pchnl_ctrl_porting_paccept(display_ss_paccept),
        .display_ss_node_display_ss_sys_node_pchnl_ctrl_porting_display_ss_sys_node_pchnl_ctrl_porting_pdeny(display_ss_pdeny),
        .aon_ss_node_timeout_val_porting(aon_ss_timeout_val),
        .aon_ss_node_aon_ss_sys_node_s_chan_porting_aon_ss_sys_node_s_chan_porting_s_atvalid(aon_ss_s_atvalid),
        .aon_ss_node_aon_ss_sys_node_s_chan_porting_aon_ss_sys_node_s_chan_porting_s_atready(aon_ss_s_atready),
        .aon_ss_node_aon_ss_sys_node_s_chan_porting_aon_ss_sys_node_s_chan_porting_s_atdata(aon_ss_s_atdata),
        .aon_ss_node_aon_ss_sys_node_s_chan_porting_aon_ss_sys_node_s_chan_porting_s_atid(aon_ss_s_atid),
        .aon_ss_node_aon_ss_sys_node_s_chan_porting_aon_ss_sys_node_s_chan_porting_s_atbytes(aon_ss_s_atbytes),
        .aon_ss_node_aon_ss_sys_node_s_chan_porting_aon_ss_sys_node_s_chan_porting_s_afvalid(aon_ss_s_afvalid),
        .aon_ss_node_aon_ss_sys_node_s_chan_porting_aon_ss_sys_node_s_chan_porting_s_afready(aon_ss_s_afready),
        .aon_ss_node_aon_ss_sys_node_s_chan_porting_aon_ss_sys_node_s_chan_porting_s_syncreq(aon_ss_s_syncreq),
        .aon_ss_node_aon_ss_sys_node_s_chan_porting_aon_ss_sys_node_s_chan_porting_s_atwakeup(aon_ss_s_atwakeup),
        .aon_ss_node_aon_ss_sys_node_pchnl_ctrl_porting_aon_ss_sys_node_pchnl_ctrl_porting_preq(aon_ss_preq),
        .aon_ss_node_aon_ss_sys_node_pchnl_ctrl_porting_aon_ss_sys_node_pchnl_ctrl_porting_pstate(aon_ss_pstate),
        .aon_ss_node_aon_ss_sys_node_pchnl_ctrl_porting_aon_ss_sys_node_pchnl_ctrl_porting_pactive(aon_ss_pactive),
        .aon_ss_node_aon_ss_sys_node_pchnl_ctrl_porting_aon_ss_sys_node_pchnl_ctrl_porting_paccept(aon_ss_paccept),
        .aon_ss_node_aon_ss_sys_node_pchnl_ctrl_porting_aon_ss_sys_node_pchnl_ctrl_porting_pdeny(aon_ss_pdeny),
        .gpu_ss0_node_timeout_val_porting(gpu_ss0_timeout_val),
        .gpu_ss0_node_gpu_ss0_sys_node_s_chan_porting_gpu_ss0_sys_node_s_chan_porting_s_atvalid(gpu_ss0_s_atvalid),
        .gpu_ss0_node_gpu_ss0_sys_node_s_chan_porting_gpu_ss0_sys_node_s_chan_porting_s_atready(gpu_ss0_s_atready),
        .gpu_ss0_node_gpu_ss0_sys_node_s_chan_porting_gpu_ss0_sys_node_s_chan_porting_s_atdata(gpu_ss0_s_atdata),
        .gpu_ss0_node_gpu_ss0_sys_node_s_chan_porting_gpu_ss0_sys_node_s_chan_porting_s_atid(gpu_ss0_s_atid),
        .gpu_ss0_node_gpu_ss0_sys_node_s_chan_porting_gpu_ss0_sys_node_s_chan_porting_s_atbytes(gpu_ss0_s_atbytes),
        .gpu_ss0_node_gpu_ss0_sys_node_s_chan_porting_gpu_ss0_sys_node_s_chan_porting_s_afvalid(gpu_ss0_s_afvalid),
        .gpu_ss0_node_gpu_ss0_sys_node_s_chan_porting_gpu_ss0_sys_node_s_chan_porting_s_afready(gpu_ss0_s_afready),
        .gpu_ss0_node_gpu_ss0_sys_node_s_chan_porting_gpu_ss0_sys_node_s_chan_porting_s_syncreq(gpu_ss0_s_syncreq),
        .gpu_ss0_node_gpu_ss0_sys_node_s_chan_porting_gpu_ss0_sys_node_s_chan_porting_s_atwakeup(gpu_ss0_s_atwakeup),
        .gpu_ss0_node_gpu_ss0_sys_node_pchnl_ctrl_porting_gpu_ss0_sys_node_pchnl_ctrl_porting_preq(gpu_ss0_preq),
        .gpu_ss0_node_gpu_ss0_sys_node_pchnl_ctrl_porting_gpu_ss0_sys_node_pchnl_ctrl_porting_pstate(gpu_ss0_pstate),
        .gpu_ss0_node_gpu_ss0_sys_node_pchnl_ctrl_porting_gpu_ss0_sys_node_pchnl_ctrl_porting_pactive(gpu_ss0_pactive),
        .gpu_ss0_node_gpu_ss0_sys_node_pchnl_ctrl_porting_gpu_ss0_sys_node_pchnl_ctrl_porting_paccept(gpu_ss0_paccept),
        .gpu_ss0_node_gpu_ss0_sys_node_pchnl_ctrl_porting_gpu_ss0_sys_node_pchnl_ctrl_porting_pdeny(gpu_ss0_pdeny),
        .cpu_ss_node_timeout_val_porting(cpu_ss_timeout_val),
        .cpu_ss_node_cpu_ss_sys_node_s_chan_porting_cpu_ss_sys_node_s_chan_porting_s_atvalid(cpu_ss_s_atvalid),
        .cpu_ss_node_cpu_ss_sys_node_s_chan_porting_cpu_ss_sys_node_s_chan_porting_s_atready(cpu_ss_s_atready),
        .cpu_ss_node_cpu_ss_sys_node_s_chan_porting_cpu_ss_sys_node_s_chan_porting_s_atdata(cpu_ss_s_atdata),
        .cpu_ss_node_cpu_ss_sys_node_s_chan_porting_cpu_ss_sys_node_s_chan_porting_s_atid(cpu_ss_s_atid),
        .cpu_ss_node_cpu_ss_sys_node_s_chan_porting_cpu_ss_sys_node_s_chan_porting_s_atbytes(cpu_ss_s_atbytes),
        .cpu_ss_node_cpu_ss_sys_node_s_chan_porting_cpu_ss_sys_node_s_chan_porting_s_afvalid(cpu_ss_s_afvalid),
        .cpu_ss_node_cpu_ss_sys_node_s_chan_porting_cpu_ss_sys_node_s_chan_porting_s_afready(cpu_ss_s_afready),
        .cpu_ss_node_cpu_ss_sys_node_s_chan_porting_cpu_ss_sys_node_s_chan_porting_s_syncreq(cpu_ss_s_syncreq),
        .cpu_ss_node_cpu_ss_sys_node_s_chan_porting_cpu_ss_sys_node_s_chan_porting_s_atwakeup(cpu_ss_s_atwakeup),
        .cpu_ss_node_cpu_ss_sys_node_pchnl_ctrl_porting_cpu_ss_sys_node_pchnl_ctrl_porting_preq(cpu_ss_preq),
        .cpu_ss_node_cpu_ss_sys_node_pchnl_ctrl_porting_cpu_ss_sys_node_pchnl_ctrl_porting_pstate(cpu_ss_pstate),
        .cpu_ss_node_cpu_ss_sys_node_pchnl_ctrl_porting_cpu_ss_sys_node_pchnl_ctrl_porting_pactive(cpu_ss_pactive),
        .cpu_ss_node_cpu_ss_sys_node_pchnl_ctrl_porting_cpu_ss_sys_node_pchnl_ctrl_porting_paccept(cpu_ss_paccept),
        .cpu_ss_node_cpu_ss_sys_node_pchnl_ctrl_porting_cpu_ss_sys_node_pchnl_ctrl_porting_pdeny(cpu_ss_pdeny),
        .mcu_ss_node_timeout_val_porting(mcu_ss_timeout_val),
        .mcu_ss_node_mcu_ss_sys_node_s_chan_porting_mcu_ss_sys_node_s_chan_porting_s_atvalid(mcu_ss_s_atvalid),
        .mcu_ss_node_mcu_ss_sys_node_s_chan_porting_mcu_ss_sys_node_s_chan_porting_s_atready(mcu_ss_s_atready),
        .mcu_ss_node_mcu_ss_sys_node_s_chan_porting_mcu_ss_sys_node_s_chan_porting_s_atdata(mcu_ss_s_atdata),
        .mcu_ss_node_mcu_ss_sys_node_s_chan_porting_mcu_ss_sys_node_s_chan_porting_s_atid(mcu_ss_s_atid),
        .mcu_ss_node_mcu_ss_sys_node_s_chan_porting_mcu_ss_sys_node_s_chan_porting_s_atbytes(mcu_ss_s_atbytes),
        .mcu_ss_node_mcu_ss_sys_node_s_chan_porting_mcu_ss_sys_node_s_chan_porting_s_afvalid(mcu_ss_s_afvalid),
        .mcu_ss_node_mcu_ss_sys_node_s_chan_porting_mcu_ss_sys_node_s_chan_porting_s_afready(mcu_ss_s_afready),
        .mcu_ss_node_mcu_ss_sys_node_s_chan_porting_mcu_ss_sys_node_s_chan_porting_s_syncreq(mcu_ss_s_syncreq),
        .mcu_ss_node_mcu_ss_sys_node_s_chan_porting_mcu_ss_sys_node_s_chan_porting_s_atwakeup(mcu_ss_s_atwakeup),
        .mcu_ss_node_mcu_ss_sys_node_pchnl_ctrl_porting_mcu_ss_sys_node_pchnl_ctrl_porting_preq(mcu_ss_preq),
        .mcu_ss_node_mcu_ss_sys_node_pchnl_ctrl_porting_mcu_ss_sys_node_pchnl_ctrl_porting_pstate(mcu_ss_pstate),
        .mcu_ss_node_mcu_ss_sys_node_pchnl_ctrl_porting_mcu_ss_sys_node_pchnl_ctrl_porting_pactive(mcu_ss_pactive),
        .mcu_ss_node_mcu_ss_sys_node_pchnl_ctrl_porting_mcu_ss_sys_node_pchnl_ctrl_porting_paccept(mcu_ss_paccept),
        .mcu_ss_node_mcu_ss_sys_node_pchnl_ctrl_porting_mcu_ss_sys_node_pchnl_ctrl_porting_pdeny(mcu_ss_pdeny),
        .peri_ss_node_timeout_val_porting(peri_ss_timeout_val),
        .peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_atvalid(peri_ss_m_atvalid),
        .peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_atready(peri_ss_m_atready),
        .peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_atdata(peri_ss_m_atdata),
        .peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_atid(peri_ss_m_atid),
        .peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_atbytes(peri_ss_m_atbytes),
        .peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_afvalid(peri_ss_m_afvalid),
        .peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_afready(peri_ss_m_afready),
        .peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_syncreq(peri_ss_m_syncreq),
        .peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_atwakeup(peri_ss_m_atwakeup),
        .peri_ss_node_peri_ss_sys_node_pchnl_ctrl_porting_peri_ss_sys_node_pchnl_ctrl_porting_preq(peri_ss_preq),
        .peri_ss_node_peri_ss_sys_node_pchnl_ctrl_porting_peri_ss_sys_node_pchnl_ctrl_porting_pstate(peri_ss_pstate),
        .peri_ss_node_peri_ss_sys_node_pchnl_ctrl_porting_peri_ss_sys_node_pchnl_ctrl_porting_pactive(peri_ss_pactive),
        .peri_ss_node_peri_ss_sys_node_pchnl_ctrl_porting_peri_ss_sys_node_pchnl_ctrl_porting_paccept(peri_ss_paccept),
        .peri_ss_node_peri_ss_sys_node_pchnl_ctrl_porting_peri_ss_sys_node_pchnl_ctrl_porting_pdeny(peri_ss_pdeny)
    );

    // Offset clock phases to avoid artificial alignment
    initial begin #0.1; forever #5 clk_dsp_ss0_sys = ~clk_dsp_ss0_sys; end
    initial begin #0.4; forever #5 clk_dsp_ss1_sys = ~clk_dsp_ss1_sys; end
    initial begin #0.7; forever #5 clk_dsp_ss2_sys = ~clk_dsp_ss2_sys; end
    initial begin #1.0; forever #5 clk_dsp_ss3_sys = ~clk_dsp_ss3_sys; end
    initial begin #1.3; forever #5 clk_dsp_ss4_sys = ~clk_dsp_ss4_sys; end
    initial begin #1.6; forever #5 clk_dsp_ss5_sys = ~clk_dsp_ss5_sys; end
    initial begin #0.2; forever #5 clk_camera_ss_sys = ~clk_camera_ss_sys; end
    initial begin #0.5; forever #5 clk_mipi_ss_sys = ~clk_mipi_ss_sys; end
    initial begin #0.8; forever #5 clk_gpu1_ss_sys = ~clk_gpu1_ss_sys; end
    initial begin #1.1; forever #5 clk_usb_dp_ss_sys = ~clk_usb_dp_ss_sys; end
    initial begin #1.4; forever #5 clk_display_ss_sys = ~clk_display_ss_sys; end
    initial begin #1.7; forever #5 clk_aon_ss_sys = ~clk_aon_ss_sys; end
    initial begin #0.3; forever #5 clk_gpu_ss0_sys = ~clk_gpu_ss0_sys; end
    initial begin #0.9; forever #5 clk_cpu_ss_sys = ~clk_cpu_ss_sys; end
    initial begin #1.5; forever #5 clk_mcu_ss_sys = ~clk_mcu_ss_sys; end
    initial begin #0.6; forever #5 clk_peri_ss_sys = ~clk_peri_ss_sys; end
    initial begin #0.0; forever #2 clk_noc = ~clk_noc; end

    initial begin
        rst_dsp_ss0_sys_n = 1'b0;
        rst_dsp_ss1_sys_n = 1'b0;
        rst_dsp_ss2_sys_n = 1'b0;
        rst_dsp_ss3_sys_n = 1'b0;
        rst_dsp_ss4_sys_n = 1'b0;
        rst_dsp_ss5_sys_n = 1'b0;
        rst_camera_ss_sys_n = 1'b0;
        rst_mipi_ss_sys_n = 1'b0;
        rst_gpu1_ss_sys_n = 1'b0;
        rst_usb_dp_ss_sys_n = 1'b0;
        rst_display_ss_sys_n = 1'b0;
        rst_aon_ss_sys_n = 1'b0;
        rst_gpu_ss0_sys_n = 1'b0;
        rst_cpu_ss_sys_n = 1'b0;
        rst_mcu_ss_sys_n = 1'b0;
        rst_peri_ss_sys_n = 1'b0;
        rst_noc_n = 1'b0;
        #100;
        rst_dsp_ss0_sys_n = 1'b1;
        rst_dsp_ss1_sys_n = 1'b1;
        rst_dsp_ss2_sys_n = 1'b1;
        rst_dsp_ss3_sys_n = 1'b1;
        rst_dsp_ss4_sys_n = 1'b1;
        rst_dsp_ss5_sys_n = 1'b1;
        rst_camera_ss_sys_n = 1'b1;
        rst_mipi_ss_sys_n = 1'b1;
        rst_gpu1_ss_sys_n = 1'b1;
        rst_usb_dp_ss_sys_n = 1'b1;
        rst_display_ss_sys_n = 1'b1;
        rst_aon_ss_sys_n = 1'b1;
        rst_gpu_ss0_sys_n = 1'b1;
        rst_cpu_ss_sys_n = 1'b1;
        rst_mcu_ss_sys_n = 1'b1;
        rst_peri_ss_sys_n = 1'b1;
        rst_noc_n = 1'b1;
    end

    task automatic send_trace(
        input string src_name,
        input logic [6:0] tid,
        input logic [127:0] data,
        const ref logic clk,
        ref logic s_atvalid,
        const ref logic s_atready,
        ref logic [127:0] s_atdata,
        ref logic [6:0] s_atid,
        ref logic [3:0] s_atbytes,
        ref logic s_atwakeup
    );
        @(negedge clk);
        s_atvalid  = 1'b1;
        s_atdata   = data;
        s_atid     = tid;
        s_atbytes  = 4'd8;
        s_atwakeup = 1'b0;
        do @(posedge clk); while (!s_atready);
        @(negedge clk);
        s_atvalid  = 1'b0;
        s_atdata   = '0;
        s_atid     = '0;
        s_atbytes  = '0;
        s_atwakeup = 1'b0;
        $display("[%0t] %s: sent tid=%0d data=0x%0h", $time, src_name, tid, data);
    endtask

    task automatic wait_power_on(
        input string node_name,
        const ref logic clk,
        const ref logic [1:0] pactive,
        const ref logic paccept,
        const ref logic pdeny
    );
        integer timeout_count;
        timeout_count = 0;
        while ((paccept != 1'b1) && (pdeny != 1'b1) && (pactive != 2'd1) && (timeout_count < 10000)) begin
            @(posedge clk);
            timeout_count = timeout_count + 1;
        end

        if (pdeny == 1'b1 || ((paccept != 1'b1) && (pactive != 2'd1) && (timeout_count >= 10000))) begin
            $fatal(1, "%s power-on failed: pactive=%0d paccept=%0b pdeny=%0b timeout=%0d", node_name, pactive, paccept, pdeny, timeout_count);
        end
        $display("[%0t] POWER_ON OK: %s pactive=%0d paccept=%0b cycles=%0d", $time, node_name, pactive, paccept, timeout_count);
    endtask

    always @(posedge clk_dsp_ss0_sys) begin
        if (!rst_dsp_ss0_sys_n) begin
            dbg_dsp0_afifo_window = 0;
            dbg_dsp0_finish_window = 0;
            dbg_dsp0_finish_stg2_window = 0;
        end else if (dut.dsp_ss0_node.sys_side.u_lp_iniu_afifo_slv_bridge.mst_stg1_req) begin
            dbg_dsp0_afifo_window = 8;
            if ((stop_after_dsp0_afifo_cycles > 0) && (dbg_dsp0_finish_window == 0)) begin
                dbg_dsp0_finish_window = stop_after_dsp0_afifo_cycles;
            end
        end else if (dut.dsp_ss0_node.sys_side.u_lp_iniu_afifo_slv_bridge.mst_stg2_req) begin
            dbg_dsp0_afifo_window = 8;
        end else if (dbg_dsp0_afifo_window > 0) begin
            dbg_dsp0_afifo_window = dbg_dsp0_afifo_window - 1;
        end

        if (rst_dsp_ss0_sys_n && (dbg_dsp0_finish_window > 0)) begin
            dbg_dsp0_finish_window = dbg_dsp0_finish_window - 1;
            if (dbg_dsp0_finish_window == 1) begin
                $display("[%0t] DBG DSP0 FINISH after AFIFO window", $time);
                $finish;
            end
        end

        if (rst_dsp_ss0_sys_n && dut.dsp_ss0_node.sys_side.u_lp_iniu_afifo_slv_bridge.mst_stg2_req &&
            (stop_after_dsp0_afifo_stg2_cycles > 0) && (dbg_dsp0_finish_stg2_window == 0)) begin
            dbg_dsp0_finish_stg2_window = stop_after_dsp0_afifo_stg2_cycles;
        end
        if (rst_dsp_ss0_sys_n && (dbg_dsp0_finish_stg2_window > 0)) begin
            dbg_dsp0_finish_stg2_window = dbg_dsp0_finish_stg2_window - 1;
            if (dbg_dsp0_finish_stg2_window == 1) begin
                $display("[%0t] DBG DSP0 FINISH after AFIFO STG2 window", $time);
                $display("[%0t] DBG DSP0 STG2 FINAL: pactive=0x%0h paccept=%0b pdeny=%0b abs_r2=%0b abs_a2=%0b abs_cl=%0b ack2_ns=%0b/%0b ack3=%0b/%0b abm_r2=%0b abm_a2=%0b abm_cl=%0b",
                    $time,
                    dsp_ss0_pactive,
                    dsp_ss0_paccept,
                    dsp_ss0_pdeny,
                    dut.dsp_ss0_node.sys_side.u_lp_iniu_afifo_slv_bridge.mst_stg2_req,
                    dut.dsp_ss0_node.sys_side.u_lp_iniu_afifo_slv_bridge.mst_stg2_ack,
                    dut.dsp_ss0_node.sys_side.afifo_slv_clear,
                    dut.dsp_ss0_node.sys_side.lp_nest_sub_tx_req.stg2_ack_or,
                    dut.dsp_ss0_node.sys_side.lp_nest_sub_tx_req.stg2_ack_and,
                    dut.dsp_ss0_node.sys_side.lp_afifo_slv_tx_req.stg2_ack_or,
                    dut.dsp_ss0_node.sys_side.lp_afifo_slv_tx_req.stg2_ack_and,
                    dut.dsp_ss0_node.top_side.top_side.u_lp_iniu_afifo_mst_bridge.mst_stg2_req,
                    dut.dsp_ss0_node.top_side.top_side.u_lp_iniu_afifo_mst_bridge.mst_stg2_ack,
                    dut.dsp_ss0_node.top_side.top_side.afifo_mst_clear);
                $finish;
            end
        end

        if (rst_dsp_ss0_sys_n &&
            (dbg_dsp0_sys_prints < 60) &&
            (dsp_ss0_s_atvalid ||
             dut.dsp_ss0_node.sys_side.u_niu_atb_slv.atb_packer_vld ||
             !dut.dsp_ss0_node.sys_side.u_niu_atb_slv.atb_packer_rdy ||
             dut.dsp_ss0_node.sys_side.afifo_slv_stall ||
             dut.dsp_ss0_node.sys_side.sync_buf_stall ||
             dut.dsp_ss0_node.sys_side.partial_reset ||
             (dbg_dsp0_afifo_window > 0))) begin
            dbg_dsp0_sys_prints = dbg_dsp0_sys_prints + 1;
            $display("[%0t] DBG DSP0 SYS2: s_v=%0b s_r=%0b pack_v=%0b pack_r=%0b afifo_stall=%0b sync_stall=%0b partial_reset=%0b pactive=0x%0h paccept=%0b pdeny=%0b p_fsm=%0d preq=%0b preq_rise=%0b trans=%0b dir_up=%0b tx1=%0b rx1=%0b afifo_req=%0b afifo_ack=%0b",
                $time,
                dsp_ss0_s_atvalid,
                dsp_ss0_s_atready,
                dut.dsp_ss0_node.sys_side.u_niu_atb_slv.atb_packer_vld,
                dut.dsp_ss0_node.sys_side.u_niu_atb_slv.atb_packer_rdy,
                dut.dsp_ss0_node.sys_side.afifo_slv_stall,
                dut.dsp_ss0_node.sys_side.sync_buf_stall,
                dut.dsp_ss0_node.sys_side.partial_reset,
                dsp_ss0_pactive,
                dsp_ss0_paccept,
                dsp_ss0_pdeny,
                dut.dsp_ss0_node.sys_side.u_lp_iniu.u_pchn_fsm.fsm_cs,
                dsp_ss0_preq,
                dut.dsp_ss0_node.sys_side.u_lp_iniu.u_pchn_fsm.preq_rise,
                dut.dsp_ss0_node.sys_side.u_lp_iniu.u_pchn_fsm.transition_in_progress,
                dut.dsp_ss0_node.sys_side.u_lp_iniu.u_pchn_fsm.dir_up,
                dut.dsp_ss0_node.sys_side.u_lp_iniu.device_tx_stg1_req,
                dut.dsp_ss0_node.sys_side.u_lp_iniu.device_rx_stg1_req,
                dut.dsp_ss0_node.sys_side.u_lp_iniu_afifo_slv_bridge.mst_stg1_req,
                dut.dsp_ss0_node.sys_side.u_lp_iniu_afifo_slv_bridge.mst_stg1_ack);
            $display("[%0t] DBG DSP0 LP2: nmrx=%0b/%0b nmtx=%0b/%0b nstx=%0b/%0b airx=%0b/%0b fl=%0b/%0b sy=%0b/%0b lw=%0b/%0b",
                $time,
                dut.dsp_ss0_node.sys_side.lp_nest_main_rx_req.stg1_req_or,
                dut.dsp_ss0_node.sys_side.lp_nest_main_rx_req.stg1_req_and,
                dut.dsp_ss0_node.sys_side.lp_nest_main_tx_req.stg1_req_or,
                dut.dsp_ss0_node.sys_side.lp_nest_main_tx_req.stg1_req_and,
                dut.dsp_ss0_node.sys_side.lp_nest_sub_tx_req.stg1_req_or,
                dut.dsp_ss0_node.sys_side.lp_nest_sub_tx_req.stg1_req_and,
                dut.dsp_ss0_node.sys_side.lp_afifo_slv_internal_rx_req.stg1_req_or,
                dut.dsp_ss0_node.sys_side.lp_afifo_slv_internal_rx_req.stg1_req_and,
                dut.dsp_ss0_node.sys_side.lp_flush_tx_req.stg1_req_or,
                dut.dsp_ss0_node.sys_side.lp_flush_tx_req.stg1_req_and,
                dut.dsp_ss0_node.sys_side.lp_sync_buf_tx_req.stg1_req_or,
                dut.dsp_ss0_node.sys_side.lp_sync_buf_tx_req.stg1_req_and,
                dut.dsp_ss0_node.sys_side.lp_lwnoc_tx_req.stg1_req_or,
                dut.dsp_ss0_node.sys_side.lp_lwnoc_tx_req.stg1_req_and);
            $display("[%0t] DBG DSP0 ACK2: iniu=%0b/%0b nm=%0b/%0b lw=%0b/%0b ns=%0b/%0b st=%0d",
                $time,
                dut.dsp_ss0_node.sys_side.lp_iniu_rx_req.stg1_ack_and,
                dut.dsp_ss0_node.sys_side.lp_iniu_tx_req.stg1_ack_and,
                dut.dsp_ss0_node.sys_side.lp_nest_main_rx_req.stg1_ack_and,
                dut.dsp_ss0_node.sys_side.lp_nest_main_tx_req.stg1_ack_and,
                dut.dsp_ss0_node.sys_side.lp_lwnoc_rx_req.stg1_ack_and,
                dut.dsp_ss0_node.sys_side.lp_lwnoc_tx_req.stg1_ack_and,
                dut.dsp_ss0_node.sys_side.lp_nest_sub_rx_req.stg1_ack_and,
                dut.dsp_ss0_node.sys_side.lp_nest_sub_tx_req.stg1_ack_and,
                dut.dsp_ss0_node.sys_side.u_lp_nest.lp_state_sub_domain);
            $display("[%0t] DBG DSP0 ACK2S: iniu=%0b/%0b nm=%0b/%0b lw=%0b/%0b ns=%0b/%0b done=%0b",
                $time,
                dut.dsp_ss0_node.sys_side.lp_iniu_rx_req.stg2_ack_and,
                dut.dsp_ss0_node.sys_side.lp_iniu_tx_req.stg2_ack_and,
                dut.dsp_ss0_node.sys_side.lp_nest_main_rx_req.stg2_ack_and,
                dut.dsp_ss0_node.sys_side.lp_nest_main_tx_req.stg2_ack_and,
                dut.dsp_ss0_node.sys_side.lp_lwnoc_rx_req.stg2_ack_and,
                dut.dsp_ss0_node.sys_side.lp_lwnoc_tx_req.stg2_ack_and,
                dut.dsp_ss0_node.sys_side.lp_nest_sub_rx_req.stg2_ack_and,
                dut.dsp_ss0_node.sys_side.lp_nest_sub_tx_req.stg2_ack_and,
                dut.dsp_ss0_node.sys_side.u_lp_iniu.stg2_run_done);
            $display("[%0t] DBG DSP0 ACK3: ai=%0b/%0b ao=%0b/%0b",
                $time,
                dut.dsp_ss0_node.sys_side.lp_afifo_slv_internal_rx_req.stg1_ack_and,
                dut.dsp_ss0_node.sys_side.lp_afifo_slv_internal_tx_req.stg1_ack_and,
                dut.dsp_ss0_node.sys_side.lp_afifo_slv_rx_req.stg1_ack_and,
                dut.dsp_ss0_node.sys_side.lp_afifo_slv_tx_req.stg1_ack_and);
            $display("[%0t] DBG DSP0 ABS: r1=%0b a1=%0b r2=%0b a2=%0b ti=%0b fz=%0b st=%0b cl=%0b",
                $time,
                dut.dsp_ss0_node.sys_side.u_lp_iniu_afifo_slv_bridge.mst_stg1_req,
                dut.dsp_ss0_node.sys_side.u_lp_iniu_afifo_slv_bridge.mst_stg1_ack,
                dut.dsp_ss0_node.sys_side.u_lp_iniu_afifo_slv_bridge.mst_stg2_req,
                dut.dsp_ss0_node.sys_side.u_lp_iniu_afifo_slv_bridge.mst_stg2_ack,
                dut.dsp_ss0_node.sys_side.afifo_slv_full_zero,
                dut.dsp_ss0_node.sys_side.afifo_slv_full_zero,
                dut.dsp_ss0_node.sys_side.afifo_slv_stall,
                dut.dsp_ss0_node.sys_side.afifo_slv_clear);
            $display("[%0t] DBG DSP0 ABM: r1=%0b a1=%0b r2=%0b a2=%0b ti=%0b fz=%0b st=%0b cl=%0b",
                $time,
                dut.dsp_ss0_node.top_side.top_side.u_lp_iniu_afifo_mst_bridge.mst_stg1_req,
                dut.dsp_ss0_node.top_side.top_side.u_lp_iniu_afifo_mst_bridge.mst_stg1_ack,
                dut.dsp_ss0_node.top_side.top_side.u_lp_iniu_afifo_mst_bridge.mst_stg2_req,
                dut.dsp_ss0_node.top_side.top_side.u_lp_iniu_afifo_mst_bridge.mst_stg2_ack,
                dut.dsp_ss0_node.top_side.top_side.afifo_mst_read_idle,
                dut.dsp_ss0_node.top_side.top_side.afifo_mst_full_zero,
                dut.dsp_ss0_node.top_side.top_side.afifo_mst_stall,
                dut.dsp_ss0_node.top_side.top_side.afifo_mst_clear);
        end
    end

    always @(posedge clk_noc) begin
        if (rst_noc_n &&
            (dbg_noc_prints < 40) &&
            (dut.gpu0_node_TO_left_top_funnel_SIG_gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atvalid ||
             dut.cpu_node_TO_left_top_funnel_SIG_cpu_ss_top_wrap_m_chan_porting_m_chan_m_atvalid ||
             dut.right_dsp_funnel_TO_left_top_funnel_SIG_m_atvalid ||
             dut.top_media_funnel_TO_left_top_funnel_SIG_m_atvalid ||
             dut.mcu_node_TO_left_top_funnel_SIG_mcu_ss_top_wrap_m_chan_porting_m_chan_m_atvalid ||
             dut.left_top_funnel_TO_peri_node_SIG_m_atvalid)) begin
            dbg_noc_prints = dbg_noc_prints + 1;
            $display("[%0t] DBG NOC: gpu0_v=%0b cpu_v=%0b dsp_v=%0b media_v=%0b mcu_v=%0b -> peri_v=%0b peri_r=%0b peri_id=%0d",
                $time,
                dut.gpu0_node_TO_left_top_funnel_SIG_gpu_ss0_top_wrap_m_chan_porting_m_chan_m_atvalid,
                dut.cpu_node_TO_left_top_funnel_SIG_cpu_ss_top_wrap_m_chan_porting_m_chan_m_atvalid,
                dut.right_dsp_funnel_TO_left_top_funnel_SIG_m_atvalid,
                dut.top_media_funnel_TO_left_top_funnel_SIG_m_atvalid,
                dut.mcu_node_TO_left_top_funnel_SIG_mcu_ss_top_wrap_m_chan_porting_m_chan_m_atvalid,
                dut.left_top_funnel_TO_peri_node_SIG_m_atvalid,
                dut.peri_node_TO_left_top_funnel_SIG_peri_ss_top_wrap_s_chan_out_porting_s_chan_out_s_atready,
                dut.left_top_funnel_TO_peri_node_SIG_m_atid);
        end

            if (rst_noc_n &&
                (dbg_dsp0_prints < 40) &&
                ((dut.dsp_ss0_node.sys_side_TO_top_side_SIG_wptr_async != 16'h0) ||
                 dut.dsp_ss0_node.dsp_ss0_top_wrap_m_chan_porting_m_chan_m_atvalid ||
                 dut.dsp_ss0_node.top_side_TO_sys_side_SIG_syncreq_level_syncreq_level ||
                 dut.dsp_ss0_node.top_side_TO_sys_side_SIG_flush_req_level_flush_req_level)) begin
                dbg_dsp0_prints = dbg_dsp0_prints + 1;
                $display("[%0t] DBG DSP0 NODE: wptr=0x%0h rptr_async=0x%0h rptr_sync=0x%0h lp_tx=0x%0h syncreq_lvl=%0b flush_req_lvl=%0b top_v=%0b top_r=%0b",
                $time,
                dut.dsp_ss0_node.sys_side_TO_top_side_SIG_wptr_async,
                dut.dsp_ss0_node.top_side_TO_sys_side_SIG_async_fifo_rptr_async,
                dut.dsp_ss0_node.top_side_TO_sys_side_SIG_async_fifo_rptr_sync,
                dut.dsp_ss0_node.sys_side_TO_top_side_SIG_lwnoc_tx_req,
                dut.dsp_ss0_node.top_side_TO_sys_side_SIG_syncreq_level_syncreq_level,
                dut.dsp_ss0_node.top_side_TO_sys_side_SIG_flush_req_level_flush_req_level,
                dut.dsp_ss0_node.dsp_ss0_top_wrap_m_chan_porting_m_chan_m_atvalid,
                dut.dsp_ss0_node.dsp_ss0_top_wrap_m_chan_porting_m_chan_m_atready);
                $display("[%0t] DBG DSP0 LPW: afifo_tx=0x%0h afifo_rx=0x%0h",
                $time,
                dut.dsp_ss0_node.sys_side_TO_top_side_SIG_afifo_slv_tx_req,
                dut.dsp_ss0_node.top_side_TO_sys_side_SIG_lp_afifo_tx_afifo_mst_tx_req);
            end
    end

    always @(posedge clk_peri_ss_sys) begin
        if (rst_peri_ss_sys_n &&
            (dbg_peri_prints < 20) &&
            dut.peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_atvalid) begin
            dbg_peri_prints = dbg_peri_prints + 1;
            $display("[%0t] DBG PERI SYS: v=%0b r=%0b id=%0d data=0x%0h",
                $time,
                dut.peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_atvalid,
                dut.peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_atready,
                dut.peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_atid,
                dut.peri_ss_node_peri_ss_sys_node_m_chan_porting_peri_ss_sys_node_m_chan_porting_m_atdata);
        end

        if (rst_peri_ss_sys_n && peri_ss_m_atvalid && peri_ss_m_atready) begin
            rx_count_total <= rx_count_total + 1;
            rx_count_by_tid[peri_ss_m_atid] <= rx_count_by_tid[peri_ss_m_atid] + 1;
            $display("[%0t] PERI SNK: tid=%0d data=0x%0h", $time, peri_ss_m_atid, peri_ss_m_atdata);
            if (expected_valid_by_tid[peri_ss_m_atid] && (peri_ss_m_atdata !== expected_data_by_tid[peri_ss_m_atid])) begin
                data_mismatch_seen <= 1'b1;
                $error("PERI SNK data mismatch for tid=%0d expected=0x%0h got=0x%0h", peri_ss_m_atid, expected_data_by_tid[peri_ss_m_atid], peri_ss_m_atdata);
            end
        end
    end

    initial begin : main_test
        integer idx;
        rx_count_total = 0;
        dbg_noc_prints = 0;
        dbg_peri_prints = 0;
        dbg_dsp0_prints = 0;
        dbg_dsp0_sys_prints = 0;
        dbg_dsp0_afifo_window = 0;
        flush_seen = '0;
        data_mismatch_seen = 1'b0;
        for (idx = 0; idx < 128; idx = idx + 1) begin
            rx_count_by_tid[idx] = 0;
            expected_data_by_tid[idx] = '0;
            expected_valid_by_tid[idx] = 1'b0;
        end

        #200;
        dsp_ss0_preq = 1'b1;
        dsp_ss1_preq = 1'b1;
        dsp_ss2_preq = 1'b1;
        dsp_ss3_preq = 1'b1;
        dsp_ss4_preq = 1'b1;
        dsp_ss5_preq = 1'b1;
        camera_ss_preq = 1'b1;
        mipi_ss_preq = 1'b1;
        gpu1_ss_preq = 1'b1;
        usb_dp_ss_preq = 1'b1;
        display_ss_preq = 1'b1;
        aon_ss_preq = 1'b1;
        gpu_ss0_preq = 1'b1;
        cpu_ss_preq = 1'b1;
        mcu_ss_preq = 1'b1;
        peri_ss_preq = 1'b1;
        wait_power_on("dsp_ss0", clk_dsp_ss0_sys, dsp_ss0_pactive, dsp_ss0_paccept, dsp_ss0_pdeny);
        wait_power_on("dsp_ss1", clk_dsp_ss1_sys, dsp_ss1_pactive, dsp_ss1_paccept, dsp_ss1_pdeny);
        wait_power_on("dsp_ss2", clk_dsp_ss2_sys, dsp_ss2_pactive, dsp_ss2_paccept, dsp_ss2_pdeny);
        wait_power_on("dsp_ss3", clk_dsp_ss3_sys, dsp_ss3_pactive, dsp_ss3_paccept, dsp_ss3_pdeny);
        wait_power_on("dsp_ss4", clk_dsp_ss4_sys, dsp_ss4_pactive, dsp_ss4_paccept, dsp_ss4_pdeny);
        wait_power_on("dsp_ss5", clk_dsp_ss5_sys, dsp_ss5_pactive, dsp_ss5_paccept, dsp_ss5_pdeny);
        wait_power_on("camera_ss", clk_camera_ss_sys, camera_ss_pactive, camera_ss_paccept, camera_ss_pdeny);
        wait_power_on("mipi_ss", clk_mipi_ss_sys, mipi_ss_pactive, mipi_ss_paccept, mipi_ss_pdeny);
        wait_power_on("gpu1_ss", clk_gpu1_ss_sys, gpu1_ss_pactive, gpu1_ss_paccept, gpu1_ss_pdeny);
        wait_power_on("usb_dp_ss", clk_usb_dp_ss_sys, usb_dp_ss_pactive, usb_dp_ss_paccept, usb_dp_ss_pdeny);
        wait_power_on("display_ss", clk_display_ss_sys, display_ss_pactive, display_ss_paccept, display_ss_pdeny);
        wait_power_on("aon_ss", clk_aon_ss_sys, aon_ss_pactive, aon_ss_paccept, aon_ss_pdeny);
        wait_power_on("gpu_ss0", clk_gpu_ss0_sys, gpu_ss0_pactive, gpu_ss0_paccept, gpu_ss0_pdeny);
        wait_power_on("cpu_ss", clk_cpu_ss_sys, cpu_ss_pactive, cpu_ss_paccept, cpu_ss_pdeny);
        wait_power_on("mcu_ss", clk_mcu_ss_sys, mcu_ss_pactive, mcu_ss_paccept, mcu_ss_pdeny);
        wait_power_on("peri_ss", clk_peri_ss_sys, peri_ss_pactive, peri_ss_paccept, peri_ss_pdeny);
        dsp_ss0_preq = 1'b0;
        dsp_ss1_preq = 1'b0;
        dsp_ss2_preq = 1'b0;
        dsp_ss3_preq = 1'b0;
        dsp_ss4_preq = 1'b0;
        dsp_ss5_preq = 1'b0;
        camera_ss_preq = 1'b0;
        mipi_ss_preq = 1'b0;
        gpu1_ss_preq = 1'b0;
        usb_dp_ss_preq = 1'b0;
        display_ss_preq = 1'b0;
        aon_ss_preq = 1'b0;
        gpu_ss0_preq = 1'b0;
        cpu_ss_preq = 1'b0;
        mcu_ss_preq = 1'b0;
        peri_ss_preq = 1'b0;
        repeat (10) @(posedge clk_noc);
        expected_valid_by_tid[7'd0] = 1'b1;
        expected_data_by_tid[7'd0] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0000;
        expected_valid_by_tid[7'd1] = 1'b1;
        expected_data_by_tid[7'd1] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0001;
        expected_valid_by_tid[7'd2] = 1'b1;
        expected_data_by_tid[7'd2] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0002;
        expected_valid_by_tid[7'd3] = 1'b1;
        expected_data_by_tid[7'd3] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0003;
        expected_valid_by_tid[7'd4] = 1'b1;
        expected_data_by_tid[7'd4] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0004;
        expected_valid_by_tid[7'd5] = 1'b1;
        expected_data_by_tid[7'd5] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0005;
        expected_valid_by_tid[7'd6] = 1'b1;
        expected_data_by_tid[7'd6] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0006;
        expected_valid_by_tid[7'd7] = 1'b1;
        expected_data_by_tid[7'd7] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0007;
        expected_valid_by_tid[7'd8] = 1'b1;
        expected_data_by_tid[7'd8] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0008;
        expected_valid_by_tid[7'd9] = 1'b1;
        expected_data_by_tid[7'd9] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0009;
        expected_valid_by_tid[7'd10] = 1'b1;
        expected_data_by_tid[7'd10] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_000A;
        expected_valid_by_tid[7'd11] = 1'b1;
        expected_data_by_tid[7'd11] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_000B;
        expected_valid_by_tid[7'd12] = 1'b1;
        expected_data_by_tid[7'd12] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_000C;
        expected_valid_by_tid[7'd13] = 1'b1;
        expected_data_by_tid[7'd13] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_000D;
        expected_valid_by_tid[7'd14] = 1'b1;
        expected_data_by_tid[7'd14] = 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_000E;

        $display("========== Phase 1: Trace smoke ==========");
        fork
            send_trace("dsp_ss0", 7'd0, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0000, clk_dsp_ss0_sys, dsp_ss0_s_atvalid, dsp_ss0_s_atready, dsp_ss0_s_atdata, dsp_ss0_s_atid, dsp_ss0_s_atbytes, dsp_ss0_s_atwakeup);
            send_trace("dsp_ss1", 7'd1, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0001, clk_dsp_ss1_sys, dsp_ss1_s_atvalid, dsp_ss1_s_atready, dsp_ss1_s_atdata, dsp_ss1_s_atid, dsp_ss1_s_atbytes, dsp_ss1_s_atwakeup);
            send_trace("dsp_ss2", 7'd2, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0002, clk_dsp_ss2_sys, dsp_ss2_s_atvalid, dsp_ss2_s_atready, dsp_ss2_s_atdata, dsp_ss2_s_atid, dsp_ss2_s_atbytes, dsp_ss2_s_atwakeup);
            send_trace("dsp_ss3", 7'd3, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0003, clk_dsp_ss3_sys, dsp_ss3_s_atvalid, dsp_ss3_s_atready, dsp_ss3_s_atdata, dsp_ss3_s_atid, dsp_ss3_s_atbytes, dsp_ss3_s_atwakeup);
            send_trace("dsp_ss4", 7'd4, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0004, clk_dsp_ss4_sys, dsp_ss4_s_atvalid, dsp_ss4_s_atready, dsp_ss4_s_atdata, dsp_ss4_s_atid, dsp_ss4_s_atbytes, dsp_ss4_s_atwakeup);
            send_trace("dsp_ss5", 7'd5, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0005, clk_dsp_ss5_sys, dsp_ss5_s_atvalid, dsp_ss5_s_atready, dsp_ss5_s_atdata, dsp_ss5_s_atid, dsp_ss5_s_atbytes, dsp_ss5_s_atwakeup);
            send_trace("camera_ss", 7'd6, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0006, clk_camera_ss_sys, camera_ss_s_atvalid, camera_ss_s_atready, camera_ss_s_atdata, camera_ss_s_atid, camera_ss_s_atbytes, camera_ss_s_atwakeup);
            send_trace("mipi_ss", 7'd7, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0007, clk_mipi_ss_sys, mipi_ss_s_atvalid, mipi_ss_s_atready, mipi_ss_s_atdata, mipi_ss_s_atid, mipi_ss_s_atbytes, mipi_ss_s_atwakeup);
            send_trace("gpu1_ss", 7'd8, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0008, clk_gpu1_ss_sys, gpu1_ss_s_atvalid, gpu1_ss_s_atready, gpu1_ss_s_atdata, gpu1_ss_s_atid, gpu1_ss_s_atbytes, gpu1_ss_s_atwakeup);
            send_trace("usb_dp_ss", 7'd9, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_0009, clk_usb_dp_ss_sys, usb_dp_ss_s_atvalid, usb_dp_ss_s_atready, usb_dp_ss_s_atdata, usb_dp_ss_s_atid, usb_dp_ss_s_atbytes, usb_dp_ss_s_atwakeup);
            send_trace("display_ss", 7'd10, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_000A, clk_display_ss_sys, display_ss_s_atvalid, display_ss_s_atready, display_ss_s_atdata, display_ss_s_atid, display_ss_s_atbytes, display_ss_s_atwakeup);
            send_trace("aon_ss", 7'd11, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_000B, clk_aon_ss_sys, aon_ss_s_atvalid, aon_ss_s_atready, aon_ss_s_atdata, aon_ss_s_atid, aon_ss_s_atbytes, aon_ss_s_atwakeup);
            send_trace("gpu_ss0", 7'd12, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_000C, clk_gpu_ss0_sys, gpu_ss0_s_atvalid, gpu_ss0_s_atready, gpu_ss0_s_atdata, gpu_ss0_s_atid, gpu_ss0_s_atbytes, gpu_ss0_s_atwakeup);
            send_trace("cpu_ss", 7'd13, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_000D, clk_cpu_ss_sys, cpu_ss_s_atvalid, cpu_ss_s_atready, cpu_ss_s_atdata, cpu_ss_s_atid, cpu_ss_s_atbytes, cpu_ss_s_atwakeup);
            send_trace("mcu_ss", 7'd14, 128'h0000_0000_0000_0000_A5A5_A5A5_A5A5_000E, clk_mcu_ss_sys, mcu_ss_s_atvalid, mcu_ss_s_atready, mcu_ss_s_atdata, mcu_ss_s_atid, mcu_ss_s_atbytes, mcu_ss_s_atwakeup);
        join

        fork
            begin : rx_timeout
                repeat (4000) @(posedge clk_noc);
                $fatal(1, "Timed out waiting for %0d sink packets, observed %0d", NUM_SOURCES, rx_count_total);
            end

            begin : rx_wait
                wait (rx_count_total == NUM_SOURCES);
            end
        join_any
        disable fork;

        $display("=== TRACE CHECK ===");
        $display("  TID  0 (dsp_ss0): got %0d packet(s)", rx_count_by_tid[7'd0]);
        if (rx_count_by_tid[7'd0] != 1) begin
            $fatal(1, "Expected exactly one packet for dsp_ss0 / tid 0, got %0d", rx_count_by_tid[7'd0]);
        end
        $display("  TID  1 (dsp_ss1): got %0d packet(s)", rx_count_by_tid[7'd1]);
        if (rx_count_by_tid[7'd1] != 1) begin
            $fatal(1, "Expected exactly one packet for dsp_ss1 / tid 1, got %0d", rx_count_by_tid[7'd1]);
        end
        $display("  TID  2 (dsp_ss2): got %0d packet(s)", rx_count_by_tid[7'd2]);
        if (rx_count_by_tid[7'd2] != 1) begin
            $fatal(1, "Expected exactly one packet for dsp_ss2 / tid 2, got %0d", rx_count_by_tid[7'd2]);
        end
        $display("  TID  3 (dsp_ss3): got %0d packet(s)", rx_count_by_tid[7'd3]);
        if (rx_count_by_tid[7'd3] != 1) begin
            $fatal(1, "Expected exactly one packet for dsp_ss3 / tid 3, got %0d", rx_count_by_tid[7'd3]);
        end
        $display("  TID  4 (dsp_ss4): got %0d packet(s)", rx_count_by_tid[7'd4]);
        if (rx_count_by_tid[7'd4] != 1) begin
            $fatal(1, "Expected exactly one packet for dsp_ss4 / tid 4, got %0d", rx_count_by_tid[7'd4]);
        end
        $display("  TID  5 (dsp_ss5): got %0d packet(s)", rx_count_by_tid[7'd5]);
        if (rx_count_by_tid[7'd5] != 1) begin
            $fatal(1, "Expected exactly one packet for dsp_ss5 / tid 5, got %0d", rx_count_by_tid[7'd5]);
        end
        $display("  TID  6 (camera_ss): got %0d packet(s)", rx_count_by_tid[7'd6]);
        if (rx_count_by_tid[7'd6] != 1) begin
            $fatal(1, "Expected exactly one packet for camera_ss / tid 6, got %0d", rx_count_by_tid[7'd6]);
        end
        $display("  TID  7 (mipi_ss): got %0d packet(s)", rx_count_by_tid[7'd7]);
        if (rx_count_by_tid[7'd7] != 1) begin
            $fatal(1, "Expected exactly one packet for mipi_ss / tid 7, got %0d", rx_count_by_tid[7'd7]);
        end
        $display("  TID  8 (gpu1_ss): got %0d packet(s)", rx_count_by_tid[7'd8]);
        if (rx_count_by_tid[7'd8] != 1) begin
            $fatal(1, "Expected exactly one packet for gpu1_ss / tid 8, got %0d", rx_count_by_tid[7'd8]);
        end
        $display("  TID  9 (usb_dp_ss): got %0d packet(s)", rx_count_by_tid[7'd9]);
        if (rx_count_by_tid[7'd9] != 1) begin
            $fatal(1, "Expected exactly one packet for usb_dp_ss / tid 9, got %0d", rx_count_by_tid[7'd9]);
        end
        $display("  TID 10 (display_ss): got %0d packet(s)", rx_count_by_tid[7'd10]);
        if (rx_count_by_tid[7'd10] != 1) begin
            $fatal(1, "Expected exactly one packet for display_ss / tid 10, got %0d", rx_count_by_tid[7'd10]);
        end
        $display("  TID 11 (aon_ss): got %0d packet(s)", rx_count_by_tid[7'd11]);
        if (rx_count_by_tid[7'd11] != 1) begin
            $fatal(1, "Expected exactly one packet for aon_ss / tid 11, got %0d", rx_count_by_tid[7'd11]);
        end
        $display("  TID 12 (gpu_ss0): got %0d packet(s)", rx_count_by_tid[7'd12]);
        if (rx_count_by_tid[7'd12] != 1) begin
            $fatal(1, "Expected exactly one packet for gpu_ss0 / tid 12, got %0d", rx_count_by_tid[7'd12]);
        end
        $display("  TID 13 (cpu_ss): got %0d packet(s)", rx_count_by_tid[7'd13]);
        if (rx_count_by_tid[7'd13] != 1) begin
            $fatal(1, "Expected exactly one packet for cpu_ss / tid 13, got %0d", rx_count_by_tid[7'd13]);
        end
        $display("  TID 14 (mcu_ss): got %0d packet(s)", rx_count_by_tid[7'd14]);
        if (rx_count_by_tid[7'd14] != 1) begin
            $fatal(1, "Expected exactly one packet for mcu_ss / tid 14, got %0d", rx_count_by_tid[7'd14]);
        end
        if (data_mismatch_seen) begin
            $fatal(1, "Trace data mismatch detected");
        end
        $display("PASS: trace packets from all active INIUs reached peri sink.");

        $display("========== Phase 2: Flush smoke ==========");
        peri_ss_m_afvalid <= 1'b1;
        fork
            begin : flush_timeout
                repeat (4000) @(posedge clk_noc);
                $fatal(1, "Timed out waiting for flush acknowledgements");
            end
            begin : flush_wait
                fork
                    begin
                        wait (dsp_ss0_s_afvalid === 1'b1);
                        flush_seen[0] = 1'b1;
                        $display("[%0t] FLUSH: dsp_ss0 accepted", $time);
                    end
                    begin
                        wait (dsp_ss1_s_afvalid === 1'b1);
                        flush_seen[1] = 1'b1;
                        $display("[%0t] FLUSH: dsp_ss1 accepted", $time);
                    end
                    begin
                        wait (dsp_ss2_s_afvalid === 1'b1);
                        flush_seen[2] = 1'b1;
                        $display("[%0t] FLUSH: dsp_ss2 accepted", $time);
                    end
                    begin
                        wait (dsp_ss3_s_afvalid === 1'b1);
                        flush_seen[3] = 1'b1;
                        $display("[%0t] FLUSH: dsp_ss3 accepted", $time);
                    end
                    begin
                        wait (dsp_ss4_s_afvalid === 1'b1);
                        flush_seen[4] = 1'b1;
                        $display("[%0t] FLUSH: dsp_ss4 accepted", $time);
                    end
                    begin
                        wait (dsp_ss5_s_afvalid === 1'b1);
                        flush_seen[5] = 1'b1;
                        $display("[%0t] FLUSH: dsp_ss5 accepted", $time);
                    end
                    begin
                        wait (camera_ss_s_afvalid === 1'b1);
                        flush_seen[6] = 1'b1;
                        $display("[%0t] FLUSH: camera_ss accepted", $time);
                    end
                    begin
                        wait (mipi_ss_s_afvalid === 1'b1);
                        flush_seen[7] = 1'b1;
                        $display("[%0t] FLUSH: mipi_ss accepted", $time);
                    end
                    begin
                        wait (gpu1_ss_s_afvalid === 1'b1);
                        flush_seen[8] = 1'b1;
                        $display("[%0t] FLUSH: gpu1_ss accepted", $time);
                    end
                    begin
                        wait (usb_dp_ss_s_afvalid === 1'b1);
                        flush_seen[9] = 1'b1;
                        $display("[%0t] FLUSH: usb_dp_ss accepted", $time);
                    end
                    begin
                        wait (display_ss_s_afvalid === 1'b1);
                        flush_seen[10] = 1'b1;
                        $display("[%0t] FLUSH: display_ss accepted", $time);
                    end
                    begin
                        wait (aon_ss_s_afvalid === 1'b1);
                        flush_seen[11] = 1'b1;
                        $display("[%0t] FLUSH: aon_ss accepted", $time);
                    end
                    begin
                        wait (gpu_ss0_s_afvalid === 1'b1);
                        flush_seen[12] = 1'b1;
                        $display("[%0t] FLUSH: gpu_ss0 accepted", $time);
                    end
                    begin
                        wait (cpu_ss_s_afvalid === 1'b1);
                        flush_seen[13] = 1'b1;
                        $display("[%0t] FLUSH: cpu_ss accepted", $time);
                    end
                    begin
                        wait (mcu_ss_s_afvalid === 1'b1);
                        flush_seen[14] = 1'b1;
                        $display("[%0t] FLUSH: mcu_ss accepted", $time);
                    end
                join
            end
        join_any
        disable fork;
        peri_ss_m_afvalid <= 1'b0;

        if (!flush_seen[0]) begin
            $fatal(1, "Flush did not reach dsp_ss0");
        end
        if (!flush_seen[1]) begin
            $fatal(1, "Flush did not reach dsp_ss1");
        end
        if (!flush_seen[2]) begin
            $fatal(1, "Flush did not reach dsp_ss2");
        end
        if (!flush_seen[3]) begin
            $fatal(1, "Flush did not reach dsp_ss3");
        end
        if (!flush_seen[4]) begin
            $fatal(1, "Flush did not reach dsp_ss4");
        end
        if (!flush_seen[5]) begin
            $fatal(1, "Flush did not reach dsp_ss5");
        end
        if (!flush_seen[6]) begin
            $fatal(1, "Flush did not reach camera_ss");
        end
        if (!flush_seen[7]) begin
            $fatal(1, "Flush did not reach mipi_ss");
        end
        if (!flush_seen[8]) begin
            $fatal(1, "Flush did not reach gpu1_ss");
        end
        if (!flush_seen[9]) begin
            $fatal(1, "Flush did not reach usb_dp_ss");
        end
        if (!flush_seen[10]) begin
            $fatal(1, "Flush did not reach display_ss");
        end
        if (!flush_seen[11]) begin
            $fatal(1, "Flush did not reach aon_ss");
        end
        if (!flush_seen[12]) begin
            $fatal(1, "Flush did not reach gpu_ss0");
        end
        if (!flush_seen[13]) begin
            $fatal(1, "Flush did not reach cpu_ss");
        end
        if (!flush_seen[14]) begin
            $fatal(1, "Flush did not reach mcu_ss");
        end
        $display("PASS: peri flush reached all active INIUs.");
        $display("========== SIM DONE ==========");
        #100;
        $finish;
    end

    initial begin : debug_early_finish
        early_finish_ps = 0;
        stop_after_dsp0_afifo_cycles = 0;
        stop_after_dsp0_afifo_stg2_cycles = 0;
        void'($value$plusargs("STOP_AFTER_DSP0_AFIFO_CYCLES=%d", stop_after_dsp0_afifo_cycles));
        void'($value$plusargs("STOP_AFTER_DSP0_AFIFO_STG2_CYCLES=%d", stop_after_dsp0_afifo_stg2_cycles));
        if ($value$plusargs("EARLY_FINISH_PS=%d", early_finish_ps) && (early_finish_ps > 0)) begin
            #(early_finish_ps);
            $display("[%0t] DBG EARLY FINISH at %0d ps", $time, early_finish_ps);
            $finish;
        end
    end

endmodule
