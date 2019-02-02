from migen import *
from migen.build.generic_platform import *
from migen.build.xilinx import XilinxPlatform

#
# platform
#

_io = [
    ("user_led",  0, Pins("P56"), IOStandard("LVCMOS33")),

    ("clk100", 0, Pins("P84"), IOStandard("LVCMOS33")),
]


class Platform(XilinxPlatform):
    default_clk_name = "clk100"
    default_clk_period = 20.0

    def __init__(self):
        XilinxPlatform.__init__(self, "xc6slx4-2tqg144", _io, toolchain="ise")

    def do_finalize(self, fragment):
        XilinxPlatform.do_finalize(self, fragment)

#
# design
#


# create our platform (fpga interface)
platform = Platform()
led = platform.request("user_led")

# create our module (fpga description)
module = Module()

# create a counter and blink a led
counter = Signal(26)
module.comb += led.eq(counter[25])
module.sync += counter.eq(counter + 1)

#
# build
#

platform.build(module)
