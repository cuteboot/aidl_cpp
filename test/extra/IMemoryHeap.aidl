package extra;
import import.status_t;
import import.ssize_t;

interface IMemoryHeap {
    status_t getHeapID(out int *fd, out ssize_t * size, out int *flags, out int *offset);
}
