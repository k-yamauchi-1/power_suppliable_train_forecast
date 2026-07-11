#include <cstdint>

extern "C" {
    // Workaround for LNK2019 missing __std_find_first_of_trivial_pos_1
    uint64_t __cdecl __std_find_first_of_trivial_pos_1(const char* first, uint64_t count, const char* target, uint64_t target_count) {
        if (target_count == 0) return 0;
        for (uint64_t i = 0; i < count; ++i) {
            for (uint64_t j = 0; j < target_count; ++j) {
                if (first[i] == target[j]) return i;
            }
        }
        return static_cast<uint64_t>(-1); // Assuming not found is npos
    }

    uint64_t __cdecl __std_find_first_of_trivial_pos_8(const char* first, uint64_t count, const char* target, uint64_t target_count) {
        return __std_find_first_of_trivial_pos_1(first, count, target, target_count);
    }
}

extern "C" {
    // Workaround for LNK2019 missing _Avx2WmemEnabled
    bool _Avx2WmemEnabled = false;
}
