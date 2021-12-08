from six_pin_hbridge import Robot
from time import sleep

robot = Robot(left=(16, 20, 12), right=(19, 26, 13), standby=6)

for i in range(4):
    print('forward')
    robot.forward()
    sleep(1)
    print('forward (left 75%)')
    robot.forward(curve_left=0.75)
    sleep(1)
    print('forward (right 75%)')
    robot.forward(curve_right=0.75)
    sleep(1)
    print('backward')
    robot.backward()
    sleep(1)
    print('left')
    robot.left()
    sleep(1)
    print('right')
    robot.right()
    sleep(1)
    print('coast')
    robot.coast()
    sleep(1)




