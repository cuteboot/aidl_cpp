package extra;
import extra.IMemoryHeap;


interface IMemory {
    IMemoryHeap getMemory(in long *  offset , in long *  size);
}
