#include <iostream>

class Animal {
  virtual void make_sound() {};
};

class Dog : Animal {
 public:
  Dog() {
     std::cout << "costructed" << std::endl;
  }

  void make_sound() {
    std::cout << "woof" << std::endl;
  }

  ~Dog() {
     std::cout << "descructed" << std::endl;
  }
};

class pointer {
 public:
  pointer(Dog* const ptr) : obj(ptr) {}

  ~pointer() {
    delete obj;
  }
  Dog* const obj;
};

int main() {
  {
    pointer p(new Dog());
    p.obj->make_sound();
  }
}
