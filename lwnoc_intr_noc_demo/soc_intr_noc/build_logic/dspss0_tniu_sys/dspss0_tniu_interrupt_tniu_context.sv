module dspss0_tniu_interrupt_tniu_context
    import dspss0_tniu_interrupt_tniu_pkg::*;
#(
    parameter integer unsigned  INTERRUPT_NUM       = 4096,
    localparam integer unsigned INTERRUPT_NUM_WIDTH = $clog2(INTERRUPT_NUM)
)(
    input  logic                            clk,
    input  logic                            rst_n,

    output logic                            context_pre_alloc_vld,
    input  logic                            context_pre_alloc_rdy,
    output logic [CONTEXT_NUM_WIDTH-1   :0] context_pre_alloc_id,

    input  logic                            context_en,
    input  event_pkg                        context_pld,

    output logic [INTERRUPT_NUM-1       :0] v_context_intr_en,
    output                                  context_intr_toggle_flag

);

//==============================================================
// logic declarations
//==============================================================

    logic                                   alloc_context_vld;
    logic                                   alloc_context_rdy;
    logic                                   context_head;
    logic                                   context_intr_vld;
    logic                                   context_intr_rdy;

    logic [CONTEXT_NUM-1                :0] v_entry_idle;
    logic [CONTEXT_NUM-1                :0] alloc_context_oh;
    logic [CONTEXT_NUM_WIDTH-1          :0] alloc_context_id;
    logic [CONTEXT_NUM-1                :0] v_context_alloc_en;
    logic [CONTEXT_NUM_WIDTH-1          :0] advanced_context_id;
    logic [CONTEXT_NUM-1                :0] v_context_tail;
    logic [CONTEXT_NUM-1                :0] v_context_tail_cancel;
    logic [CONTEXT_NUM-1                :0] v_entry_rel_vld;
    logic [CONTEXT_NUM-1                :0] v_entry_rel_rdy;
    logic [CONTEXT_NUM-1                :0] v_entry_rel_oh;
    logic [CONTEXT_NUM-1                :0] v_context_intr_vld;
    logic [CONTEXT_NUM-1                :0] v_context_intr_rdy;
    logic [CONTEXT_NUM-1                :0] v_context_en;
    logic [INTERRUPT_NUM-1              :0] v_context_intr_id_oh;
    logic [$bits(intr_repeater_pkg)-1   :0] context_intr_pld_data;
    logic [$bits(intr_repeater_pkg)-1   :0] v_context_intr_pld_data [CONTEXT_NUM-1:0];
    logic [INTERRUPT_NUM_WIDTH-1        :0] v_context_intr_id       [CONTEXT_NUM-1:0];
    intr_repeater_pkg                       v_context_intr_pld      [CONTEXT_NUM-1:0];
    intr_repeater_pkg                       context_intr_pld;

    //==============================================================
    // context pre-allocation
    //==============================================================
    fcip_lead_one #(
        .ENTRY_NUM(CONTEXT_NUM)
    ) u_fcip_lead_one (
        .v_entry_vld   (v_entry_idle        ),
        .v_free_idx_oh (alloc_context_oh    ),
        .v_free_idx_bin(alloc_context_id    ),
        .v_free_vld    (alloc_context_vld   )
    );

    assign v_context_alloc_en = alloc_context_oh & {CONTEXT_NUM{alloc_context_rdy}};


    fcip_reg_slice #(
        .PLD_TYPE(logic [CONTEXT_NUM_WIDTH-1:0] ),
        .RS_TYPE (0                             )
    ) u_reg_slice (
        .clk           (clk                  ),
        .rst_n         (rst_n                ),
        .s_vld         (alloc_context_vld    ),
        .s_rdy         (alloc_context_rdy    ),
        .s_pld         (alloc_context_id     ),
        .m_vld         (context_pre_alloc_vld),
        .m_rdy         (context_pre_alloc_rdy),
        .m_pld         (context_pre_alloc_id )
    );

    //==============================================================
    // context gen
    //==============================================================

    generate
        for(genvar i = 0; i < CONTEXT_NUM; i = i + 1) begin : CONTEXT_ENTRY
            assign v_context_en[i] = context_en && (context_pld.context_id == i);
            dspss0_tniu_interrupt_tniu_context_entry #(
                .INTERRUPT_NUM  (INTERRUPT_NUM          )
            )u_interrupt_tniu_context_entry (
                .clk                    (clk                        ),
                .rst_n                  (rst_n                      ),
                .entry_idle             (v_entry_idle[i]            ),
                .entry_alloc_en         (v_context_alloc_en[i]      ),
                .context_en             (v_context_en[i]            ),
                .context_pld            (context_pld                ),
                .context_head           (context_head               ),
                .advanced_context_id    (advanced_context_id        ),
                .context_intr_id        (v_context_intr_id[i]       ),
                .context_tail           (v_context_tail[i]          ),
                .context_tail_cancel    (v_context_tail_cancel[i]   ),
                .entry_rel_vld          (v_entry_rel_vld[i]         ),
                .entry_rel_rdy          (v_entry_rel_rdy[i]         ),
                .v_link_rel_en          (v_entry_rel_oh             ),
                .intr_vld               (v_context_intr_vld[i]      ),
                .intr_rdy               (v_context_intr_rdy[i]      ),
                .intr_pld               (v_context_intr_pld[i]      )
            );
            assign v_context_tail_cancel[i] = (v_context_intr_id[i] == context_pld.tgt_intr_id) && context_en && v_context_tail[i];
            assign v_context_intr_pld_data[i] = v_context_intr_pld[i];
        end
    endgenerate


    assign context_head = ~|v_context_tail_cancel;
    fcip_onehot2bin #(
        .ONEHOT_WIDTH(CONTEXT_NUM)
    ) u_tail_onehot2bin (
        .onehot_in  (v_context_tail_cancel    ),
        .bin_out    (advanced_context_id      )
    );

    fcip_lead_one #(
        .ENTRY_NUM(CONTEXT_NUM)
    ) u_arb_rel (
        .v_entry_vld   (v_entry_rel_vld     ),
        .v_free_idx_oh (v_entry_rel_oh      ),
        .v_free_idx_bin(                    ),
        .v_free_vld    (                    )
    );
    assign v_entry_rel_rdy = v_entry_rel_oh;

    //==============================================================
    // interrupt output
    //==============================================================

    fcip_arb_vrp #(
        .WIDTH(CONTEXT_NUM),
        .PLD_WIDTH($bits(intr_repeater_pkg)),
        .MODE(1) // 0: fp, 1: rr, 2: age
    ) u_arb (
        .clk        (clk                  ),
        .rst_n      (rst_n                ),
        .v_vld_s    (v_context_intr_vld   ),
        .v_rdy_s    (v_context_intr_rdy   ),
        .v_pld_s    (v_context_intr_pld_data),
        .vld_m      (context_intr_vld     ),
        .pld_m      (context_intr_pld_data),
        .rdy_m      (context_intr_rdy     )
    );

    assign context_intr_rdy = 1'b1;
    assign context_intr_pld = intr_repeater_pkg'(context_intr_pld_data);

    fcip_bin2onehot #(
        .BIN_WIDTH(INTERRUPT_NUM_WIDTH)
    ) u_intr_bin2onehot (
        .bin_in     (INTERRUPT_NUM_WIDTH'(context_intr_pld.tgt_intr_id)),
        .onehot_out (v_context_intr_id_oh        )
    );

    assign v_context_intr_en = v_context_intr_id_oh & {INTERRUPT_NUM{context_intr_vld}};
    assign context_intr_toggle_flag = context_intr_pld.toggle_flag;



endmodule
