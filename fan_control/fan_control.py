# Raspi fan control module based off CPU temp.
# Change FAN_PIN to the pin used in implementation (should be
# 12 or 13 on the pi 4 to allow for usage of hardware PWM)

import time
import subprocess
import gpiozero

FAN_PIN = 12
CHECK_DELAY_S = 30

# Fan is off until FAN_ON_TEMP_C and then duty cycle increases linearly
# (see pwm_curve function)
FAN_ON_TEMP_C = 30
PI_MAX_TEMP_C = 80

# Configure pin for PWM
fan = gpiozero.PWMOutputDevice(FAN_PIN, active_high=True, frequency=100)
fan.value = 0


def pwm_curve(temp):
    ''' Returns PWM duty cycle '''
    if(temp < FAN_ON_TEMP_C):
        return 0
    else:
        return (1 - (PI_MAX_TEMP_C - temp) / (PI_MAX_TEMP_C - FAN_ON_TEMP_C))


def fan_control():
    ''' Get CPU temp + change fan PWM as needed '''
    temp = subprocess.run(["vcgencmd", "measure_temp"], stdout=subprocess.PIPE)

    # Massage to get int value
    temp = str(temp.stdout)
    temp = float(temp[temp.index("=") + 1: temp.index("'")])

    print("Current CPU Temp: " + str(temp) + " °C")
    dc = pwm_curve(temp)
    fan.value = dc
    print("Changing fan duty cycle to " + str(dc))


def run():
    ''' Start, periodically call fan control '''
    fan_control()
    time.sleep(CHECK_DELAY_S)
    run()


if(__name__ == "__main__"):
    run()
