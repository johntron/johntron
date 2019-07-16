#define CATCH_CONFIG_MAIN
#include "./catch.hpp"
#include "./add.cpp"

TEST_CASE( "add()", "" ) {
  REQUIRE( add(1, 2) == 3 );
}