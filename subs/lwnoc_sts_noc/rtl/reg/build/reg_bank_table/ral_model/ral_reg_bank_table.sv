`ifndef RAL_REG_BANK_TABLE
`define RAL_REG_BANK_TABLE

import uvm_pkg::*;

class ral_reg_reg_bank_table_debug_en extends uvm_reg;
	rand uvm_reg_field debug_en;

	function new(string name = "reg_bank_table_debug_en");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.debug_en = uvm_reg_field::type_id::create("debug_en",,get_full_name());
      this.debug_en.configure(this, 32, 0, "RW", 0, 0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_reg_bank_table_debug_en)

endclass : ral_reg_reg_bank_table_debug_en


class ral_reg_reg_bank_table_timing_bus1 extends uvm_reg;
	rand uvm_reg_field timing_bus1;

	function new(string name = "reg_bank_table_timing_bus1");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.timing_bus1 = uvm_reg_field::type_id::create("timing_bus1",,get_full_name());
      this.timing_bus1.configure(this, 32, 0, "RW", 0, 0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_reg_bank_table_timing_bus1)

endclass : ral_reg_reg_bank_table_timing_bus1


class ral_reg_reg_bank_table_timing_bus2 extends uvm_reg;
	rand uvm_reg_field timing_bus2;

	function new(string name = "reg_bank_table_timing_bus2");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.timing_bus2 = uvm_reg_field::type_id::create("timing_bus2",,get_full_name());
      this.timing_bus2.configure(this, 32, 0, "RW", 0, 0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_reg_bank_table_timing_bus2)

endclass : ral_reg_reg_bank_table_timing_bus2


class ral_reg_reg_bank_table_timing_bus3 extends uvm_reg;
	rand uvm_reg_field timing_bus3;

	function new(string name = "reg_bank_table_timing_bus3");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.timing_bus3 = uvm_reg_field::type_id::create("timing_bus3",,get_full_name());
      this.timing_bus3.configure(this, 32, 0, "RW", 0, 0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_reg_bank_table_timing_bus3)

endclass : ral_reg_reg_bank_table_timing_bus3


class ral_reg_reg_bank_table_debug_data_gate extends uvm_reg;
	rand uvm_reg_field debug_data_gate;

	function new(string name = "reg_bank_table_debug_data_gate");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.debug_data_gate = uvm_reg_field::type_id::create("debug_data_gate",,get_full_name());
      this.debug_data_gate.configure(this, 32, 0, "RW", 0, 0, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_reg_bank_table_debug_data_gate)

endclass : ral_reg_reg_bank_table_debug_data_gate


class ral_block_reg_bank_table extends uvm_reg_block;
	rand ral_reg_reg_bank_table_debug_en debug_en;
	rand ral_reg_reg_bank_table_timing_bus1 timing_bus1;
	rand ral_reg_reg_bank_table_timing_bus2 timing_bus2;
	rand ral_reg_reg_bank_table_timing_bus3 timing_bus3;
	rand ral_reg_reg_bank_table_debug_data_gate debug_data_gate;
	rand uvm_reg_field debug_en_debug_en;
	rand uvm_reg_field timing_bus1_timing_bus1;
	rand uvm_reg_field timing_bus2_timing_bus2;
	rand uvm_reg_field timing_bus3_timing_bus3;
	rand uvm_reg_field debug_data_gate_debug_data_gate;

	function new(string name = "reg_bank_table");
		super.new(name, build_coverage(UVM_NO_COVERAGE));
	endfunction: new

   virtual function void build();
      this.default_map = create_map("", 0, 1024, UVM_LITTLE_ENDIAN, 0);
      this.debug_en = ral_reg_reg_bank_table_debug_en::type_id::create("debug_en",,get_full_name());
      this.debug_en.configure(this, null, "");
      this.debug_en.build();
         this.debug_en.add_hdl_path('{
            '{"debug_en_debug_en", 0, 32}
         });
      this.default_map.add_reg(this.debug_en, `UVM_REG_ADDR_WIDTH'h0, "RW", 0);
		this.debug_en_debug_en = this.debug_en.debug_en;
      this.timing_bus1 = ral_reg_reg_bank_table_timing_bus1::type_id::create("timing_bus1",,get_full_name());
      this.timing_bus1.configure(this, null, "");
      this.timing_bus1.build();
         this.timing_bus1.add_hdl_path('{
            '{"timing_bus1_timing_bus1", 0, 32}
         });
      this.default_map.add_reg(this.timing_bus1, `UVM_REG_ADDR_WIDTH'h4, "RW", 0);
		this.timing_bus1_timing_bus1 = this.timing_bus1.timing_bus1;
      this.timing_bus2 = ral_reg_reg_bank_table_timing_bus2::type_id::create("timing_bus2",,get_full_name());
      this.timing_bus2.configure(this, null, "");
      this.timing_bus2.build();
         this.timing_bus2.add_hdl_path('{
            '{"timing_bus2_timing_bus2", 0, 32}
         });
      this.default_map.add_reg(this.timing_bus2, `UVM_REG_ADDR_WIDTH'h8, "RW", 0);
		this.timing_bus2_timing_bus2 = this.timing_bus2.timing_bus2;
      this.timing_bus3 = ral_reg_reg_bank_table_timing_bus3::type_id::create("timing_bus3",,get_full_name());
      this.timing_bus3.configure(this, null, "");
      this.timing_bus3.build();
         this.timing_bus3.add_hdl_path('{
            '{"timing_bus3_timing_bus3", 0, 32}
         });
      this.default_map.add_reg(this.timing_bus3, `UVM_REG_ADDR_WIDTH'hC, "RW", 0);
		this.timing_bus3_timing_bus3 = this.timing_bus3.timing_bus3;
      this.debug_data_gate = ral_reg_reg_bank_table_debug_data_gate::type_id::create("debug_data_gate",,get_full_name());
      this.debug_data_gate.configure(this, null, "");
      this.debug_data_gate.build();
         this.debug_data_gate.add_hdl_path('{
            '{"debug_data_gate_debug_data_gate", 0, 32}
         });
      this.default_map.add_reg(this.debug_data_gate, `UVM_REG_ADDR_WIDTH'h10, "RW", 0);
		this.debug_data_gate_debug_data_gate = this.debug_data_gate.debug_data_gate;
   endfunction : build

	`uvm_object_utils(ral_block_reg_bank_table)

endclass : ral_block_reg_bank_table



`endif
