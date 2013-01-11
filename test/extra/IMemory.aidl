package extra;
import extra.IMemoryHeap;
import import.ssize_t;
import import.size_t;


interface IMemory {
    IMemoryHeap getMemory(out ssize_t *  offset , out size_t *  size);
}
