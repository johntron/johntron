from gpiozero.mixins import SourceMixin
from gpiozero.devices import CompositeDevice
from gpiozero.output_devices import DigitalOutputDevice, PWMOutputDevice
from gpiozero.exc import (GPIOPinMissing)


class Motor(CompositeDevice):
    forward_direction = 0
    backward_direction = 1

    def __init__(self, in1, in2, pwm):
        self._in1 = DigitalOutputDevice(pin=in1)
        self._in2 = DigitalOutputDevice(pin=in2)
        self._pwm = PWMOutputDevice(pin=pwm)
        self._speed = 0
        # self._direction = None
        super(Motor, self).__init__()

    # @property
    # def direction(self):
    #     return self._direction

    @property
    def speed(self):
        return self._speed

    @speed.setter
    def speed(self, speed):
        if not speed:
            return
        self._speed = speed

    def forward(self, speed=None):
        self.speed = speed
        self._in1.on()
        self._in2.off()
        self._pwm.value = self.speed
        # self._direction = self.forward_direction

    def backward(self, speed=None):
        self.speed = speed
        self._in1.off()
        self._in2.on()
        self._pwm.value = self.speed
        # self._direction = self.backward_direction

    def coast(self):
        self._in1.on()
        self._in2.on()

    def stop(self):
        self._in1.off()
        self._in2.off()


