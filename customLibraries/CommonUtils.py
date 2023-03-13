from robot.api.deco import library, keyword
from decimal import *


@library
class CommonUtils:

    @keyword
    def round_half_up(self, x: float, num_decimals: int) -> float:
        x = str(x)
        if num_decimals < 0:
            raise ValueError("Num decimals needs to be at least 0.")
        target_precision = "1." + "0" * num_decimals
        print(target_precision)
        getcontext().rounding = ROUND_HALF_UP
        print(getcontext())
        rounded_x = float(Decimal(x).quantize(Decimal(target_precision), ROUND_HALF_UP))
        return rounded_x
