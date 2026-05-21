#include <iostream>
#include <string>
#include <vector>

int main() {
    std::vector<std::string> messageWords{
        "Hello", "C++", "World", "from", "VS Code", "and the C++ extension!"
    };

    for (const std::string& word : messageWords) {
        std::cout << word << " ";
    }
    std::cout << std::endl;
}