class Robot(SourceMixin, CompositeDevice):
    """
    Extends :class:`CompositeDevice` to represent a generic dual-motor robot.

    This class is constructed with two tuples representing the forward and
    backward pins of the left and right controllers respectively. For example,
    if the left motor's controller is connected to GPIOs 4 and 14, while the
    right motor's controller is connected to GPIOs 17 and 18 then the following
    example will drive the robot forward::

        from gpiozero import Robot

        robot = Robot(left=(4, 14), right=(17, 18))
        robot.forward()

    :param tuple left:
        A tuple of two (or three) GPIO pins representing the forward and
        backward inputs of the left motor's controller. Use three pins if your
        motor controller requires an enable pin.

    :param tuple right:
        A tuple of two (or three) GPIO pins representing the forward and
        backward inputs of the right motor's controller. Use three pins if your
        motor controller requires an enable pin.

    :param bool pwm:
        If :data:`True` (the default), construct :class:`PWMOutputDevice`
        instances for the motor controller pins, allowing both direction and
        variable speed control. If :data:`False`, construct
        :class:`DigitalOutputDevice` instances, allowing only direction
        control.

    :type pin_factory: Factory or None
    :param pin_factory:
        See :doc:`api_pins` for more information (this is an advanced feature
        which most users can ignore).

    .. attribute:: left_motor

        The :class:`Motor` on the left of the robot.

    .. attribute:: right_motor

        The :class:`Motor` on the right of the robot.
    """

    def __init__(self, left=None, right=None, standby: int = None, enable=True, pin_factory=None, *args):
        # *args is a hack to ensure a useful message is shown when pins are
        # supplied as sequential positional arguments e.g. 2, 3, 4, 5
        if not isinstance(left, tuple) or not isinstance(right, tuple):
            raise GPIOPinMissing('left and right motor pins must be given as '
                                 'tuples')

        if standby:
            print('Standby high')
            self.standby = DigitalOutputDevice(pin=standby)
            self.standby.on()

        super(Robot, self).__init__(
            left_motor=Motor(*left),
            right_motor=Motor(*right),
            _order=('left_motor', 'right_motor'),
            # pin_factory=pin_factory
        )

    @property
    def value(self):
        """
        Represents the motion of the robot as a tuple of (left_motor_speed,
        right_motor_speed) with ``(-1, -1)`` representing full speed backwards,
        ``(1, 1)`` representing full speed forwards, and ``(0, 0)``
        representing stopped.
        """
        return super(Robot, self).value

    @value.setter
    def value(self, value):
        self.left_motor.value, self.right_motor.value = value

    def forward(self, speed=1, **kwargs):
        """
        Drive the robot forward by running both motors forward.

        :param float speed:
            Speed at which to drive the motors, as a value between 0 (stopped)
            and 1 (full speed). The default is 1.

        :param float curve_left:
            The amount to curve left while moving forwards, by driving the
            left motor at a slower speed. Maximum *curve_left* is 1, the
            default is 0 (no curve). This parameter can only be specified as a
            keyword parameter, and is mutually exclusive with *curve_right*.

        :param float curve_right:
            The amount to curve right while moving forwards, by driving the
            right motor at a slower speed. Maximum *curve_right* is 1, the
            default is 0 (no curve). This parameter can only be specified as a
            keyword parameter, and is mutually exclusive with *curve_left*.
        """
        curve_left = kwargs.pop('curve_left', 0)
        curve_right = kwargs.pop('curve_right', 0)
        if kwargs:
            raise TypeError('unexpected argument %s' % kwargs.popitem()[0])
        if not 0 <= curve_left <= 1:
            raise ValueError('curve_left must be between 0 and 1')
        if not 0 <= curve_right <= 1:
            raise ValueError('curve_right must be between 0 and 1')
        if curve_left != 0 and curve_right != 0:
            raise ValueError("curve_left and curve_right can't be used at "
                             "the same time")
        self.left_motor.forward(speed * (1 - curve_left))
        self.right_motor.forward(speed * (1 - curve_right))

    def backward(self, speed=1, **kwargs):
        """
        Drive the robot backward by running both motors backward.

        :param float speed:
            Speed at which to drive the motors, as a value between 0 (stopped)
            and 1 (full speed). The default is 1.

        :param float curve_left:
            The amount to curve left while moving backwards, by driving the
            left motor at a slower speed. Maximum *curve_left* is 1, the
            default is 0 (no curve). This parameter can only be specified as a
            keyword parameter, and is mutually exclusive with *curve_right*.

        :param float curve_right:
            The amount to curve right while moving backwards, by driving the
            right motor at a slower speed. Maximum *curve_right* is 1, the
            default is 0 (no curve). This parameter can only be specified as a
            keyword parameter, and is mutually exclusive with *curve_left*.
        """
        curve_left = kwargs.pop('curve_left', 0)
        curve_right = kwargs.pop('curve_right', 0)
        if kwargs:
            raise TypeError('unexpected argument %s' % kwargs.popitem()[0])
        if not 0 <= curve_left <= 1:
            raise ValueError('curve_left must be between 0 and 1')
        if not 0 <= curve_right <= 1:
            raise ValueError('curve_right must be between 0 and 1')
        if curve_left != 0 and curve_right != 0:
            raise ValueError("curve_left and curve_right can't be used at "
                             "the same time")
        self.left_motor.backward(speed * (1 - curve_left))
        self.right_motor.backward(speed * (1 - curve_right))

    def left(self, speed=1):
        """
        Make the robot turn left by running the right motor forward and left
        motor backward.

        :param float speed:
            Speed at which to drive the motors, as a value between 0 (stopped)
            and 1 (full speed). The default is 1.
        """
        self.right_motor.forward(speed)
        self.left_motor.backward(speed)

    def right(self, speed=1):
        """
        Make the robot turn right by running the left motor forward and right
        motor backward.

        :param float speed:
            Speed at which to drive the motors, as a value between 0 (stopped)
            and 1 (full speed). The default is 1.
        """
        self.left_motor.forward(speed)
        self.right_motor.backward(speed)

    def reverse(self):
        """
        Reverse the robot's current motor directions. If the robot is currently
        running full speed forward, it will run full speed backward. If the
        robot is turning left at half-speed, it will turn right at half-speed.
        If the robot is currently stopped it will remain stopped.
        """
        self.left_motor.reverse()
        self.right_motor.reverse()

    def coast(self):
        self.left_motor.coast()
        self.right_motor.coast()

    def stop(self):
        """
        Stop the robot.
        """
        self.left_motor.stop()
        self.right_motor.stop()
