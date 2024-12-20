#include <iostream>
#include <string>

int main() {
    int a = 0b101101;
    int b = 0b110011;

    int addResult = a & b;
    int sum = a + b;

    std::cout << addResult << std::endl;
    std::cout << sum << std::endl;

    return 0;
}