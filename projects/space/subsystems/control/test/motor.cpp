#define CATCH_CONFIG_MAIN
#include <catch.hpp>
//#include <fakeit.hpp>


//using namespace fakeit;

//class PinName {};
//class DigitalOut {
// public:
//  DigitalOut(PinName p) {};
//  DigitalOut operator =(int i) { return *this; };
//};
//class PwmOut {
// public:
//  PwmOut(PinName p) {};
//  PwmOut operator =(int i) { return *this; };
//};
//void wait_ms(int i) {};

#include <motor.cpp>
using namespace tb6612;

SCENARIO("Motor", ) {
  GIVEN("an instance") {
//    Mock<Motor> spy;
//    Spy(Method(mock, fwd));
//    Motor &m = mock.get();
    Motor m((PinName()), PinName(), PinName(), PinName());
    WHEN("::drive(speed)") {
      m.drive(0.5);
      REQUIRE(m.speed() == 0.5);
//      Verify(spy, fwd).Once();
    }
  }
}
