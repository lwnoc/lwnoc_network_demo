module dsp_ss0_trig_ctrl_fsm
(
    input   logic clk,
    input   logic rst_n,
    output  logic req_out,
    input   logic req_in,
    input   logic done
);
    typedef enum logic [1:0] {
        IDLE,
        TRIGGER,
        DONE
    } fsm_state_t;

    fsm_state_t cur, nxt;

    always_comb begin
        case (cur)
            IDLE: nxt = req_in ? TRIGGER : IDLE;
            TRIGGER: nxt = done? DONE:TRIGGER;
            DONE: nxt = done ? DONE : IDLE;
            default: nxt = IDLE;
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) cur <= IDLE;
        else cur <= nxt;
    end

    assign req_out = (cur == TRIGGER);
    
endmodule