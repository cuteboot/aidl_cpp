package extra;
import import.GraphicBuffer;


interface IGraphicBufferAlloc {
    GraphicBuffer createGraphicBuffer(int w, int h, int format,
        int usage, out void *  error);
}
