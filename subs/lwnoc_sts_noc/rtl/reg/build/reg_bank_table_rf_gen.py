
import sys
sys.path.append('.')
from address_planner import *

regBank = RegSpace(name='reg_bank_table',size=8*KB,description="sts tniu regbank",bus_width=16,software_interface='apb')

################################debug_en#######################################

reg_0 = Register(name='debug_en',description="",reg_type=Normal)

reg_0.add(Field(name='debug_en',bit=32,sw_access=ReadWrite, hw_access=ReadOnly,init_value=0b0,description="" ),offset=0)

regBank.add(reg_0,offset=0x0)

################################timing_bus1#######################################

reg_1 = Register(name='timing_bus1',description="",reg_type=Normal)

reg_1.add(Field(name='timing_bus1',bit=32,sw_access=ReadWrite, hw_access=ReadOnly,init_value=0b0,description="" ),offset=0)

regBank.add(reg_1,offset=0x4)

################################timing_bus2#######################################

reg_2 = Register(name='timing_bus2',description="",reg_type=Normal)

reg_2.add(Field(name='timing_bus2',bit=32,sw_access=ReadWrite, hw_access=ReadOnly,init_value=0b0,description="" ),offset=0)

regBank.add(reg_2,offset=0x8)

################################timing_bus3#######################################

reg_3 = Register(name='timing_bus3',description="",reg_type=Normal)

reg_3.add(Field(name='timing_bus3',bit=32,sw_access=ReadWrite, hw_access=ReadOnly,init_value=0b0,description="" ),offset=0)

regBank.add(reg_3,offset=0xC)

################################debug_data_gate#######################################

reg_4 = Register(name='debug_data_gate',description="",reg_type=Normal)

reg_4.add(Field(name='debug_data_gate',bit=32,sw_access=ReadWrite, hw_access=ReadOnly,init_value=0b0,description="" ),offset=0)

regBank.add(reg_4,offset=0x10)

regBank.generate('build')

regBank.check('build')
